package order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import item.model.vo.SubItem;
import order.vo.Order;

import static common.JDBCTemplate.*;

public class OrderDao {

	public OrderDao() {
		// TODO Auto-generated constructor stub
	}

	public ArrayList<Order> selectOrders(Connection con, ArrayList<SubItem> subItemList) {
		ArrayList<Order> orderedSubItemList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select order_item_sub_no, item_sub_name, purchase_m_id "
				+ "from orders join purchase on (order_purchase_no = purchase_no) "
				+ "join item_sub on (order_item_sub_no = item_sub_no) "
				+ "where order_item_sub_no = ?";
		
		try {
			orderedSubItemList = new ArrayList<Order>();
			
			for(int i = 0; i < subItemList.size(); i++){
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1, subItemList.get(i).getItemSubNo());
				
				rset = pstmt.executeQuery();
				
				while(rset.next()){
					Order order = new Order();
					order.setItem_sub_no(rset.getInt("order_item_sub_no"));
					order.setItem_sub_name(rset.getString("item_sub_name"));
					order.setM_id(rset.getString("purchase_m_id"));
					
					orderedSubItemList.add(order);
				}
			}	
		} catch (Exception e) {
			System.out.println("구매제품리스트 조회 Dao 실패");
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return orderedSubItemList;
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

	public int insertOrder(Connection con, int purchaseNo, int item_sub_no, int quantity) {
		int result = 0;

		PreparedStatement pstmt = null;

		String sql = "insert into orders values(seq_order_no.nextval, ?, ?, ?, null)";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, purchaseNo);
			pstmt.setInt(2, item_sub_no);
			pstmt.setInt(3, quantity);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

}
