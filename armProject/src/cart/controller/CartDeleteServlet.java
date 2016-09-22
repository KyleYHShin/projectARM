package cart.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import cart.model.service.CartService;

/**
 * Servlet implementation class CartDeleteServlet
 */
@WebServlet("/CartDelete")
public class CartDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartDeleteServlet() {
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

		int result = new CartService().deleteCart(cartNo);

		// 3.
		if (result > 0) {
			System.out.println("delete success");
			response.sendRedirect("/arm/CartView?userId=" + userId);
		} else {
			System.out.println("delete fail");
			response.sendRedirect("/arm/CartView?userId=" + userId);
		}
	}

}
