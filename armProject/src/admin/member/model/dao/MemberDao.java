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
				
				member.setMemberId(rset.getString("m_id"));
				member.setMemberPwd(rset.getString("m_pw"));
				member.setMemberName(rset.getString("m_name"));
				member.setMemberBirth(rset.getDate("m_birth"));
				member.setMemberGender(rset.getString("m_gender").charAt(0));
				member.setMemberPhone(rset.getString("m_phone"));
				member.setMemberEmail(rset.getString("m_email"));
				member.setMemberZipcode(rset.getString("m_zipcode"));
				member.setMemberAddress(rset.getString("m_address"));
				member.setMemberGrade(rset.getInt("m_grade"));
				member.setMemberJoinDate(rset.getDate("m_joindate"));
				
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
			
			member.setMemberId(rset.getString("m_id"));
			member.setMemberPwd(rset.getString("m_pw"));
			member.setMemberName(rset.getString("m_name"));
			member.setMemberBirth(rset.getDate("m_birth"));
			member.setMemberGender(rset.getString("m_gender").charAt(0));
			member.setMemberPhone(rset.getString("m_phone"));
			member.setMemberEmail(rset.getString("m_email"));
			member.setMemberZipcode(rset.getString("m_zipcode"));
			member.setMemberAddress(rset.getString("m_address"));
			member.setMemberGrade(rset.getInt("m_grade"));
			member.setMemberJoinDate(rset.getDate("m_joindate"));
			
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

}
