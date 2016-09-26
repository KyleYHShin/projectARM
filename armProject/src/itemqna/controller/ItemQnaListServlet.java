package itemqna.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import itemqna.model.service.ItemQnaService;
import itemqna.model.vo.Question;

/**
 * Servlet implementation class ItemQnaListServlet
 */
@WebServlet("/ilist")
public class ItemQnaListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemQnaListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("문의내역구동...");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		String userId = request.getParameter("userid");
		ArrayList<Question> list = new ItemQnaService().selectMylist(userId);
		
		System.out.println(list);
		RequestDispatcher view = null;
		if(list != null) {
			view = request.getRequestDispatcher("mypage/MyinfoQuestion.jsp");
			
			request.setAttribute("itemlist", list);
			view.forward(request, response);
		}else {
			System.out.println("값이 없습니다");
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
