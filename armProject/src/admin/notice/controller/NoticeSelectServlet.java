package admin.notice.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.notice.model.service.NoticeService;
import admin.notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeSelectServlet
 */
@WebServlet("/nselect")
public class NoticeSelectServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeSelectServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int noticeno = Integer.parseInt(request.getParameter("noticeno"));
		Notice notice = new NoticeService().selectone(noticeno);
		
		if(notice!=null) {
			RequestDispatcher view = request.getRequestDispatcher("notice.jsp");
			request.setAttribute("notice", notice);
			view.forward(request, response);
		}else {
			System.out.println("selectone 오류발생");
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
