package cart.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cart.model.service.CartService;
import cart.model.vo.Cart;

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
		String userId = request.getParameter("userId");
		int cartNo = Integer.parseInt(request.getParameter("cartNo"));
		int cartQty = Integer.parseInt(request.getParameter("item_qty"));

		int result = new CartService().updateCart(cartNo, cartQty);

		// 3.
		if (result > 0) {
			System.out.println("update success");
			response.sendRedirect("/arm/CartView?userId=" + userId);
		} else {
			System.out.println("update fail");
			response.sendRedirect("/arm/CartView?userId=" + userId);
		}
	}

}
