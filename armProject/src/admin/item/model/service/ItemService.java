package admin.item.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import admin.item.model.dao.ItemDao;
import admin.item.model.vo.Item;

public class ItemService {

	public ArrayList<Item> selectAll() {
		Connection con = getConnection();
		
		ArrayList<Item> list = new ItemDao().selectAll(con);
		
		close(con);
		return list;
	}

}
