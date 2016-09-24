package admin.subitem.model.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import admin.subitem.model.vo.SubItem;

public class SubItemDao {

	public SubItemDao() {
		// TODO Auto-generated constructor stub
	}

	public ArrayList<SubItem> selectAll(Connection con, int itemNo) {
		ArrayList<SubItem> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from Item_sub join item_bridge using(item_sub_no) join item using(item_no) where item_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, itemNo);
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<SubItem>();
					flag = false;
				}
				SubItem item = new SubItem();
				item.setItemSubNo(rset.getInt("item_sub_no"));
				item.setItemSubName(rset.getString("item_sub_name"));
				item.setItemSubPrice(rset.getInt("item_sub_price"));
				item.setQuantity(rset.getInt("quantity"));
				
				list.add(item);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(pstmt);
		}
		return list;
	}	
	
}

