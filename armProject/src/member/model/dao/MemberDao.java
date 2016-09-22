package member.model.dao;

import java.sql.*;
import member.model.vo.Member;
import static common.JDBCTemplate.*;
public class MemberDao {

	public MemberDao() {}
	//로그인 처리용 메소드
	public String login(String userId, String userPwd) {
		String userName = null;
		Connection con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select user_name from users where user_id = ? and user_pw = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				userName = rset.getString(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
			close(con);
		}
		return userName;
	}
	public int insertMember(Connection con, Member member) {
		int result = 0;
		con = getConnection();
		PreparedStatement pstmt = null;
		
		String query = "INSERT INTO MEMBER VALUES" + 
		"(?,?,?,?,?,?,?,?,?,'1', sysdate)";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, member.getUserId());
			pstmt.setString(2, member.getUserPwd());
			pstmt.setString(3, member.getUserName());
			pstmt.setDate(4, member.getBirthDate());
			pstmt.setString(5, String.valueOf(member.getGender()));
			pstmt.setString(6, member.getPhone());
			pstmt.setString(7, member.getEmail());
			pstmt.setInt(8, member.getZipCode());
			pstmt.setString(9, member.getAddress());
			
		
			
		
			result = pstmt.executeUpdate();
			if(result>0)
				commit(con);
			else
				rollback(con);
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(con);
			
		}

		return result;
	}
	
	public Member selectUser(Connection con, String userId) {
		Member member = null;
		con = getConnection();
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select* from member where m_id = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			rset = pstmt.executeQuery();
			
			if(rset.next()) {
				member = new Member();
				member.setUserId(userId);
				member.setUserName(rset.getString("m_name"));
				member.setBirthDate(rset.getDate("m_birth"));
				member.setGrade(rset.getInt("m_grade"));
				member.setPhone(rset.getString("m_phone"));
				member.setEmail(rset.getString("m_email"));
				member.setGender(rset.getString("m_gender").charAt(0));
				member.setZipCode(rset.getInt("m_zipcode"));
				member.setAddress(rset.getString("m_address"));
				member.setJoinDate(rset.getDate("m_joindate"));
				
				
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
			close(con);
		}
		return member;
	}
	public int memberDelete(Connection con, String userId) {
		int result = 0;
		con = getConnection();
		PreparedStatement pstmt = null;
		String query = "delete from member where M_ID=?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			
			result = pstmt.executeUpdate();
			if(result >0)
				commit(con);
			else
				rollback(con);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(con);
		}
		return result;
	}
	public int memberUpdate(Connection con, Member member) {
		int result = 0;
		
		con = getConnection();
		PreparedStatement pstmt = null;
		String query = "update member set"
				+ " M_NAME=?,  M_PW=?, M_BIRTH=?, M_PHONE=?, M_EMAIL=?, "
				+"M_GENDER = ?, M_ZIPCODE =?, M_ADDRESS=? where M_ID=?";
		try {
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, member.getUserPwd());
			pstmt.setString(2, member.getUserName());
			pstmt.setDate(3, member.getBirthDate());
			pstmt.setString(4, member.getPhone());
			pstmt.setString(5, member.getEmail());
			pstmt.setString(6, String.valueOf(member.getGender()));
			pstmt.setInt(7, member.getZipCode());
			pstmt.setString(8, member.getAddress());
		
			
			
			result = pstmt.executeUpdate();
			if(result>0)
			commit(con);
			else
				rollback(con);
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(con);
		}
		return result;
	}



	
}
