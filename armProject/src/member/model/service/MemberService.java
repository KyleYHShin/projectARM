package member.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;

import member.model.dao.MemberDao;
import member.model.vo.Member;
import member.model.vo.User;

public class MemberService {

	public int insertMember(Member member) {
		Connection con = getConnection();
		int result = new MemberDao().insertMember(con, member);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}

	public Member selectUser(String userId) {
		Connection con = getConnection();
		Member member = new MemberDao().selectUser(con, userId);
		close(con);
		return member;
	}

	public int memberDelete(String userId) {
		Connection con = getConnection();
		int result = new MemberDao().memberDelete(con, userId);
		if(result>0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public int memberUpdate(Member member) {
		Connection con = getConnection();
		int result = new MemberDao().memberUpdate(con, member);
		if(result>0)
			commit(con);
		else
			rollback(con);
		close(con);
		
		return result;
	}

	public User login(String userId, String userPwd) {
	      Connection con = getConnection();
	      User loginUser = new MemberDao().login(con, userId, userPwd);
	      close(con);
	      return loginUser;
	}

}
