package admin.subitem.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.subitem.model.service.SubItemService;
import admin.subitem.model.vo.SubItem;

/**
 * Servlet implementation class SubItemViewServlet
 */
@WebServlet("/SubItemViewServlet")
public class SubItemViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubItemViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));

		ArrayList<SubItem> list = new SubItemService().selectAll(itemNo);
		
		RequestDispatcher view = null;
		if(list != null){
			view = request.getRequestDispatcher("admin/SubItemListView.jsp");
			request.setAttribute("list", list);
			view.forward(request, response);
		}else{
			// 에러페이지 출력
		}
	}

}
