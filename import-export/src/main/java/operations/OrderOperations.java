package operations;

import java.util.List;

import models.Order;

public interface OrderOperations {
	List<Order> getOrdersBySeller(String sellerPortId) throws Exception;

	String updateOrderStatus(int orderId, Boolean shipped, Boolean outForDelivery, Boolean delivered) throws Exception;
}
