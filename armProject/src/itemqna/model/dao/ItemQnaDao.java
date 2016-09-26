package itemqna.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Types;
import java.util.ArrayList;



import itemqna.model.vo.*;

public class ItemQnaDao {
	
	public ItemQnaDao(){}

	public int updateQuestion(Connection con, Question question) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update question set question_content = ? where question_no = ?";
				
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, question.getContent());
			pstmt.setInt(2, question.getQuestion_no());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("문의 업데이트 Dao에서 실패");
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		
		return result;
	}

	public int deleteQuestion(Connection con, int qNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from question where question_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, qNo);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("문의 삭제 Dao에서 실패");
			e.printStackTrace();
		} finally {
			close(pstmt);			
		}		
		return result;
	}

	public int insertQuestion(Connection con, Question question) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "insert into question values (seq_question_no.nextval, ?, ?, ?, ?, sysdate)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, question.getM_id());
			pstmt.setInt(2, question.getItem_no());
			
			if(question.getItem_sub_no() == 0){
				pstmt.setNull(3, Types.INTEGER);
			}else{
				pstmt.setInt(3, question.getItem_sub_no());
			}
			
			pstmt.setString(4, question.getContent());

			result = pstmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("문의 입력 Dao 실패");
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public ArrayList<Question> selectMylist(Connection con, String userId) {
		ArrayList<Question> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select* from QUESTION Left join ITEM On(QUESTION_NO = ITEM_NO) "
				+ "LEFT JOIN MEMBER ON(QUESTION_M_ID = M_ID)"
				+ "LEFT JOIN ITEM_SUB ON(QUESTION_ITEM_SUB_NO = ITEM_SUB_NO)"
				+ "LEFT JOIN ANSWER ON(ANSWER_QUESTION_NO = QUESTION_NO) "
				+ "Where M_ID = ?"
				+ "order by Question_NO desc";
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()) {
				if(flag==true) {
				list = new ArrayList<Question>();
				flag = false;
			}
				
			Question q = new Question();
			q.setQuestion_no(rset.getInt("QUESTION_NO"));
			q.setM_id(rset.getString("QUESTION_M_ID"));
			q.setItem_name(rset.getString("ITEM_NAME"));
			q.setItem_sub_name(rset.getString("ITEM_SUB_NAME"));
			q.setContent(rset.getString("QUESTION_CONTENT"));
			q.setDate(rset.getDate("QUESTION_DATE"));
			Answer a = new Answer();
			a.setAnswer_no(rset.getInt("ANSWER_NO"));
			a.setContent(rset.getString("ANSWER_CONTENT"));
			a.setDate(rset.getDate("ANSWER_DATE"));
			
			q.setAnswer(a);
			
			list.add(q);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
			
}
}
