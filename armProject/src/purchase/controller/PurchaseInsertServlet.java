package purchase.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import order.vo.Order;
import purchase.model.service.PurchaseService;
import purchase.model.vo.Purchase;

/**
 * Servlet implementation class PurchaseInsertServlet
 */
@WebServlet("/PurchaseInsertServlet")
public class PurchaseInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PurchaseInsertServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1.
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("text/html; charset=utf-8");

		// 2.
		String userId = request.getParameter("userId");
		Purchase purchase = new Purchase();
		
		
		
		ArrayList<Order> orderList = new ArrayList<Order>();
		
		int result = new PurchaseService().insertPurchase(orderList, purchase);

		// 3.
		RequestDispatcher view = null;
//		if (cartList != null) {
//			System.out.println("view success");
//			view = request.getRequestDispatcher("/mypage/MyinfoCart.jsp");
//			request.setAttribute("cartList", cartList);
//			view.forward(request, response);
//		} else {
//			System.out.println("view fail");
//			// view = request.getRequestDispatcher("/Main.jsp");
//			view = request.getRequestDispatcher("/mypage/MyinfoCart.jsp");
//			view.forward(request, response);
//		}
	}

}
