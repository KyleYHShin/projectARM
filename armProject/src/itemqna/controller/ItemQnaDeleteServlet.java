package itemqna.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import itemqna.model.service.ItemQnaService;

/**
 * Servlet implementation class ItemQnaDeleteServlet
 */
@WebServlet("/ItemQnaDeleteServlet")
public class ItemQnaDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemQnaDeleteServlet() {
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
		
		int qNo = Integer.parseInt(request.getParameter("q_no"));		
		int result = new ItemQnaService().deleteQuestion(qNo);
		
		int itemNo = Integer.parseInt(request.getParameter("q_item_no")); 
		if(result > 0)
			response.sendRedirect("/first/ItemDetailViewServlet?itemNo=" + itemNo);
	}

}
