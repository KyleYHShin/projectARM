package item.model.service;

import java.sql.Connection;
import static common.JDBCTemplate.*;
import java.util.ArrayList;
import java.util.HashMap;

import item.model.dao.ItemDao;
import item.model.vo.*;

public class ItemService {
	
	public ItemService(){}

	//메인or서브 페이지에서 선택한 상품 조회, 객체 형태로 리턴
	public Item selectOne(int itemNo) {
		Connection con = getConnection();
		Item item = new ItemDao().selectOne(con, itemNo);
		close(con);
		return item;
	}

	//상품 조회 시 조회수 증가 처리
	public int addItemCount(int itemNo) {
		Connection con = getConnection();
		int result = new ItemDao().addItemCount(con, itemNo);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	//SubItem 목록 조회
	public ArrayList<SubItem> selectOneSub(int itemNo) {
		Connection con = getConnection();
		ArrayList<SubItem> subItemList = new ItemDao().selectOneSub(con, itemNo);
		
		close(con);
		
		return subItemList;
	}

	//문의 내역 조회
	public ArrayList<Question> selectItemQuestion(int itemNo) {
		Connection con = getConnection();
		ArrayList<Question> questionList = new ItemDao().selectItemQuestion(con, itemNo);
		close(con);
		
		return questionList;
	}

	//후기 내역 조회
	public ArrayList<Review> selectReview(int itemNo) {
		Connection con = getConnection();
		ArrayList<Review> reviewList = new ItemDao().selectReview(con, itemNo);
		close(con);
		
		return reviewList;
	}

	//문의내용에 대해 답변한 내역이 있는지 조회
	public ArrayList<Answer> selectItemAnswer(ArrayList<Question> questionList) {
		Connection con = getConnection();
		ArrayList<Answer> answerList = new ItemDao().selectItemAnswer(con, questionList);
		close(con);
		
		return answerList;
	}

	//리뷰 별점에 따른 코멘트 목록 리턴
	public HashMap<Integer, String> selectReviewHeadContent() {
		Connection con = getConnection();
		HashMap<Integer, String> reviewHContent = new ItemDao().selectReviewHeadContent(con);
		close(con);
		
		return reviewHContent;
	}
	
	//리뷰 삭제
	public int deleteReview(int rNo) {
		Connection con = getConnection();
		int result = new ItemDao().deleteReview(con, rNo);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}

	//리뷰 수정
	public int updateReview(Review review) {
		Connection con = getConnection();
		int result = new ItemDao().updateReview(con, review);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}
	
	

}
