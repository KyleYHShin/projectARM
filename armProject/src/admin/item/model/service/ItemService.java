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

}
