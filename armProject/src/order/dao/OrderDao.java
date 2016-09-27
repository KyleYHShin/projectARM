package order.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
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

}
