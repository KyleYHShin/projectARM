package admin.qna.model.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;

import admin.qna.model.vo.Answer;
import admin.qna.model.vo.Question;

import static common.JDBCTemplate.*;

public class QnaDao {

	public QnaDao(){}

	public ArrayList<Question> selectAllQuestion(Connection con) {
		ArrayList<Question> questionList = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from question left join answer on (question_no = answer_question_no)";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					questionList = new ArrayList<Question>();
					flag = false;
				}
				
				Question q = new Question();
				q.setqNo(rset.getInt("question_no"));
				q.setmId(rset.getString("question_m_id"));
				q.setItemNo(rset.getInt("question_item_no"));
				q.setItemSubNo(rset.getInt("question_item_sub_no"));
				q.setqContent(rset.getString("question_content"));
				q.setqDate(rset.getDate("question_date"));
				
				if(rset.getInt("answer_question_no") > 0){
					Answer a = new Answer();
					a.setaNo(rset.getInt("answer_no"));
					a.setqNo(rset.getInt("answer_question_no"));
					a.setaContent(rset.getString("answer_content"));
					a.setaDate(rset.getDate("answer_date"));
					
					q.setAnswer(a);
				}		
				questionList.add(q);
			}
		} catch (Exception e) {
			System.out.println("관리자 페이지에서 질문 전체 조회 Dao 실패함");
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		return questionList;
	}

	public HashMap<Integer, String> selectAllItem(Connection con) {
		HashMap<Integer, String> itemList = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from item";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					itemList = new HashMap<Integer, String>();
					flag = false;					
				}
			
				itemList.put(rset.getInt("item_no"), rset.getString("item_name"));
			}			
		} catch (Exception e) {
			System.out.println("관리자 페이지에서 아이템 목록 조회 실패");
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		
		return itemList;
	}

	public HashMap<Integer, String> selectAllSubitem(Connection con) {
		HashMap<Integer, String> subItemList = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from item_sub";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					subItemList = new HashMap<Integer, String>();
					flag = false;					
				}
				subItemList.put(rset.getInt("item_sub_no"), rset.getString("item_sub_name"));
				
			}			
		} catch (Exception e) {
			System.out.println("관리자 페이지에서 서브아이템 목록 조회 실패");
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
		
		return subItemList;
	}

	

	public int deleteAnswer(Connection con, int aNo) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from answer where answer_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			
			pstmt.setInt(1, aNo);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("답변 삭제 Dao 실패");
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		
		return result;
	}

	public int updateAnswer(Connection con, Answer answer) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update answer set answer_content = ? where answer_question_no = ?";
				
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, answer.getaContent());
			pstmt.setInt(2, answer.getqNo());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("후기 업데이트 Dao에서 실패");
			e.printStackTrace();
		} finally {
			close(pstmt);
		}		
		return result;
	}

	public int insertAnswer(Connection con, Answer answer) {
		int result = 0;
		PreparedStatement pstmt= null;
		
		String query = "insert into answer values (seq_answer_no.nextval, ?, ?, sysdate)";
		
		try {
			pstmt = con.prepareStatement(query);
			
			pstmt.setInt(1, answer.getqNo());
			pstmt.setString(2, answer.getaContent());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			System.out.println("관리자 페이지에서 답변 입력 Dao 실패");
			e.printStackTrace();			
		} finally {
			close(pstmt);
		}
		return result;
	}
}
