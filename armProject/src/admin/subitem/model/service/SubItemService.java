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

}
