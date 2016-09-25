package itemqna.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;

import itemqna.model.dao.ItemQnaDao;
import itemqna.model.vo.Question;

public class ItemQnaService {

	public ItemQnaService(){}

	public int updateQuestion(Question question) {
		Connection con = getConnection();
		int result = new ItemQnaDao().updateQuestion(con, question);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);

		close(con);
		
		return result;
	}

	public int deleteQuestion(int qNo) {
		Connection con = getConnection();
		int result = new ItemQnaDao().deleteQuestion(con, qNo);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}

	public int insertQuestion(Question question) {
		Connection con = getConnection();
		int result = new ItemQnaDao().insertQuestion(con, question);
		
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}

}