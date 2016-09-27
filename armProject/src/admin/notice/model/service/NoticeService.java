package admin.notice.model.service;

import java.sql.*;
import java.util.ArrayList;

import static common.JDBCTemplate.*;

import admin.notice.model.dao.NoticeDao;
import admin.notice.model.vo.Notice;


public class NoticeService {

	public NoticeService() {
		
	}

	public ArrayList<Notice> selectAll() {
		Connection con = getConnection();
		ArrayList<Notice> list = new NoticeDao().selectAll(con);
		close(con);
		
		return list;
	}

	public int insertNotice(Notice notice) {
		Connection con = getConnection();
		int result = new NoticeDao().insertNotice(con, notice);
		System.out.println("서비스..."+result);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public int updateNotice(Notice notice) {
		Connection con = getConnection();
		int result = new NoticeDao().updateNotice(con, notice);
		System.out.println("서비스작동"+result);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
		
	}

	public int deleteNotice(int titleNo) {
		Connection con = getConnection();
		int result = new NoticeDao().deleteNotice(con, titleNo);
		if(result > 0)
			commit(con);
		else
			rollback(con);
		close(con);
		return result;
	}

	public Notice selectone(int noticeNo) {
		Connection con = getConnection();
		
		Notice notice = new NoticeDao().selectone(con, noticeNo);
		
		
		close(con);
		return notice;
	}

}
