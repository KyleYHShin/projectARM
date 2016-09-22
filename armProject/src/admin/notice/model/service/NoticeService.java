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

}
