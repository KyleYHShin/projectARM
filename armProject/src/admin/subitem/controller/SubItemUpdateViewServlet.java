package admin.subitem.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.subitem.model.service.SubItemService;
import admin.subitem.model.vo.SubItem;

/**
 * Servlet implementation class SubItemUpdateViewServlet
 */
@WebServlet("/asupview")
public class SubItemUpdateViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubItemUpdateViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//update view 서블릿
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int itemNo = Integer.parseInt(request.getParameter("itemno"));
		int itemSubNo = Integer.parseInt(request.getParameter("subno"));
		
		SubItem subItem = new SubItemService().selectOne(itemSubNo);
		if(subItem != null){
			RequestDispatcher view = request.getRequestDispatcher("SubItemViewServlet?itemNo="+itemNo);
			request.setAttribute("subitem", subItem);
			view.forward(request, response);
		}else{
			System.out.println("update view 서블릿 오류..");
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
