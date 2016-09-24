package admin.item.model.dao;

import static common.JDBCTemplate.*;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import admin.item.model.vo.Category;
import admin.item.model.vo.Item;
import admin.item.model.vo.Vender;

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

	public ArrayList<Category> getCategory(Connection con) {
		System.out.println("category dao구동..");
		ArrayList<Category> category = null;
		
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from item_category";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			boolean onoff = true;
			while(rset.next()){
				if(onoff){
					category = new ArrayList<Category>();
					onoff = false;
				}
				Category c = new Category();
				c.setItemCategoryNo(rset.getInt("item_category_no"));
				c.setItemCategoryName(rset.getString("item_category_name"));	
				category.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return category;
	}

	public ArrayList<Vender> getVender(Connection con) {
		System.out.println("category dao구동..");
		ArrayList<Vender> vender = null;
		
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from vender";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			boolean onoff = true;
			while(rset.next()){
				if(onoff){
					vender = new ArrayList<Vender>();
					onoff = false;
				}
				Vender v = new Vender();
				v.setVenId(rset.getInt("ven_id"));
				v.setVenName(rset.getString("ven_name"));
				vender.add(v);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return vender;
	}

	public int insertItem(Connection con, Item item) {
		int result = 0;
		
		PreparedStatement pstmt = null;
		String query = "insert into item values (seq_item_no.nextval,"
				+ " ?, ?, ?, 0, sysdate, ?, ?, '썸네일 이미지 주소', '메인 이미지 주소', '설명 이미지 주소')";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, item.getItemName());
			pstmt.setInt(2, item.getItemCatNo());
			pstmt.setInt(3, item.getItemPrice());
			pstmt.setInt(4, item.getItemVender());
			pstmt.setString(5, item.getItemTag());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int getItemNo(Connection con, Item item) {
		int itemNo = 0;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select item_no from item where item_name = ? and item_cat_no = ? "
				+ "and item_price = ? and item_vender = ? "
				+ "and item_tag = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, item.getItemName());
			pstmt.setInt(2, item.getItemCatNo());
			pstmt.setInt(3, item.getItemPrice());
			pstmt.setInt(4, item.getItemVender());
			pstmt.setString(5, item.getItemTag());
			
			rset = pstmt.executeQuery();
			if(rset.next()){
				itemNo = rset.getInt("item_no");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		System.out.println("dao : "+itemNo);
		return itemNo;
	}

	public int updateFileName(Connection con, Item fitem) {
		int fresult = 0;
		PreparedStatement pstmt = null;
		
		String query = "update item set item_img_mini = ?, item_img = ?, "
				+ "item_img_detail = ? where item_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, fitem.getItemImgMini());
			pstmt.setString(2, fitem.getItemImg());
			pstmt.setString(3, fitem.getItemImgDetail());
			pstmt.setInt(4, fitem.getItemNo());
			
			fresult = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return fresult;
	}

	public Item selectOne(Connection con, int itemNo) {
		System.out.println("selectOne dao구동..");
		
		Item item = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from item where item_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, itemNo);
			
			rset = pstmt.executeQuery();
			if(rset.next()){
				item = new Item();
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
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return item;
	}

	public int updateItem(Connection con, Item item) {
		System.out.println("update dao 구동..");
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		String query = "update item set item_name = ?, item_cat_no = ?, item_price = ?, item_update = sysdate, "
				+ "item_vender = ?, item_tag = ?, item_img_mini = ?, item_img = ?, item_img_detail = ? "
				+ "where item_no = ?";
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, item.getItemName());
			pstmt.setInt(2, item.getItemCatNo());
			pstmt.setInt(3, item.getItemPrice());
			pstmt.setInt(4, item.getItemVender());
			pstmt.setString(5, item.getItemTag());
			pstmt.setString(6, item.getItemImgMini());
			pstmt.setString(7, item.getItemImg());
			pstmt.setString(8, item.getItemImgDetail());
			pstmt.setInt(9, item.getItemNo());
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteOne(Connection con, int itemNo) {
		System.out.println("삭제 dao 구동...");
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from item where item_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, itemNo);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	public ArrayList<Item> selectId(Connection con, int keyword) {
		ArrayList<Item> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from item where item_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, keyword);
			
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
