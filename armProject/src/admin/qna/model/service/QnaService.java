package admin.qna.model.service;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import admin.qna.model.dao.QnaDao;
import admin.qna.model.vo.Answer;
import admin.qna.model.vo.Question;

import static common.JDBCTemplate.*;

public class QnaService {
	
	public QnaService(){}

	public ArrayList<Question> selectAllQuestion() {
		Connection con = getConnection();
		ArrayList<Question> questionList = new QnaDao().selectAllQuestion(con);
		close(con);
		return questionList;
	}

	public HashMap<Integer, String> selectAllItem() {
		Connection con = getConnection();
		HashMap<Integer, String> itemList = new QnaDao().selectAllItem(con);
		close(con);
		return itemList;
	}

	public HashMap<Integer, String> selectAllSubItem() {
		Connection con = getConnection();
		HashMap<Integer, String> subItemList = new QnaDao().selectAllSubitem(con);
		close(con);
		return subItemList;
	}


	public int deleteAnswer(int aNo) {
		Connection con = getConnection();
		int result = new QnaDao().deleteAnswer(con, aNo);
		
		if (result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}

	public int updateAnswer(Answer answer) {
		Connection con = getConnection();
		int result = new QnaDao().updateAnswer(con, answer);
		
		if (result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}

	public int insertAnswer(Answer answer) {
		Connection con = getConnection();
		int result = new QnaDao().insertAnswer(con, answer);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}
	

}
