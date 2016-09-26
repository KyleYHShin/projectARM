package cart.controller;

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
import member.model.vo.User;

/**
 * Servlet implementation class CartUpdateServlet
 */
@WebServlet("/CartUpdate")
public class CartUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartUpdateServlet() {
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
		int cart_no = Integer.parseInt(request.getParameter("cartNo"));
		int cart_qty = Integer.parseInt(request.getParameter("cartQty"));
	
		int result = new CartService().updateCart(cart_no, cart_qty);

		// 3.
		if (result > 0) {
			System.out.println("장바구니 Update 성공");
		} else {
			System.out.println("장바구니 Update 실패");
		}
		response.sendRedirect("/arm/CartView");
	}

}
