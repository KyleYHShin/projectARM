package admin.notice.model.dao;

import java.sql.*;
import java.util.ArrayList;
import static common.JDBCTemplate.*;
import admin.notice.model.vo.Notice;

public class NoticeDao {

	public NoticeDao() {
		// TODO Auto-generated constructor stub
	}

	public ArrayList<Notice> selectAll(Connection con) {
		ArrayList<Notice>list = null;
		Statement stmt = null;
		ResultSet rset = null;
		
		String query = "select * from notice order by notice_no desc";
		
		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);
			
			boolean flag = true;
			while(rset.next()) {
				if(flag==true) {
				list = new ArrayList<Notice>();
				flag = false;
				
				
			}
			Notice n = new Notice();
			n.setNoticeNo(rset.getInt("notice_no"));
			n.setCatNo(rset.getInt("notice_cat_no"));
			n.setNoticeTitle(rset.getString("notice_title"));
			n.setContent(rset.getString("notice_content"));
			n.setNoticeFile(rset.getString("notice_file"));
			n.setNoticeDate(rset.getDate("notice_date"));
			
			list.add(n);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(stmt);
		}
	
		
		return list;
	}

}
