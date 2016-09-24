package admin.item.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.HashMap;

import admin.item.model.vo.Vender;
import admin.item.model.dao.ItemDao;
import admin.item.model.vo.Category;
import admin.item.model.vo.Item;

public class ItemService {

	public ArrayList<Item> selectAll() {
		Connection con = getConnection();
		
		ArrayList<Item> list = new ItemDao().selectAll(con);
		
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

	public int insertItem(Item item) {
		Connection con = getConnection();
		
		int result = new ItemDao().insertItem(con, item);
		
		if(result>0){
			commit(con);
			System.out.println("item추가 commit..");
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

	public int getItemNo(Item item) {
		Connection con = getConnection();
		
		int itemNo = new ItemDao().getItemNo(con, item);
		
		close(con);
		return itemNo;
	}

	public int updateFileName(Item fitem) {
		Connection con = getConnection();
		
		int fresult = new ItemDao().updateFileName(con, fitem);
		
		if(fresult > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return fresult;
	}

	public Item selectOne(int itemNo) {
		Connection con = getConnection();
		
		Item item = new ItemDao().selectOne(con, itemNo);
		
		close(con);
		return item;
	}

	public int updateItem(Item item) {
		Connection con = getConnection();
		
		int result = new ItemDao().updateItem(con, item);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		close(con);
		return result;
	}

	public int deleteOne(int itemNo) {
		Connection con = getConnection();
		
		int result = new ItemDao().deleteOne(con, itemNo);
		
		if(result > 0){
			commit(con);
		}else{
			rollback(con);
		}
		return result;
	}
	public ArrayList<Item> selectItem(int no, String keyword) {
		Connection con = getConnection();
		ArrayList<Item> list = null;
		
		if(no == 1){
			list = new ItemDao().selectId(con, Integer.parseInt(keyword));
		}else if(no == 2){
			list = new ItemDao().selectName(con, keyword);
		}else if(no == 3){
			list = new ItemDao().selectTag(con, keyword);
		}
		
		close(con);
		return list;
	}

}
