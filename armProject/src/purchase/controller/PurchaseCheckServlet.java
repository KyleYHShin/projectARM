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

import cart.model.service.CartService;
import cart.model.vo.Cart;
import member.model.service.MemberService;
import member.model.vo.Member;
import member.model.vo.User;

/**
 * Servlet implementation class PurchaseCheckServlet
 */
@WebServlet("/PurchaseCheck")
public class PurchaseCheckServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PurchaseCheckServlet() {
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

		//3.사용자의 장바구니 목록 전체 반환
		ArrayList<Cart> cartList = new CartService().selectAll(userId);
		
		//4.사용자 정보 반환
		Member member = new MemberService().selectUser(userId);

		// 3.
		RequestDispatcher view = null;
		if (cartList != null) {
			view = request.getRequestDispatcher("/mypage/MyinfoCart2.jsp");
			request.setAttribute("member", member);
			System.out.println("장바구니 Check 성공");
		} else {
			view = request.getRequestDispatcher("/mypage/MyinfoCart.jsp");
			System.out.println("장바구니 Check 실패");
			request.setAttribute("errorMsg", "주문 목록이 없습니다.");
		}
		request.setAttribute("cartList", cartList);
		view.forward(request, response);
	}

}
