package admin.qna.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.qna.model.service.QnaService;
import admin.qna.model.vo.Answer;
import admin.qna.model.vo.Question;

/**
 * Servlet implementation class QnaListViewServlet
 */
@WebServlet("/QnaListViewServlet")
public class QnaListViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public QnaListViewServlet() {
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
		
		System.out.println("관리자 qna list view 서블릿 구동..");
		
		ArrayList<Question> questionList = new QnaService().selectAllQuestion();
		HashMap<Integer, String> itemList = new QnaService().selectAllItem();
		HashMap<Integer, String> subItemList = new QnaService().selectAllSubItem();
		
		RequestDispatcher view = null;
		if(questionList != null)
			request.setAttribute("questionList", questionList);
		
		if(itemList != null)
			request.setAttribute("itemList", itemList);
		
		if(subItemList != null)
			request.setAttribute("subItemList", subItemList);
		
		view = request.getRequestDispatcher("admin/QnaListView.jsp");
		
		view.forward(request, response);
	}

}
