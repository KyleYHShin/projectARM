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

	public int insertNotice(Connection con, Notice notice) {
		
		
		int result = 0;
		
		PreparedStatement pstmt = null;
		
		
		String query = "insert into NOTICE (Notice_no, Notice_CAT_NO, NOTICE_TITLE,"
				+ "NOTICE_CONTENT, NOTICE_FILE, NOTICE_DATE) values((select max(Notice_no) from notice) +1, ?, ?, ?, ?, sysdate)";
		
		try {
			pstmt = con.prepareStatement(query);
			
			pstmt.setInt(1, notice.getCatNo());
			pstmt.setString(2, notice.getNoticeTitle());
			pstmt.setString(3, notice.getContent());
			pstmt.setString(4, notice.getNoticeFile());
			result = pstmt.executeUpdate();

			System.out.println(result + "dao");
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			
		}
		return result;
		
		}
			
			
		


	public int updateNotice(Connection con, Notice notice) {
		int result = 0;
		PreparedStatement pstmt = null;
		String query = "update notice set Notice_title = ?, NOtice_CONTENT = ?, notice_file = ? where NOtice_no = ?";
		System.out.println("수정 Dao 작동");
		try {
			pstmt = con.prepareStatement(query);
			
			pstmt.setString(1, notice.getNoticeTitle());
			pstmt.setString(2, notice.getContent());
			pstmt.setInt(3, notice.getNoticeNo());
			pstmt.setString(4, notice.getNoticeFile());
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	public int deleteNotice(Connection con, int titleNo) {
		int result =0;
		PreparedStatement pstmt = null;
		
		String query = "delete from notice where notice_no = ?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, titleNo);
			
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		return result;
	}

	public Notice selectone(Connection con, int noticeNo) {
		System.out.println("selectOne dao 구동");
		
		Notice notice = null;
		
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		
		String query = "select* from notice where notice_no=?";
		
		try {
			pstmt = con.prepareStatement(query);
			pstmt.setInt(1, noticeNo);
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				notice = new Notice();
				notice.setNoticeNo(rset.getInt("notice_no"));
				notice.setCatNo(rset.getInt("notice_cat_no"));
				notice.setNoticeTitle(rset.getString("notice_title"));
				notice.setContent(rset.getString("notice_content"));
				notice.setNoticeFile(rset.getString("notice_file"));
				notice.setNoticeDate(rset.getDate("notice_date"));
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return notice;
	}



}
