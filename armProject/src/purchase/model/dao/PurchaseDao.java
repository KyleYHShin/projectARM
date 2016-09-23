package purchase.model.dao;

import java.sql.*;
import java.util.ArrayList;

import payment.vo.Payment;

import static common.JDBCTemplate.*;

import purchase.model.vo.Purchase;

public class PurchaseDao {

	public PurchaseDao() {
		// TODO Auto-generated constructor stub
	}

	public ArrayList<Purchase> selectAll(Connection con, String userId) {
		ArrayList<Purchase> purchaseList = null;
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String sql = "select purchase_no, m_name, g_name, m_phone, "
				+ " m_email, total_price, delivery, "
				+ " purchase_date, purchase_payment_no "
				+ " from purchase "
				+ " left join member on(m_id = purchase_m_id) "
				+ " left join grade on(m_grade = g_no) "
				+ " where purchase_m_id = ?";

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

				purchase.setPurchase_no(rset.getInt("purchase_no"));
				purchase.setM_name(rset.getString("m_name"));
				purchase.setGrade_name(rset.getString("g_name"));
				purchase.setM_phone(rset.getString("m_phone"));
				purchase.setM_email(rset.getString("m_email"));
				purchase.setPurchase_price(rset.getInt("total_price"));
				purchase.setDelivery(rset.getInt("delivery"));
				purchase.setPurchase_date(rset.getDate("purchase_date"));
				
				// 구매 내역이 있을 경우(null값 -> 0 자동 치환!)
				int paymentNo = rset.getInt("purchase_payment_no");
				if (paymentNo > 0) {
					Payment payment = new Payment();
					payment.setPayment_no(paymentNo);
					purchase.setPayment(payment);
				}
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

}
