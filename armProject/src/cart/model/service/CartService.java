package cart.model.service;

import java.sql.*;
import java.util.ArrayList;

import static common.JDBCTemplate.*;

import cart.model.dao.CartDao;
import cart.model.vo.Cart;

public class CartService {

	public CartService() {
		// TODO Auto-generated constructor stub
	}

	public ArrayList<Cart> selectAll(String userId) {
		Connection con = getConnection();
		ArrayList<Cart> cartList = new CartDao().selectAll(con, userId);
		close(con);
		
		return cartList;
	}

	public int updateCart(int cartNo, int cartQty) {
		Connection con = getConnection();
		int result = new CartDao().updateCart(con, cartNo, cartQty);
		
		if (result > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return result;
	}

	public int deleteCart(int cartNo) {
		Connection con = getConnection();
		int result = new CartDao().deleteCart(con, cartNo);
		
		if (result > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return result;
	}

	public int deleteCartSelect(int[] cartNumbers) {
		Connection con = getConnection();
		int result = new CartDao().deleteCartSelect(con, cartNumbers);
		
		if (result > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		
		close(con);
		
		return result;
	}

}
