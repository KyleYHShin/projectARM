package purchase.model.service;

import static common.JDBCTemplate.*;

import java.sql.Connection;
import java.util.ArrayList;

import cart.model.dao.CartDao;
import cart.model.vo.Cart;
import order.dao.OrderDao;
import purchase.model.dao.PurchaseDao;
import purchase.model.vo.Purchase;

public class PurchaseService {

	public PurchaseService() {
		// TODO Auto-generated constructor stub
	}

	public Purchase selectPurchase(int purchaseNo) {
		Connection con = getConnection();
		Purchase purchase = new PurchaseDao().selectPurchase(con, purchaseNo);
		if (purchase != null) {
			// OrderList 불러오기
			purchase.setOrderList(new OrderDao().selectAll(con, purchase.getPurchaseNo()));
		}
		return purchase;
	}

	// 수정필요
	public ArrayList<Purchase> selectAll(String userId) {
		Connection con = getConnection();
		ArrayList<Purchase> purchaseList = new PurchaseDao().selectAll(con, userId);

		if (purchaseList != null) {
			for (Purchase p : purchaseList) {
				// 주문 목록 불러와 저장하기
				p.setOrderList(new OrderDao().selectAll(con, p.getPurchaseNo()));
			}
		}
		close(con);

		return purchaseList;
	}

	public int deletePurchase(int purchaseNo) {
		Connection con = getConnection();
		int result = new PurchaseDao().deletePurchase(con, purchaseNo);

		if (result > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		close(con);

		return result;
	}

	public int insertPurchase(String userId, String name, String phone, String email, String zipcode, String address, int delivery, int totalPrice,
			ArrayList<Cart> cartList) {
		Connection con = getConnection();
		int result = 0;
		PurchaseDao pDao = new PurchaseDao();

		// 1. 새 주문번호 받아오기
		int purchaseNo = pDao.selectPurchaseNo(con);

		if (purchaseNo > 0) {
			// 2. 주문 insert
			int resultPurchase = pDao.insertPurchase(con, purchaseNo, userId, name, phone, email, zipcode, address, delivery, totalPrice);
			if (resultPurchase > 0) {
				// 3. order 목록 생성
				int resultOrders = 0;
				OrderDao oDao = new OrderDao();

				result = 1;
				for (Cart c : cartList) {
					resultOrders = oDao.insertOrder(con, purchaseNo, c.getItem_sub_no(), c.getQuantity());
					// 한번이라도 실패시 result = 0;
					if (resultOrders == 0) {
						result = 0;
						break;// 루틴종료
					}
				}
				// 4. 기존 장바구니 목록 삭제
				if (result > 0) {
					int resultDeleteCart = 0;
					CartDao cDao = new CartDao();

					for (Cart c : cartList) {
						//바로구매하기 실행시 cart_no=0이므로 아래 코드를 피한다.
						if (c.getCart_no() != 0) {
							resultDeleteCart = cDao.deleteCart(con, c.getCart_no());
							// 한번이라도 실패시 result = 0;
							if (resultDeleteCart == 0) {
								result = 0;
								break;// 루틴종료
							}
							result = purchaseNo;
						}
					}
				}
			}
		}

		if (result > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		close(con);

		return result;
	}

	public int updatePurchase(int purchaseNo) {
		Connection con = getConnection();
		int result = new PurchaseDao().updatePurchase(con, purchaseNo);

		if (result > 0) {
			commit(con);
		} else {
			rollback(con);
		}
		close(con);

		return result;
	}

}
