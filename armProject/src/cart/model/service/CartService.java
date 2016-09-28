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

	public int insertCart(String userId, int itemNo, String[] itemSubNoList, String[] itemQtyList) {
		Connection con = getConnection();
		int result = 0;
		int subResult;

		for (int i = 0; i < itemSubNoList.length; i++) {
			subResult = new CartDao().insertCart(con, userId, itemNo, Integer.parseInt(itemSubNoList[i]), Integer.parseInt(itemQtyList[i]));
			// 단 한번이라도 입력 실패시
			if (subResult != 1) {
				result = 0;
				break;
			}
			result = 1;
		}

		if (result > 0) {
			commit(con);
		} else {
			rollback(con);
		}

		close(con);

		return result;
	}

	public void reloadCart(ArrayList<Cart> cartList) {
		Connection con = getConnection();
		for(Cart c : cartList){
			new CartDao().reloadCart(con, c);
		}
	}

}
