package item.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import item.model.service.ItemService;


/**
 * Servlet implementation class ItemReviewDeleteServlet
 */
@WebServlet("/ItemReviewDeleteServlet")
public class ItemReviewDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemReviewDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int rNo = Integer.parseInt(request.getParameter("review_no"));
		
		int result = new ItemService().deleteReview(rNo);
		
		int itemNo = Integer.parseInt(request.getParameter("review_item_no")); 
		if(result > 0)
			response.sendRedirect("/arm/ItemDetailViewServlet?itemNo=" + itemNo);
	}

}
