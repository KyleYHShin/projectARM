package itemqna.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;

import itemqna.model.vo.Question;

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
			pstmt.setInt(3, question.getItem_sub_no());
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

}
