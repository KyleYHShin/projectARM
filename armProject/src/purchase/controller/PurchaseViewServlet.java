package purchase.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.vo.User;
import purchase.model.service.PurchaseService;
import purchase.model.vo.Purchase;

/**
 * Servlet implementation class PurchaseViewServlet
 */
@WebServlet("/PurchaseView")
public class PurchaseViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PurchaseViewServlet() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 1.
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("text/html; charset=utf-8");

		// 2.
		// String userId = request.getParameter("userId");
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		ArrayList<Purchase> purchaseList = new PurchaseService().selectAll(userId);

		// 3.
		RequestDispatcher view = request.getRequestDispatcher("/mypage/MyinfoPurchase.jsp");
		if (purchaseList != null) {
			System.out.println("구매목록 Load 성공");
		} else {
			System.out.println("구매목록 Load 실패");
		}
		request.setAttribute("purchaseList", purchaseList);
		view.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
