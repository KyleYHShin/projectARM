package purchase.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import order.dao.OrderDao;
import order.vo.Order;
import payment.dao.PaymentDao;
import purchase.model.dao.PurchaseDao;
import purchase.model.vo.Purchase;

public class PurchaseService {

	public PurchaseService() {
		// TODO Auto-generated constructor stub
	}

	public int insertPurchase(ArrayList<Order> orderList, Purchase purchase) {
		Connection con = getConnection();
		// int result = new PurchaseDao().insertPurchase(con, orderList,
		// cartQty);
		close(con);
		return 0;
		// return result;
	}

	public ArrayList<Purchase> selectAll(String userId) {
		Connection con = getConnection();
		ArrayList<Purchase> purchaseList = new PurchaseDao().selectAll(con, userId);

		if (purchaseList != null) {
			for (Purchase p : purchaseList) {
				// 주문 목록 불러와 저장하기
				p.setOrderList(new OrderDao().selectAll(con, p.getPurchase_no()));

				// 결제 기록이 있는 경우
				if (p.getPayment() != null) {
					new PaymentDao().selectPayment(con, p.getPayment());
				}
			}
		}

		close(con);
		return purchaseList;
	}

}
