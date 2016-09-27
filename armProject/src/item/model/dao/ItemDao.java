package item.model.dao;

import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;

import static common.JDBCTemplate.*;
import item.model.vo.*;

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
				+ "from (select * from  item where item_tag like ? or item_name like ?)) where page = ?";
		try {
			if(sort_col==null){
				pstmt = con.prepareStatement(query);
			}else{
				pstmt = con.prepareStatement(query+sort_col);
			}
			pstmt.setString(1, "%"+keyword+"%");
			pstmt.setString(2, "%"+keyword+"%");
			pstmt.setInt(3, page);
			
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
		
		String catQry = null;
		int maxCatNo = 0;
		if(categoryNo%100 != 0){//예;101이상~199이하
			catQry = "item_cat_no = ?";
		}else {
			maxCatNo = categoryNo+99;
			catQry = "item_cat_no between ? and "+maxCatNo;
			//categoryNo~ categoryNo+99
		}
		String query = "select count(*) from item where "+catQry;
		
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
//--------------------------------------------------------------------------이하 고은언니
	public Item selectOne(Connection con, int itemNo) {
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
				item.setItemTH(rset.getString("item_img_mini"));
				item.setItemImg(rset.getString("item_img"));
				item.setItemImgDt(rset.getString("item_img_detail"));
			}		
		} catch (Exception e) {
			System.out.println("아이템 조회 쿼리 틀림");
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return item;
	}

	public int addItemCount(Connection con, int itemNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = 	"update item set item_count = " +
				"(select item_count from item where item_no = ?) + 1 " 
				+ "where item_no = ?";	
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, itemNo);
			pstmt.setInt(2, itemNo);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("아이템 조회수 카운트 틀림");
			e.printStackTrace();
		}
		return result;
	}


	public ArrayList<SubItem> selectOneSub(Connection con, int itemNo) {
		ArrayList<SubItem> subItemList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from item_sub join item_bridge using(item_sub_no) join item using(item_no) where item_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, itemNo);
			
			rset = pstmt.executeQuery();	
								
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					subItemList = new ArrayList<SubItem>();	
					flag = false;
				}
					SubItem subItem = new SubItem();					
					subItem.setItemSubNo(rset.getInt("item_sub_no"));
					subItem.setItemSubName(rset.getString("item_sub_name"));
					subItem.setItemSubPrice(rset.getInt("item_sub_price"));
					subItem.setItemSubQty(rset.getInt("quantity"));
					
					subItemList.add(subItem);
			}			
		} catch (Exception e) {
			System.out.println("서브아이템 리스트 조회 쿼리 틀림");
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);	
		}
		return subItemList;
	}

	
	public ArrayList<Question> selectItemQuestion(Connection con, int itemNo) {
		ArrayList<Question> questionList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from question where question_item_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, itemNo);
			
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					questionList = new ArrayList<Question>();
					flag = false;					
				}
				
				Question question = new Question();
				
				question.setqNo(rset.getInt("question_no"));
				question.setmId(rset.getString("question_m_id"));
				question.setItemNo(rset.getInt("question_item_no"));
				question.setItemSubNo(rset.getInt("question_item_sub_no"));
				question.setqContent(rset.getString("question_content"));
				question.setqDate(rset.getDate("question_date"));
				
				questionList.add(question);
			}
					
		} catch (Exception e) {
			System.out.println("문의 리스트 조회 쿼리 틀림");
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return questionList;
	}
	
	public ArrayList<Review> selectReview(Connection con, int itemNo) {
		ArrayList<Review> reviewList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from review where review_item_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, itemNo);
		 			
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					reviewList = new ArrayList<Review>();
					flag = false;
				}
			
				Review review = new Review();
				
				review.setReviewNo(rset.getInt("review_no"));
				review.setmId(rset.getString("review_m_id"));
				review.setItemNo(rset.getInt("review_item_no"));
				review.setItemSubNo(rset.getInt("reivew_item_sub_no"));
				review.setScore(rset.getInt("review_score"));
				review.setReviewContent(rset.getString("review_content"));
				review.setReviewDate(rset.getDate("review_date"));
				
				reviewList.add(review);
			}
					
		} catch (Exception e) {
			System.out.println("리뷰 리스트 조회 쿼리 틀림");
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return reviewList;
	}
	
	public ArrayList<Answer> selectItemAnswer(Connection con, ArrayList<Question> questionList) {
		ArrayList<Answer> answerList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String query = "select * from answer where answer_question_no = ?";

		try {

			answerList = new ArrayList<Answer>();

			for (int i = 0; i < questionList.size(); i++) {
				pstmt = con.prepareStatement(query);
				pstmt.setInt(1, questionList.get(i).getqNo());
			
				rset = pstmt.executeQuery();

				while (rset.next()) {
					Answer answer = new Answer();
					answer.setaNo(rset.getInt("answer_no"));
					answer.setqNo(rset.getInt("answer_question_no"));
					answer.setaContent(rset.getString("answer_content"));
					answer.setaDate(rset.getDate("answer_date"));

					answerList.add(answer);
				}
			}
		} catch (Exception e) {
			System.out.println("답변 리스트 조회 쿼리 틀림");
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		return answerList;
	}

	public HashMap<Integer, String> selectReviewHeadContent(Connection con) {
		HashMap<Integer, String> reviewHContent = null;
		Statement stmt = null;
		ResultSet rset= null;
		
		String query = "select * from review_head";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					reviewHContent = new HashMap<Integer, String>();
					flag = false;
				}
				reviewHContent.put(rset.getInt("review_head_no"), rset.getString("review_head_content"));
			}		
		} catch (Exception e) {
			System.out.println("리뷰 별점 코멘트 조회 쿼리 틀림");
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return reviewHContent;
	}
	
	public int deleteReview(Connection con, int rNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from review where review_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, rNo);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("후기 삭제 Dao에서 실패");
			e.printStackTrace();
		} finally {
			close(pstmt);			
		}		
		
		return result;
	}

	public int updateReview(Connection con, Review review) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update review set review_score = ?, review_content = ? where review_no = ?";
				
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, review.getScore());
			pstmt.setString(2, review.getReviewContent());
			pstmt.setInt(3, review.getReviewNo());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("후기 업데이트 Dao에서 실패");
			e.printStackTrace();
		} finally {
			close(pstmt);
		}		
		return result;
	}
	public int insertReview(Connection con, Review review) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into review values (seq_review_no.nextval, ?, ?, ?, ?, ?, sysdate)";
		
		try {
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, review.getmId());
			pstmt.setInt(2, review.getItemNo());
			pstmt.setInt(3, review.getItemSubNo());
			pstmt.setInt(4, review.getScore());
			pstmt.setString(5, review.getReviewContent());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("후기 입력 Dao 실패");
			e.printStackTrace();
		} finally {
			close(pstmt);
		}		
		return result;
	}
}
