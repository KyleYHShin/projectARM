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

import org.json.simple.*;

import cart.model.service.CartService;
import cart.model.vo.Cart;
import member.model.vo.User;

/**
 * Servlet implementation class CartViewServlet
 */
@WebServlet("/CartReView")
public class CartReViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartReViewServlet() {
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

		ArrayList<Cart> cartList = new CartService().selectAll(userId);

		// 3.
		JSONArray jsonList = new JSONArray();
		//JSONObject result = new JSONObject();
		RequestDispatcher view = request.getRequestDispatcher("/mypage/MyinfoCart.jsp");
		if (cartList != null) {
			System.out.println("장바구니 ReLoad 성공");
			for(Cart c : cartList){
				JSONObject jObj = new JSONObject();
				jObj.put("cartNo", c.getCart_no());
				jObj.put("itemMini", c.getItem_img_mini());
				jObj.put("itemName", c.getItem_name());
				jObj.put("itemSubName", c.getItem_sub_name());
				jObj.put("cartQty", c.getQuantity());
				jObj.put("itemPrice", c.getItem_price());
				jsonList.add(jObj);
			}
			//result.put("cartList", cartList);
		} else {
			System.out.println("장바구니 ReLoad 실패");
		}
		System.out.println(jsonList);
		request.setAttribute("jsonList", jsonList);
		view.forward(request, response);
	}

}
