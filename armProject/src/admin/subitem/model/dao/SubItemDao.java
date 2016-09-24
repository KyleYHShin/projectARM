package admin.subitem.model.dao;

import static common.JDBCTemplate.*;

import java.sql.CallableStatement;
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

	public int insertSubItem(Connection con, int itemNo, SubItem subItem) {
		System.out.println("서브아이템 추가 dao 작동..");
		int result = 0;
		
		CallableStatement cstmt = null;
		
		String query = "{call insert_item_sub(?,?,?,?)}";
		try {
			cstmt = con.prepareCall(query);
			cstmt.setInt(1, itemNo);
			cstmt.setString(2, subItem.getItemSubName());
			cstmt.setInt(3, subItem.getItemSubPrice());
			cstmt.setInt(4, subItem.getQuantity());
			
			result = cstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(cstmt);
		}
		return result;
	}

	public int deleteOne(Connection con, int itemSubNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from item_sub where item_sub_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, itemSubNo);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public SubItem selectOne(Connection con, int itemSubNo) {
		SubItem subItem = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from item_sub where item_sub_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, itemSubNo);
			
			rset = pstmt.executeQuery();
			if(rset.next()){
				subItem = new SubItem();
				subItem.setItemSubNo(rset.getInt("item_sub_no"));
				subItem.setItemSubName(rset.getString("item_sub_name"));
				subItem.setItemSubPrice(rset.getInt("item_sub_price"));
				subItem.setQuantity(rset.getInt("quantity"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return subItem;
	}

	public int updateOne(Connection con, SubItem subItem) {
		System.out.println("subitem update dao 구동..");
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update item_sub set item_sub_name = ?, item_sub_price = ?, quantity = ? where item_sub_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, subItem.getItemSubName());
			pstmt.setInt(2, subItem.getItemSubPrice());
			pstmt.setInt(3, subItem.getQuantity());
			pstmt.setInt(4, subItem.getItemSubNo());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}	
	
}

