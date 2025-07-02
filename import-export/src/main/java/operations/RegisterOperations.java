package operations;

import db_config.DbConnection;
import models.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RegisterOperations {

	public boolean insert(User u) throws Exception {
		String sql = "{call register_user(?, ?, ?, ?, ?)}";
		Connection c = DbConnection.getConnection();
		CallableStatement p = c.prepareCall(sql);
		p.setString(1, u.getPortId());
		p.setString(2, u.getPassword());
		p.setString(3, u.getConfirmPassword());
		p.setString(4, u.getLocation());
		p.setString(5, u.getRole());
		return p.executeUpdate() == 1;
	}

	/* READ single */
	public User find(String id, String role) throws Exception {
		String sql = "";

		if (role.equalsIgnoreCase("consumer")) {
			sql = "{call view_consumer(?, ?, ?, ?)}";
		} else if (role.equalsIgnoreCase("seller")) {
			sql = "{call view_seller(?, ?, ?, ?)}";
		} else {
			throw new IllegalArgumentException("Invalid role: " + role);
		}

		Connection c = DbConnection.getConnection();
		CallableStatement p = null;
		System.out.println(role);
		if(role.equals("consumer")) {
			p = c.prepareCall("{call view_consumer(?)}");
			p.setString(1, id);
		}
		else {
			p = c.prepareCall("{call view_seller(?)}");
			p.setString(1, id);
		}
		ResultSet rs = p.executeQuery();
		if (rs.next()) {
			return new User(rs.getString("port_id"), rs.getString("password"), rs.getString("password"),
					rs.getString("location"), rs.getString("role"));
		}

		return null;
	}

	/* UPDATE */
	public boolean update(User u) throws Exception {
		String sql = "UPDATE users SET password=?, role=? WHERE port_id=?";
		Connection c = DbConnection.getConnection();
		CallableStatement p = c.prepareCall(sql);
		p.setString(1, u.getPassword());
		p.setString(2, u.getRole());
		p.setString(3, u.getPortId());
		return p.executeUpdate() == 1;

	}

	/* DELETE */
	public boolean delete(int id) throws Exception {
		try (Connection c = DbConnection.getConnection();
				PreparedStatement p = c.prepareStatement("DELETE FROM users WHERE port_id=?")) {
			p.setInt(1, id);
			return p.executeUpdate() == 1;
		}
	}

	/* READ all (optional) */
	public List<User> all() throws Exception {
		List<User> list = new ArrayList<>();
		Connection c = DbConnection.getConnection();
		Statement s = c.createStatement();
		ResultSet rs = s.executeQuery("SELECT * FROM users");
		while (rs.next()) {
			list.add(new User(rs.getString("port_id"), rs.getString("password"), rs.getString("password"),
					rs.getString("location"), rs.getString("role")));
		}
		return list;
	}
}
