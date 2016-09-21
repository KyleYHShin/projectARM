package item.model.service;

import java.sql.*;
import java.util.ArrayList;

import item.model.dao.ItemDao;
import item.model.vo.Item;
import static common.JDBCTemplate.*;

public class ItemService {

	public ItemService(){}

	public ArrayList<Item> selectAllList() {
		Connection con = getConnection();
		
		ArrayList<Item> list = new ItemDao().selectAllList(con);
				
		return list;
	}

	public ArrayList<Item> selectCategoryList(int categoryNo) {
		Connection con = getConnection();
		
		ArrayList<Item> list = new ItemDao().selectCategoryList(con, categoryNo);
		
		return list;
	}

	public ArrayList<Item> searchItem(String keyword) {
Connection con = getConnection();
		
		ArrayList<Item> list = new ItemDao().searchItem(con, keyword);
		return list;
	}

}
