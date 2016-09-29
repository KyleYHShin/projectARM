package admin.item.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.item.model.service.ItemService;

/**
 * Servlet implementation class ItemDeleteServlet
 */
@WebServlet("/aidelete")
public class ItemDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//item삭제 서블릿
		System.out.println("삭제 서블릿 구동..");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int itemNo = Integer.parseInt(request.getParameter("itemno"));
		//itemsub삭제
		int sresult = new ItemService().deleteSubAll(itemNo);
		if(sresult > 0){
			int result = new ItemService().deleteOne(itemNo);
			if(result > 0){
				response.sendRedirect("ailist");
			}else{
				RequestDispatcher view = request.getRequestDispatcher("ailist");
				request.setAttribute("almsg", "상품 삭제가 정상적으로 이루어지지 않았습니다.");
				view.forward(request, response);
			}
		}else{
			RequestDispatcher view = request.getRequestDispatcher("ailist");
			request.setAttribute("almsg", "상품 삭제가 정상적으로 이루어지지 않았습니다.");
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
