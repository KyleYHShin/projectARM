package admin.item.model.dao;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import admin.item.model.vo.Item;

public class ItemDao {

	public ArrayList<Item> selectAll(Connection con) {
		ArrayList<Item> list = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from item";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<Item>();
					flag = false;
				}
				Item item = new Item();
				item.setItemNo(rset.getInt("item_no"));
				item.setItemName(rset.getString("item_name"));
				item.setItemCatNo(rset.getInt("item_cat_no"));
				item.setItemPrice(rset.getInt("item_price"));
				item.setItemCount(rset.getInt("item_count"));
				item.setItemUpdate(rset.getDate("item_update"));
				item.setItemVender(rset.getInt("item_vender"));
				item.setItemImgMini(rset.getString("item_img_mini"));
				item.setItemImg(rset.getString("item_img"));
				item.setItemImgDetail(rset.getString("item_img_detail"));
				item.setItemTag(rset.getString("item_tag"));
				
				list.add(item);
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally{
			close(rset);
			close(stmt);
		}
		return list;
	}

	public ArrayList<Item> selectId(Connection con, int itemNo) {
		ArrayList<Item> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from item where item_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, itemNo);
			
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<Item>();
					flag = false;
				}
		
			Item item = new Item();
			item.setItemNo(rset.getInt("item_no"));
			item.setItemName(rset.getString("item_name"));
			item.setItemCatNo(rset.getInt("item_cat_no"));
			item.setItemPrice(rset.getInt("item_price"));
			item.setItemCount(rset.getInt("item_count"));
			item.setItemUpdate(rset.getDate("item_update"));
			item.setItemVender(rset.getInt("item_vender"));
			item.setItemTag(rset.getString("item_tag"));
			item.setItemImgMini(rset.getString("item_img_mini"));
			item.setItemImg(rset.getString("item_img"));
			item.setItemImgDetail(rset.getString("item_img_detail"));
			
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

	public ArrayList<Item> selectName(Connection con, String keyword) {
		ArrayList<Item> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from item where item_name like ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+ keyword +"%");
			
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<Item>();
					flag = false;
				}
		
			Item item = new Item();
			
			item.setItemNo(rset.getInt("item_no"));
			item.setItemName(rset.getString("item_name"));
			item.setItemCatNo(rset.getInt("item_cat_no"));
			item.setItemPrice(rset.getInt("item_price"));
			item.setItemCount(rset.getInt("item_count"));
			item.setItemUpdate(rset.getDate("item_update"));
			item.setItemVender(rset.getInt("item_vender"));
			item.setItemTag(rset.getString("item_tag"));
			item.setItemImgMini(rset.getString("item_img_mini"));
			item.setItemImg(rset.getString("item_img"));
			item.setItemImgDetail(rset.getString("item_img_detail"));
			
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

	public ArrayList<Item> selectTag(Connection con, String keyword) {
		ArrayList<Item> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from item where item_tag like ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+keyword +"%");
			
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<Item>();
					flag = false;
				}
				
			Item item = new Item();
			
			item.setItemNo(rset.getInt("item_no"));
			item.setItemName(rset.getString("item_name"));
			item.setItemCatNo(rset.getInt("item_cat_no"));
			item.setItemPrice(rset.getInt("item_price"));
			item.setItemCount(rset.getInt("item_count"));
			item.setItemUpdate(rset.getDate("item_update"));
			item.setItemVender(rset.getInt("item_vender"));
			item.setItemTag(rset.getString("item_tag"));
			item.setItemImgMini(rset.getString("item_img_mini"));
			item.setItemImg(rset.getString("item_img"));
			item.setItemImgDetail(rset.getString("item_img_detail"));
			
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
