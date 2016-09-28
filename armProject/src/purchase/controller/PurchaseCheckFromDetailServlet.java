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
 * Servlet implementation class PurchaseCheckFromDetailServlet
 */
@WebServlet("/PurchaseCheckFD")
public class PurchaseCheckFromDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public PurchaseCheckFromDetailServlet() {
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

		// 2. 데이터 생성
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		String userId = loginUser.getUserId();

		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		String[] itemSubNoList = request.getParameter("subNoList").split(",");
		String[] itemQtyList = request.getParameter("qtyList").split(",");

		// 3. 임시 Cart 데이터를 생성하여 cartList에 저장
		ArrayList<Cart> cartList = new ArrayList<Cart>();
		for(int i =0; i<itemSubNoList.length; i++){
			Cart c = new Cart();
			c.setCart_no(0); //임시 카트번호
			c.setItem_no(itemNo);
			c.setItem_sub_no(Integer.parseInt(itemSubNoList[i]));
			c.setQuantity(Integer.parseInt(itemQtyList[i]));
			cartList.add(c);			
		}
		new CartService().reloadCart(cartList);

		// 4.사용자 정보 반환
		Member member = new MemberService().selectUser(userId);

		// 5.
		System.out.println("바로구매 기능 성공");
		RequestDispatcher view = request.getRequestDispatcher("/mypage/MyinfoCart2.jsp");
		request.setAttribute("member", member);
		request.setAttribute("cartList", cartList);
		view.forward(request, response);
	}

}
