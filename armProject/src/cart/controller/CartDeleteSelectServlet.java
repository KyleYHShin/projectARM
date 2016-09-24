package cart.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import cart.model.service.CartService;
import member.model.vo.User;

/**
 * Servlet implementation class CartDeleteSelectServlet
 */
@WebServlet("/CartDeleteSelect")
public class CartDeleteSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartDeleteSelectServlet() {
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
		// 선택 삭제 시 장바구니 번호 배열로 전달 받음
		int cartNumbers[] = null;//수정 필요
		int result = 0;

		// 전달받은 장바구니 번호가 한개 이상일 경우만 동작
		if (cartNumbers.length > 0) {
			result = new CartService().deleteCartSelect(cartNumbers);
		}

		// 3.
		if (result > 0) {
			System.out.println("장바구니 DeleteSelect 성공");
		} else {
			System.out.println("장바구니 DeleteSelect 실패");
		}
		response.sendRedirect("/arm/CartView");
	}

}
