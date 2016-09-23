package order.dao;

import static common.JDBCTemplate.*;

import java.sql.*;
import java.util.ArrayList;

import order.vo.Order;

public class OrderDao {

	public OrderDao() {
		// TODO Auto-generated constructor stub
	}

	public ArrayList<Order> selectAll(Connection con, int purchase_no) {
		ArrayList<Order> orderList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String sql = "select order_no, item.item_no, item_name, item_sub.item_sub_no, item_sub_name, order_review_no, "
				+ " order_qty, " 
				+ " ((item_price+item_sub_price)*order_qty) as order_pirce "
				+ " from orders " 
				+ " left join item_sub on (item_sub_no = order_item_sub_no) "
				+ " left join Item_Bridge on (Item_Bridge.item_sub_no = item_sub.item_sub_no) "
				+ " left join item on (item.item_no = item_bridge.item_no) "
				+ " where order_purchase_no = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, purchase_no);

			rset = pstmt.executeQuery();

			boolean flag = true;

			while (rset.next()) {
				if (flag) {
					orderList = new ArrayList<Order>();
					flag = false;
				}
				Order order = new Order();
				
				order.setOrder_no(rset.getInt("order_no"));
				
				order.setItem_no(rset.getInt("item_no"));
				order.setItem_name(rset.getString("item_name"));
				
				order.setItem_sub_no(rset.getInt("item_sub_no"));
				order.setItem_sub_name(rset.getString("item_sub_name"));
				
				order.setOrder_qty(rset.getInt("order_qty"));
				order.setOrder_price(rset.getInt("order_pirce"));
				order.setOrder_review_no(rset.getInt("order_review_no"));
				
				orderList.add(order);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return orderList;
	}

}
