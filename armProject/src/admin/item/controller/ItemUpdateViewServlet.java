package admin.item.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.item.model.service.ItemService;
import admin.item.model.vo.Item;

/**
 * Servlet implementation class ItemUpdateViewServlet
 */
@WebServlet("/aiupview")
public class ItemUpdateViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemUpdateViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 상품수정화면으로 보내는 서블릿
		System.out.println("수정 view 서블릿 구동...");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int itemNo = Integer.parseInt(request.getParameter("itemno"));
		
		Item item = new ItemService().selectOne(itemNo);
		
		RequestDispatcher view = null;
		if(item != null){
			view = request.getRequestDispatcher("ailist");
			request.setAttribute("item", item);
			view.forward(request, response);
		}else{
			view = request.getRequestDispatcher("ailist");
			request.setAttribute("almsg", "해당 요청이 정상적으로 이루어지지 않았습니다.");
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
