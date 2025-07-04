package implementors;

import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import db_config.DbConnection;
import models.Order;
import operations.OrderOperations;

public class OrderImplementor implements OrderOperations {
	@Override
	public List<Order> getOrdersBySeller(String sellerPortId) throws Exception {
		List<Order> orders = new ArrayList<>();
		try (Connection conn = DbConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL view_seller_orders(?)}")) {
			stmt.setString(1, sellerPortId);
			ResultSet rs = stmt.executeQuery();
			while (rs.next()) {
				Order o = new Order();
				o.setOrderId(rs.getInt("order_id"));
				o.setProductId(rs.getInt("product_id"));
				o.setConsumerPortId(rs.getString("consumer_port_id"));
				o.setSellerPortId(rs.getString("seller_port_id"));
				o.setQuantity(rs.getInt("quantity"));
				o.setOrderDate(rs.getDate("order_date"));
				o.setOrderPlaced(rs.getBoolean("order_placed"));
				o.setShipped(rs.getBoolean("shipped"));
				o.setOutForDelivery(rs.getBoolean("out_for_delivery"));
				o.setDelivered(rs.getBoolean("delivered"));
				o.setProductName(rs.getString("product_name"));
				o.setPrice(rs.getDouble("price"));
				orders.add(o);
			}
		}
		return orders;
	}

	@Override
	public String updateOrderStatus(int orderId, Boolean shipped, Boolean outForDelivery, Boolean delivered)
			throws Exception {
		String result = "";
		try (Connection conn = DbConnection.getConnection();
				CallableStatement stmt = conn.prepareCall("{CALL update_order_status(?, ?, ?, ?)}")) {
			stmt.setInt(1, orderId);
			if (shipped != null)
				stmt.setBoolean(2, shipped);
			else
				stmt.setNull(2, Types.BOOLEAN);
			if (outForDelivery != null)
				stmt.setBoolean(3, outForDelivery);
			else
				stmt.setNull(3, Types.BOOLEAN);
			if (delivered != null)
				stmt.setBoolean(4, delivered);
			else
				stmt.setNull(4, Types.BOOLEAN);

			ResultSet rs = stmt.executeQuery();
			if (rs.next()) {
				result = rs.getString("status_message");
			}
		}
		return result;
	}
}
