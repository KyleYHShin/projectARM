package admin.member.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import admin.member.model.dao.MemberDao;
import admin.member.model.vo.Member;

public class MemberService {

	public ArrayList<Member> memberAll() {
Connection con = getConnection();
		
		ArrayList<Member> list = new MemberDao().memberAll(con);
		
		close(con);
		return list;
	}

	public ArrayList<Member> selectMember(String memberId) {
Connection con = getConnection();
		
		ArrayList<Member> list = new MemberDao().selectMember(con, memberId);
		
		close(con);
		return list;
	}

	public int deleteMember(String memberId) {
		Connection con = getConnection();
		int result = new MemberDao().deleteMember(con, memberId);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

}
