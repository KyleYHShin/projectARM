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

import org.json.simple.JSONObject;

import cart.model.service.CartService;
import cart.model.vo.Cart;
import member.model.vo.User;

/**
 * Servlet implementation class CartInsertServlet
 */
@WebServlet("/CartInsert")
public class CartInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CartInsertServlet() {
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

		// 2. 데이터 저장
		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");
		String userId = loginUser.getUserId();
		
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		String[] itemSubNoList = request.getParameter("subNoList").split(",");
		String[] itemQtyList = request.getParameter("qtyList").split(",");
		
		//3. 입력
		int result = new CartService().insertCart(userId, itemNo, itemSubNoList, itemQtyList);

		//4. 결과 리턴
		JSONObject obj = new JSONObject();
		if(result > 0){
			System.out.println("장바구니 insert 성공");
			obj.put("result", "추가 완료.\n장바구니 페이지로 이동하시겠습니까?");
		}else{
			System.out.println("장바구니 insert 실패");
			obj.put("result", "장바구니 추가 실패. 다시 시도해주세요.");
		}
		response.setContentType("application/x-json; charset=UTF-8");
		response.getWriter().print(obj);
	}

}
