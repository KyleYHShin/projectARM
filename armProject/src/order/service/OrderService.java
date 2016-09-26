package order.service;

import java.sql.Connection;
import java.util.ArrayList;

import item.model.vo.SubItem;
import order.dao.OrderDao;
import order.vo.Order;

import static common.JDBCTemplate.*;

public class OrderService {
	
	public OrderService(){}

	public ArrayList<Order> selectOrders(ArrayList<SubItem> subItemList) {
		Connection con = getConnection();
		ArrayList<Order> orderedSubItemList = new OrderDao().selectOrders(con, subItemList);
		close(con);
		
		return orderedSubItemList;
	}
	
}
