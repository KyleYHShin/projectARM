package admin.subitem.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.subitem.model.service.SubItemService;

/**
 * Servlet implementation class SubItemDeleteServlet
 */
@WebServlet("/asdelete")
public class SubItemDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubItemDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//삭제처리용 서블릿
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int itemNo = Integer.parseInt(request.getParameter("itemno"));
		int itemSubNo = Integer.parseInt(request.getParameter("subno"));
		
		int result = new SubItemService().deleteOne(itemSubNo);
		if(result > 0){
			response.sendRedirect("aslist?itemNo="+itemNo);
		}else{
			RequestDispatcher view = request.getRequestDispatcher("aslist?itemNo="+itemNo);
			request.setAttribute("almsg", "옵션 삭제가 정상적으로 이루어지지 않았습니다.");
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
