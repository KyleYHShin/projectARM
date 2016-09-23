package item.model.dao;

import java.sql.*;
import java.util.ArrayList;
import static common.JDBCTemplate.*;
import item.model.vo.Item;

public class ItemDao {

	public ItemDao(){}

	public ArrayList<Item> selectMainList(Connection con, String sort_col, int page) {
		//전체상품목록 불러오기
		ArrayList<Item> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		//ceil(rownum/9): 한페이지에 출력할 상품 갯수 9.
		String query = "select * "
				+ "from(select ceil(rownum/9) page,"
					+ " item_no, item_name, item_cat_no, item_price, "
					+ "item_count, item_update, item_img_mini, "
					+ "item_img, item_img_detail "
				+ "from (select * from product_main p left join item i on(p.PRM_ITEM_NO = i.ITEM_NO) order by prm_no)) where page = ?";
		String sort =  "select * "
				+ "from(select ceil(rownum/9) page,"
				+ " item_no, item_name, item_cat_no, item_price, "
				+ "item_count, item_update, item_img_mini, "
				+ "item_img, item_img_detail "
			+ "from (select * from product_main p left join item i on(p.PRM_ITEM_NO = i.ITEM_NO)"+sort_col+", prm_no)) where page = ?";
		
		try {
			if(sort_col == null){
				pstmt = con.prepareStatement(query);
			}else{
				pstmt = con.prepareStatement(sort);
			}
			pstmt.setInt(1, page);
			
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

	public ArrayList<Item> selectCategoryList(Connection con, int categoryNo, String sort_col, int page) {
		ArrayList<Item> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String catQry = null;
		int maxCatNo = 0;
		if(categoryNo%100 != 0){//예;101이상~199이하
			catQry = "item_cat_no = ?";
		}else {
			maxCatNo = categoryNo+99;
			catQry = "item_cat_no between ? and "+maxCatNo;
			//categoryNo~ categoryNo+99
		}
		String query = "select * "
				+ "from(select ceil(rownum/9) page,"
					+ " item_no, item_name, item_cat_no, item_price, "
					+ "item_count, item_update, item_img_mini, "
					+ "item_img, item_img_detail "
				+ "from (select * from  item where "+catQry+")) where page = ?";
		try {
			if(sort_col == null){
				pstmt = con.prepareStatement(query);
			}else{
				pstmt = con.prepareStatement(query+sort_col);
			}
			pstmt.setInt(1, categoryNo);
			pstmt.setInt(2, page);
			
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

	public ArrayList<Item> searchItem(Connection con, String keyword, String sort_col, int page) {
		ArrayList<Item> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select * "
				+ "from(select ceil(rownum/9) page,"
					+ " item_no, item_name, item_cat_no, item_price, "
					+ "item_count, item_update, item_img_mini, "
					+ "item_img, item_img_detail "
				+ "from (select * from  item where item_tag like ?)) where page = ?";
		try {
			if(sort_col==null){
				pstmt = con.prepareStatement(query);
			}else{
				pstmt = con.prepareStatement(query+sort_col);
			}
			pstmt.setString(1, "%"+keyword+"%");
			pstmt.setInt(2, page);
			
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

	public int getTotalCount(Connection con) {
		int totalCount = 0;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from item";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			if(rset.next()){
				totalCount = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("전체 줄 수 얻기 실패");
		} finally {
			close(rset);
			close(stmt);
		}
		
		return totalCount;
	}

	public int getSearchCount(Connection con, String keyword) {
		int totalCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from item where item_tag like ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+keyword+"%");
			
			rset = pstmt.executeQuery();
			if(rset.next()){
				totalCount = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("검색 줄 수 얻기 실패");
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalCount;
	}

	public int getCategoryCount(Connection con, int categoryNo) {
		int totalCount = 0;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select count(*) from item where item_cat_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, categoryNo);
			
			rset = pstmt.executeQuery();
			if(rset.next()){
				totalCount = rset.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("카테고리 줄 수 얻기 실패");
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalCount;
	}

}
