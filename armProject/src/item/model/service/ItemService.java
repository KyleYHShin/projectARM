package item.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import item.model.dao.ItemDao;
import item.model.vo.*;
import static common.JDBCTemplate.*;

public class ItemService {

	public ItemService() {}

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
	
	//상품 선택 시 상품 조회, 객체 형태로 리턴
	public Item selectOne(int itemNo) {
		Connection con = getConnection();
		Item item = new ItemDao().selectOne(con, itemNo);
		close(con);
		return item;
	}

	//SubItem 목록 조회하여 리턴
	public ArrayList<SubItem> selectOneSub(int itemNo) {
		Connection con = getConnection();
		//해당 Item에 엮인 SubItem의 번호들을 조회하여 ArrayList에 저장
		ArrayList<Integer> subItemNoList = new ItemDao().selectSubItemNo(con, itemNo);
		
		//받아온 SubItem 번호 리스트를 전달하여 SubItem 객체들을 조회, ArrayList에 저장
		ArrayList<SubItem> subItemList = new ItemDao().selectOneSub(con, subItemNoList);
		
		close(con);
		
		return subItemList;
	}

	//문의 내역 리턴
	public ArrayList<Question> selectItemQuestion(int itemNo) {
		Connection con = getConnection();
		ArrayList<Question> questionList = new ItemDao().selectItemQuestion(con, itemNo);
		close(con);
		
		return questionList;
	}

	//문의내용에 대해 답변한 내역이 있는지 조회하여 리턴
	public ArrayList<Answer> selectItemAnswer(ArrayList<Question> questionList) {
		Connection con = getConnection();
		ArrayList<Answer> answerList = new ItemDao().selectItemAnswer(con, questionList);
		close(con);
		
		return answerList;
	}

	//후기 내역 리턴
	public ArrayList<Review> selectReview(int itemNo) {
		Connection con = getConnection();
		ArrayList<Review> reviewList = new ItemDao().selectReview(con, itemNo);
		close(con);
		
		return reviewList;
	}

	//후기 별점에 따른 코멘트 목록 리턴
	public HashMap<Integer, String> selecteReviewHeadContent() {
		Connection con = getConnection();
		HashMap<Integer, String> reviewHContent = new ItemDao().selectReviewHeadContent(con);
		close(con);
		
		return reviewHContent;
	}

}
