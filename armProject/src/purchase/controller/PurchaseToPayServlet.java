package purchase.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import admin.member.model.service.MemberService;
import admin.member.model.vo.Member;
import member.model.vo.User;
import purchase.model.service.PurchaseService;
import purchase.model.vo.Purchase;

/**
 * Servlet implementation class PurchaseToPayServlet
 */
@WebServlet("/PurchaseToPay")
public class PurchaseToPayServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PurchaseToPayServlet() {
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
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		
		int purchaseNo = Integer.parseInt(request.getParameter("purchaseNo"));

		// 3.
		Purchase purchase = new PurchaseService().selectPurchase(purchaseNo);

		// 4.
		RequestDispatcher view = null;
		if (purchase != null) {
			System.out.println("결제페이지 이동 성공");
			view = request.getRequestDispatcher("/mypage/MyinfoCart3.jsp");

			request.setAttribute("purchase", purchase);
			Member member = new MemberService().selectOne(userId);
			request.setAttribute("member", member);
		} else {
			System.out.println("결제페이지 이동 실패");
			view = request.getRequestDispatcher("/PurchaseView");
		}
		view.forward(request, response);
	}

}
