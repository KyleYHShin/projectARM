package itemqna.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import itemqna.model.service.ItemQnaService;
import itemqna.model.vo.Question;

/**
 * Servlet implementation class ItemQnaInsertServlet
 */
@WebServlet("/ItemQnaInsertServlet")
public class ItemQnaInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemQnaInsertServlet() {
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
		
		String userId = request.getParameter("inquiring_user");
		int qItemNo = Integer.parseInt(request.getParameter("inquired_item_no"));
		int qItemSubNo = Integer.parseInt(request.getParameter("inquired_sub")); //Null 값일 경우 처리 추가해야함
		String qContent = request.getParameter("p_inquiry");
		
		Question question = new Question(userId, qItemNo, qItemSubNo, qContent);
		
		int result = new ItemQnaService().insertQuestion(question);
		
		int itemNo = Integer.parseInt(request.getParameter("inquired_item_no")); 
		if(result > 0)
			response.sendRedirect("/arm/ItemDetailViewServlet?itemNo=" + itemNo);
	}

}
