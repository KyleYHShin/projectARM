package admin.subitem.model.service;

import static common.JDBCTemplate.close;
import static common.JDBCTemplate.commit;
import static common.JDBCTemplate.getConnection;
import static common.JDBCTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;

import admin.subitem.model.dao.SubItemDao;
import admin.subitem.model.vo.SubItem;

public class SubItemService {

	public ArrayList<SubItem> selectAll(int itemNo) {
		Connection con = getConnection();
		ArrayList<SubItem> list = new SubItemDao().selectAll(con, itemNo);
		
		close(con);
		return list;
	}

	public int insertSubItem(int itemNo, SubItem subItem) {
		Connection con = getConnection();
		int result = new SubItemDao().insertSubItem(con, itemNo, subItem);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		
		return result;
	}

	public int deleteOne(int itemSubNo) {
		Connection con = getConnection();
		int result = new SubItemDao().deleteOne(con, itemSubNo);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

	public SubItem selectOne(int itemSubNo) {
		Connection con = getConnection();
		
		SubItem subItem = new SubItemDao().selectOne(con, itemSubNo);
		
		close(con);
		return subItem;
	}

	public int updateOne(SubItem subItem) {
		Connection con = getConnection();
		int result = new SubItemDao().updateOne(con, subItem);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

}
