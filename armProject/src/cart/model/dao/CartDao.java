package cart.model.dao;

import java.sql.*;
import java.util.ArrayList;

import static common.JDBCTemplate.*;

import cart.model.vo.Cart;

public class CartDao {

	public CartDao() {
		// TODO Auto-generated constructor stub
	}

	public ArrayList<Cart> selectAll(Connection con, String userId) {
		ArrayList<Cart> cartList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String sql = "select cart_no, " + " cart_item_no, item_name, item_img_mini, item_price, "
				+ " cart_item_sub_no, item_sub_name, item_sub_price, " + " cart_qty " + " from cart "
				+ " inner join item on cart.cart_item_no = item.item_no " + " inner join item_sub on cart.cart_item_sub_no = item_sub.item_sub_no"
				+ " where cart_m_id = ? " + " order by cart_no desc";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);

			rset = pstmt.executeQuery();

			boolean flag = true;

			while (rset.next()) {
				if (flag) {
					cartList = new ArrayList<Cart>();
					flag = false;
				}
				Cart cart = new Cart();

				cart.setCart_no(rset.getInt("cart_no"));

				cart.setItem_no(rset.getInt("cart_item_no"));
				cart.setItem_name(rset.getString("item_name"));
				cart.setItem_img_mini(rset.getString("item_img_mini"));
				cart.setItem_price(rset.getInt("item_price"));

				cart.setItem_sub_no(rset.getInt("cart_item_sub_no"));
				cart.setItem_sub_name(rset.getString("item_sub_name"));
				cart.setItem_sub_price(rset.getInt("item_sub_price"));

				cart.setQuantity(rset.getInt("cart_qty"));
				cart.setTotal_price((cart.getItem_price() + cart.getItem_sub_price()) * cart.getQuantity());

				cartList.add(cart);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return cartList;
	}

	public int updateCart(Connection con, int cartNo, int cartQty) {
		int result = 0;

		PreparedStatement pstmt = null;

		String sql = "update cart set CART_QTY = ? where CART_NO = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cartQty);
			pstmt.setInt(2, cartNo);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteCart(Connection con, int cartNo) {
		int result = 0;

		PreparedStatement pstmt = null;

		String sql = "delete from cart where CART_NO = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, cartNo);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteCartSelect(Connection con, int[] cartNumbers) {
		int result = 0;

		PreparedStatement pstmt = null;

		String sql = "delete from cart where CART_NO = ?";
		for (int i = 0; i < cartNumbers.length; i++) {
			if (i > 0) {
				sql += " or CART_NO = ?";
			}
		}
		try {
			pstmt = con.prepareStatement(sql);
			for (int i = 0; i < cartNumbers.length; i++) {
				pstmt.setInt(i + 1, cartNumbers[i]);
			}

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deleteCartById(Connection con, String userId) {
		int result = 0;

		PreparedStatement pstmt = null;

		String sql = "delete from cart where CART_M_ID = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

}
