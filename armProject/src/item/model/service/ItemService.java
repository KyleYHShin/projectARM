package item.model.service;

import java.sql.*;
import java.util.ArrayList;

import item.model.dao.ItemDao;
import item.model.vo.Item;
import static common.JDBCTemplate.*;

public class ItemService {

	public ItemService(){}

	public ArrayList<Item> selectMainList(String sort_col) {
		Connection con = getConnection();
		
		ArrayList<Item> list = new ItemDao().selectMainList(con, sort_col);
		System.out.println("service실행..");
		
		close(con);
		
		return list;
	}

	public ArrayList<Item> selectCategoryList(int categoryNo, String sort_col) {
		Connection con = getConnection();
		
		ArrayList<Item> list = new ItemDao().selectCategoryList(con, categoryNo, sort_col);
		
		close(con);
		return list;
	}

	public ArrayList<Item> searchItem(String keyword, String sort_col) {
		Connection con = getConnection();
		
		ArrayList<Item> list = new ItemDao().searchItem(con, keyword, sort_col);
		
		close(con);
		return list;
	}

}
