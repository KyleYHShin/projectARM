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

import admin.member.model.service.MemberService;
import admin.member.model.vo.Member;
import cart.model.service.CartService;
import cart.model.vo.Cart;
import member.model.vo.User;
import purchase.model.service.PurchaseService;
import purchase.model.vo.Purchase;

/**
 * Servlet implementation class PurchaseInsertServlet
 */
@WebServlet("/PurchaseInsert")
public class PurchaseInsertServlet extends HttpServlet {
   private static final long serialVersionUID = 1L;

   /**
    * @see HttpServlet#HttpServlet()
    */
   public PurchaseInsertServlet() {
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

      // 3. 주문용 변수들 저장
      String userId = loginUser.getUserId();
      String name = request.getParameter("purName");
      String phone = request.getParameter("purPhone");
      String email = request.getParameter("purEmail");
      String zipcode = request.getParameter("purZipcode");
      String address = request.getParameter("purAddr1") + ",," + request.getParameter("purAddr2");
      int delivery = Integer.parseInt(request.getParameter("delivery"));
      String[] itemPriceList = request.getParameter("itemTotalPrice").split(",");
      int totalPrice = 0;
      for (String s : itemPriceList) {
         totalPrice += Integer.parseInt(s);
      }
      
      // 4.장바구니 데이터
      String[] cartNoList = request.getParameter("cartNo").split(",");
      String[] itemSubNoList = request.getParameter("itemSubNo").split(",");
      String[] itemQtyList = request.getParameter("itemQty").split(",");
      ArrayList<Cart> cartList = new ArrayList<Cart>();
      for (int i = 0; i < cartNoList.length; i++) {
         Cart cart = new Cart();
         cart.setCart_no(Integer.parseInt(cartNoList[i]));
         cart.setItem_sub_no(Integer.parseInt(itemSubNoList[i]));
         cart.setQuantity(Integer.parseInt(itemQtyList[i]));
         cartList.add(cart);
      }

      // 5. DB 입력
      int purchaseNo = new PurchaseService().insertPurchase(userId, name, phone, email, zipcode, address, delivery, totalPrice, cartList);
      
      // 6.
      RequestDispatcher view = null;
      if (purchaseNo > 0) {
         System.out.println("주문 insert 성공");
         view = request.getRequestDispatcher("/mypage/MyinfoCart3.jsp");
         Purchase purchase = new PurchaseService().selectPurchase(purchaseNo);
         request.setAttribute("purchase", purchase);
         
         Member member = new MemberService().selectOne(userId);
         request.setAttribute("member", member);

      } else {
         System.out.println("주문 insert 실패");
         view = request.getRequestDispatcher("/mypage/MyinfoCart.jsp");
         ArrayList<Cart> oldCartList = new CartService().selectAll(userId);
         request.setAttribute("cartList", oldCartList);
         request.setAttribute("errorMsg", "주문 오류 : 다시 시도해 주세요.");
      }
      view.forward(request, response);
   }

}