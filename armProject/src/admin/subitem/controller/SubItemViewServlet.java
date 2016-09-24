package admin.subitem.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.item.model.service.ItemService;
import admin.item.model.vo.Item;
import admin.subitem.model.service.SubItemService;
import admin.subitem.model.vo.SubItem;

/**
 * Servlet implementation class SubItemViewServlet
 */
@WebServlet("/aslist")
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
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int itemNo = Integer.parseInt(request.getParameter("itemNo"));

		ArrayList<SubItem> list = new SubItemService().selectAll(itemNo);
		//item객체 얻어오기
		Item item = new ItemService().selectOne(itemNo);
		
		RequestDispatcher view = null;
		if(list != null){
			view = request.getRequestDispatcher("admin/SubItemListView.jsp");
			request.setAttribute("list", list);
			request.setAttribute("item", item);
			view.forward(request, response);
		}else{
			view = request.getRequestDispatcher("admin/SubItemListView.jsp");
			request.setAttribute("msg", "등록된 옵션이 없습니다.");
			request.setAttribute("item", item);
			view.forward(request, response);
		}
	}

}
