package admin.item.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import admin.item.model.dao.ItemDao;
import admin.item.model.vo.Category;
import admin.item.model.vo.Item;
import admin.item.model.vo.Vender;

public class ItemService {

	public ArrayList<Item> selectAll() {
		Connection con = getConnection();
		
		ArrayList<Item> list = new ItemDao().selectAll(con);
		
		close(con);
		return list;
	}

	public ArrayList<Item> selectItem(int itemNo, String keyword) {
		Connection con = getConnection();
		ArrayList<Item> list = null;
		
		if(itemNo == 1){
			itemNo = Integer.parseInt(keyword);
			list = new ItemDao().selectId(con, itemNo);
		}else if(itemNo == 2){
			list = new ItemDao().selectName(con, keyword);
		}else if(itemNo == 3){
			list = new ItemDao().selectTag(con, keyword);
		}
		
		close(con);
		return list;
	}
	
	public ArrayList<Item> selectMainList(String sort_col) {
		Connection con = getConnection();
		
		ArrayList<Item> list = new ItemDao().selectMainList(con, sort_col);
		System.out.println("Service 실행");
		close(con);
		return list;
	}

	public ArrayList<Category> getCategory() {
		Connection con = getConnection();
		
		ArrayList<Category> category = new ItemDao().getCategory(con);
		
		close(con);
		return category;
	}

	public ArrayList<Vender> getVender() {
Connection con = getConnection();
		
		ArrayList<Vender> vender = new ItemDao().getVender(con);
		
		close(con);
		return vender;
	}

}
