package payment.dao;

import static common.JDBCTemplate.*;

import java.sql.*;

import payment.vo.Payment;

public class PaymentDao {

	public PaymentDao() {
		// TODO Auto-generated constructor stub
	}

	public void selectPayment(Connection con, Payment payment) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;

		String sql = "select payment_method, payment_company, payment_price, payment_date " + " from payment " + " where payment_no = ?";

		try {
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, payment.getPayment_no());
			
			rset = pstmt.executeQuery();
			
			if(rset.next()){
				payment.setPayment_method(rset.getString("payment_method"));
				payment.setPayment_company(rset.getString("payment_company"));
				payment.setPayment_price(rset.getInt("payment_price"));
				payment.setPayment_date(rset.getDate("payment_date"));
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
	}

}
