package item.model.dao;

import java.sql.*;
import java.util.ArrayList;
import static common.JDBCTemplate.*;
import item.model.vo.Item;

public class ItemDao {

	public ItemDao(){}

	public ArrayList<Item> selectMainList(Connection con, String sort_col) {
		//전체상품목록 불러오기
		ArrayList<Item> list = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		
		String query = "select * from product_main p left join item i on(p.PRM_ITEM_NO = i.ITEM_NO) order by prm_no";
		String sort = "select * from product_main p left join item i on(p.PRM_ITEM_NO = i.ITEM_NO)" + sort_col;
		
		try {
			stmt = con.createStatement();
			if(sort_col == null){
				rset = stmt.executeQuery(query);
			}else{
				rset = stmt.executeQuery(sort);
			}
			boolean onoff = true;
			while(rset.next()){
				if(onoff){
					//객체생성을 한번만 하도록
					list = new ArrayList<Item>();
					onoff = false;
				}
				Item item = new Item();
				//필요없는건 제외하자.
				item.setItemNo(rset.getInt("item_no"));
				item.setItemName(rset.getString("item_name"));
				item.setItemCatNo(rset.getInt("item_cat_no"));
				item.setItemPrice(rset.getInt("item_price"));
				item.setItemCount(rset.getInt("item_count"));
				item.setItemUpdate(rset.getDate("item_update"));
				item.setItemTH(rset.getString("item_img_mini"));
				item.setItemImg(rset.getString("item_img"));
				item.setItemImgDt(rset.getString("item_img_detail"));
				
				list.add(item);
			}
			System.out.println("dao : "+list);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("dao조회실패...");
		} finally {
			close(rset);
			close(stmt);
		}
		return list;
	}

	public ArrayList<Item> selectCategoryList(Connection con, int categoryNo, String sort_col) {
		ArrayList<Item> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from item where item_cat_no = ?";
		try {
			if(sort_col == null){
				pstmt = con.prepareStatement(query);
			}else{
				pstmt = con.prepareStatement(query+sort_col);
			}
			pstmt.setInt(1, categoryNo);
			
			rset = pstmt.executeQuery();
			
			boolean onoff = true;
			while(rset.next()){
				if(onoff){
					//객체생성을 한번만 하도록
					list = new ArrayList<Item>();
					onoff = false;
				}
				Item item = new Item();
				//필요없는건 제외하자.
				item.setItemNo(rset.getInt("item_no"));
				item.setItemName(rset.getString("item_name"));
				item.setItemCatNo(rset.getInt("item_cat_no"));
				item.setItemPrice(rset.getInt("item_price"));
				item.setItemCount(rset.getInt("item_count"));
				item.setItemUpdate(rset.getDate("item_update"));
				item.setItemTH(rset.getString("item_img_mini"));
				item.setItemImg(rset.getString("item_img"));
				item.setItemImgDt(rset.getString("item_img_detail"));
				
				list.add(item);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("dao조회실패...");
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public ArrayList<Item> searchItem(Connection con, String keyword, String sort_col) {
		ArrayList<Item> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from item where item_tag like ?";
		try {
			if(sort_col==null){
				pstmt = con.prepareStatement(query);
			}else{
				pstmt = con.prepareStatement(query+sort_col);
			}
			pstmt.setString(1, "%"+keyword+"%");
			
			rset = pstmt.executeQuery();
			
			boolean onoff = true;
			while(rset.next()){
				if(onoff){
					//객체생성을 한번만 하도록
					list = new ArrayList<Item>();
					onoff = false;
				}
				Item item = new Item();
				//필요없는건 제외하자.
				item.setItemNo(rset.getInt("item_no"));
				item.setItemName(rset.getString("item_name"));
				item.setItemCatNo(rset.getInt("item_cat_no"));
				item.setItemPrice(rset.getInt("item_price"));
				item.setItemCount(rset.getInt("item_count"));
				item.setItemUpdate(rset.getDate("item_update"));
				item.setItemTH(rset.getString("item_img_mini"));
				item.setItemImg(rset.getString("item_img"));
				item.setItemImgDt(rset.getString("item_img_detail"));
				
				list.add(item);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("dao검색실패...");
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

}
