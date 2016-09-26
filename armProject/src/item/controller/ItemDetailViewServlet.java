package item.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import item.model.service.ItemService;
import item.model.vo.*;
import member.model.vo.User;
import order.service.OrderService;
import order.vo.Order;


/**
 * Servlet implementation class ItemDetailViewServlet
 */
@WebServlet("/ItemDetailViewServlet")
public class ItemDetailViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemDetailViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));
		
		// 조회수 증가 처리 변수
		int result = new ItemService().addItemCount(itemNo);
		
		Item item = null;
		ArrayList<SubItem> subItemList = null;
		ArrayList<Question> questionList = null;
		ArrayList<Answer> answerList = null;
		ArrayList<Review> reviewList = null;
		HashMap<Integer, String> reviewHContent  = null;
		
		ItemService IS = new ItemService();
		
		//후기 입력용 추가 객체
		ArrayList<Order> orderedSubItemList = null;
		
		// 조회수 증가 처리 성공하면 아이템 상세 보기 페이지로 이동
		if (result > 0) {
			item = IS.selectOne(itemNo);
			subItemList = IS.selectOneSub(itemNo);
			questionList = IS.selectItemQuestion(itemNo);
			
			// 해당 제품에 대한 문의내역이 있을 시, 답변내역도 있는지 조회하여 리턴
			if (questionList != null) 
				answerList = IS.selectItemAnswer(questionList);
			
			reviewList = IS.selectReview(itemNo);
			//해당 제품에 대한 후기 내역이 있을 시, 후기 별점 코멘트를 조회하여 맵 형태로 리턴
			if(reviewList != null)
				reviewHContent = IS.selectReviewHeadContent();
			
			//해당 제품을 구매한 사람만 후기 작성할 수 있도록 구매목록 조회하여 리턴
			orderedSubItemList = new OrderService().selectOrders(subItemList);
			
		}
		
		RequestDispatcher view = null;
		if (item != null) {
			view = request.getRequestDispatcher("/item/ItemDetail.jsp");
			request.setAttribute("item", item);
			request.setAttribute("subItemList", subItemList);

			if (questionList != null)
				request.setAttribute("questionList", questionList);

			if (answerList != null)
				request.setAttribute("answerList", answerList);
			
			if (reviewList != null){
				request.setAttribute("reviewList", reviewList);
				request.setAttribute("reviewHContent", reviewHContent);
			}
			
			if(orderedSubItemList != null){
				request.setAttribute("orderedSubItemList", orderedSubItemList);
			}
			view.forward(request, response);
		}
	}
	

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
