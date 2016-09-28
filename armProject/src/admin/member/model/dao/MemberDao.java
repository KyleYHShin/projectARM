package admin.member.model.dao;

import static common.JDBCTemplate.close;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import admin.member.model.vo.Member;

public class MemberDao {
	
	public ArrayList<Member> memberAll(Connection con) {
		ArrayList<Member> list = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from member";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<Member>();
					flag = false;
				}
				Member member = new Member();
				
				member.setUserId(rset.getString("m_id"));
				member.setUserPwd(rset.getString("m_pw"));
				member.setUserName(rset.getString("m_name"));
				member.setBirthDate(rset.getDate("m_birth"));
				member.setGender(rset.getString("m_gender").charAt(0));
				member.setPhone(rset.getString("m_phone"));
				member.setEmail(rset.getString("m_email"));
				member.setZipCode(rset.getString("m_zipcode"));
				member.setAddress(rset.getString("m_address"));
				member.setGrade(rset.getInt("m_grade"));
				member.setJoinDate(rset.getDate("m_joindate"));
				
				list.add(member);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(stmt);
		}
				
		return list;
	}

	public ArrayList<Member> selectMember(Connection con, String memberId) {
		ArrayList<Member> list = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from member where m_id like ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, "%"+ memberId +"%");
			
			rset = pstmt.executeQuery();
			
			boolean flag = true;
			while(rset.next()){
				if(flag == true){
					list = new ArrayList<Member>();
					flag = false;
				}
		
			Member member = new Member();
			
			member.setUserId(rset.getString("m_id"));
			member.setUserPwd(rset.getString("m_pw"));
			member.setUserName(rset.getString("m_name"));
			member.setBirthDate(rset.getDate("m_birth"));
			member.setGender(rset.getString("m_gender").charAt(0));
			member.setPhone(rset.getString("m_phone"));
			member.setEmail(rset.getString("m_email"));
			member.setZipCode(rset.getString("m_zipcode"));
			member.setAddress(rset.getString("m_address"));
			member.setGrade(rset.getInt("m_grade"));
			member.setJoinDate(rset.getDate("m_joindate"));
			list.add(member);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ddd1");
		}finally{
			close(rset);
			close(pstmt);
		}
		return list;
	}
	
	
	public int deleteMember(Connection con, String memberId) {
		int result = 0;
		PreparedStatement pstmt = null;
		
		String query = "delete from member where m_id = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, memberId);
			
			result = pstmt.executeUpdate();
		
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	public Member selectOne(Connection con, String userId) {
		Member member = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select * from member where m_id = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setString(1, userId);
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
			member = new Member();
			
			member.setUserId(rset.getString("m_id"));
			member.setUserPwd(rset.getString("m_pw"));
			member.setUserName(rset.getString("m_name"));
			member.setBirthDate(rset.getDate("m_birth"));
			member.setGender(rset.getString("m_gender").charAt(0));
			member.setPhone(rset.getString("m_phone"));
			member.setEmail(rset.getString("m_email"));
			member.setZipCode(rset.getString("m_zipcode"));
			member.setAddress(rset.getString("m_address"));
			member.setGrade(rset.getInt("m_grade"));
			member.setJoinDate(rset.getDate("m_joindate"));
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("ddd1");
		}finally{
			close(rset);
			close(pstmt);
		}
		return member;
	}

}
