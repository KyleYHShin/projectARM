package item.model.dao;

import static common.JDBCTemplate.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import item.model.vo.*;

public class ItemDao {
	
	public ItemDao(){}

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
				review.setItemSubNo(rset.getInt("review_item_sub_no"));
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
	
	

}
