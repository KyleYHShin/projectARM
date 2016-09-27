package purchase.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import purchase.model.service.PurchaseService;

/**
 * Servlet implementation class PurchaseUpdateServlet
 */
@WebServlet("/PurchaseUpdate")
public class PurchaseUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PurchaseUpdateServlet() {
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
		int purchaseNo = Integer.parseInt(request.getParameter("purchaseNo"));

		int result = new PurchaseService().updatePurchase(purchaseNo);

		// 3.
		RequestDispatcher view = request.getRequestDispatcher("/PurchaseView");
		if (result > 0) {
			System.out.println("주문결제 Update 성공");
		} else {
			System.out.println("주문결제 Update 실패");
		}
		view.forward(request, response);
	}

}
