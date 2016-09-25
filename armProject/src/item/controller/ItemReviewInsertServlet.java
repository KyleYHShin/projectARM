package item.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import item.model.service.ItemService;
import item.model.vo.Review;

/**
 * Servlet implementation class ItemReviewInsertServlet
 */
@WebServlet("/ItemReviewInsertServlet")
public class ItemReviewInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemReviewInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String userId = request.getParameter("review_writer");
		int score = Integer.parseInt(request.getParameter("review_score"));
		int itemNo = Integer.parseInt(request.getParameter("item_no"));
		int itemSubNo = Integer.parseInt(request.getParameter("item_sub_no"));
		String content = request.getParameter("p_review_input");
		
		Review review = new Review(userId, itemNo, itemSubNo, score, content);
		
		int result = new ItemService().insertReview(review);
		
		if(result > 0)
			response.sendRedirect("/arm/ItemDetailViewServlet?itemNo=" + itemNo);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
