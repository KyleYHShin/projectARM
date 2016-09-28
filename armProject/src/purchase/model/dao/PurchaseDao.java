package purchase.model.dao;

import java.sql.*;
import java.util.ArrayList;

import static common.JDBCTemplate.*;

import purchase.model.vo.Purchase;

public class PurchaseDao {

	public PurchaseDao() {
		// TODO Auto-generated constructor stub
	}
	
	public Purchase selectPurchase(Connection con, int purchaseNo) {
		Purchase purchase = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String sql = "select purchase_no, g_name, PURCHASE_M_ID, PURCHASE_NAME, PURCHASE_PHONE, "
				+ " PURCHASE_EMAIL, PURCHASE_ZIPCODE, PURCHASE_ADDRESS, TOTAL_PRICE, DELIVERY, "
				+ " PURCHASE_DATE, PAID from purchase left join member on(m_id = PURCHASE_M_ID) "
				+ " left join grade on(m_grade = g_no) where purchase_no = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, purchaseNo);
			
			rset = pstmt.executeQuery();
			if(rset.next()){
				purchase = new Purchase();
				purchase.setPurchaseNo(rset.getInt("purchase_no"));
				purchase.setGradeName(rset.getString("g_name"));
				purchase.setUserId(rset.getString("PURCHASE_M_ID"));
				purchase.setName(rset.getString("PURCHASE_NAME"));
				purchase.setPhone(rset.getString("PURCHASE_PHONE"));
				purchase.setEmail(rset.getString("PURCHASE_EMAIL"));
				purchase.setZipcode(rset.getString("PURCHASE_ZIPCODE"));
				purchase.setAddress(rset.getString("PURCHASE_ADDRESS"));
				purchase.setTotalItemPrice(rset.getInt("TOTAL_PRICE"));
				purchase.setDelivery(rset.getInt("DELIVERY"));
				purchase.setPurchaseDate(rset.getDate("PURCHASE_DATE"));
				purchase.setPaid(rset.getString("PAID").charAt(0));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return purchase;
	}

	//수정필요
	public ArrayList<Purchase> selectAll(Connection con, String userId) {
		ArrayList<Purchase> purchaseList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String sql = "select purchase_no, g_name, PURCHASE_M_ID, PURCHASE_NAME, PURCHASE_PHONE, "
				+ " PURCHASE_EMAIL, PURCHASE_ZIPCODE, PURCHASE_ADDRESS, TOTAL_PRICE, DELIVERY, "
				+ " PURCHASE_DATE, PAID from purchase left join member on(m_id = PURCHASE_M_ID) "
				+ " left join grade on(m_grade = g_no) where purchase_m_id = ? "
				+ " order by purchase_no desc";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);

			rset = pstmt.executeQuery();

			boolean flag = true;

			while (rset.next()) {
				if (flag) {
					purchaseList = new ArrayList<Purchase>();
					flag = false;
				}
				Purchase purchase = new Purchase();
				purchase = new Purchase();
				purchase.setPurchaseNo(rset.getInt("purchase_no"));
				purchase.setGradeName(rset.getString("g_name"));
				purchase.setUserId(rset.getString("PURCHASE_M_ID"));
				purchase.setName(rset.getString("PURCHASE_NAME"));
				purchase.setPhone(rset.getString("PURCHASE_PHONE"));
				purchase.setEmail(rset.getString("PURCHASE_EMAIL"));
				purchase.setZipcode(rset.getString("PURCHASE_ZIPCODE"));
				purchase.setAddress(rset.getString("PURCHASE_ADDRESS"));
				purchase.setTotalItemPrice(rset.getInt("TOTAL_PRICE"));
				purchase.setDelivery(rset.getInt("DELIVERY"));
				purchase.setPurchaseDate(rset.getDate("PURCHASE_DATE"));
				purchase.setPaid(rset.getString("PAID").charAt(0));
				
				purchaseList.add(purchase);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}

		return purchaseList;
	}

	public int selectPurchaseNo(Connection con) {
		int purchaseNo = 0;

		Statement stmt = null;
		ResultSet rset = null;

		String query = "select seq_purchase_no.nextval from dual";

		try {
			stmt = con.createStatement();
			rset = stmt.executeQuery(query);

			if (rset.next()) {
				purchaseNo = rset.getInt("nextval");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		return purchaseNo;
	}

	public int insertPurchase(Connection con, int purchaseNo, String userId, String name, String phone, String email, String zipcode, String address,
			int delivery, int totalPrice) {
		int result = 0;

		PreparedStatement pstmt = null;

		String sql = "insert into purchase values(?, ?, ?, ?, ?, ?, ?, ?, ?, sysdate, ?)";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, purchaseNo);
			pstmt.setString(2, userId);
			pstmt.setString(3, name);
			pstmt.setString(4, phone);
			pstmt.setString(5, email);
			pstmt.setString(6, zipcode);
			pstmt.setString(7, address);
			pstmt.setInt(8, totalPrice);
			pstmt.setInt(9, delivery);
			pstmt.setString(10, "N");

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}

	public int deletePurchase(Connection con, int purchaseNo) {
		int result = 0;

		PreparedStatement pstmt = null;

		String sql = "delete from purchase where PURCHASE_NO = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, purchaseNo);

			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	public int updatePurchase(Connection con, int purchaseNo) {
		int result = 0;

		PreparedStatement pstmt = null;

		String sql = "update purchase set PAID = ? where PURCHASE_NO = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, "Y");
			pstmt.setInt(2, purchaseNo);

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
