package member.model.dao;

import java.sql.*;
import member.model.vo.Member;
import member.model.vo.User;

import static common.JDBCTemplate.*;
public class MemberDao {

	public MemberDao() {}
	//로그인 처리용 메소드
	public User login(Connection con, String userId, String userPwd) {
		User loginUser = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from users where user_id = ? and user_pw = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			pstmt.setString(2, userPwd);
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				loginUser = new User();
				loginUser.setUserId(rset.getString("user_id"));
				loginUser.setUserName(rset.getString("user_name"));
				loginUser.setGrade(rset.getString("grade_name"));
				loginUser.setDiscount(rset.getDouble("discount"));
				
				
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
			close(con);
		}
		return loginUser;
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
			pstmt.setString(8, member.getZipCode());
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
				member.setZipCode(rset.getString("m_zipcode"));
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

	public int updateMember(Connection con, Member member) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "update member set M_PW = ?, M_PHONE = ?, M_EMAIL = ?, "
				+ "M_ZIPCODE = ?, M_ADDRESS = ? where M_ID = ?";
		System.out.println("Dao 작동");
				
		try {
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, member.getUserPwd());
			pstmt.setString(2, member.getPhone());
			pstmt.setString(3, member.getEmail());
			pstmt.setString(4, member.getZipCode());
			pstmt.setString(5, member.getAddress());
			pstmt.setString(6, member.getUserId());
			
					
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			
		}finally {
			close(pstmt);
		}
		return result;
	}	
}