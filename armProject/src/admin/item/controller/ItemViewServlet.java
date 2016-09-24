package admin.item.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.item.model.service.ItemService;
import admin.item.model.vo.Category;
import admin.item.model.vo.Item;
import admin.item.model.vo.Vender;

/**
 * Servlet implementation class ItemViewServlet
 */
@WebServlet("/ItemViewServlet")
public class ItemViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemViewServlet() {
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
		
		System.out.println("관리자 item list 서블릿 구동..");
		
		//상품리스트 가져오기
		ArrayList<Item> list = new ItemService().selectAll();
		//카테고리 가져오기
		ArrayList<Category> category= new ItemService().getCategory();
		//판매처 가져오기
		ArrayList<Vender> vender=new ItemService().getVender();
		
		RequestDispatcher view = null;
		if(list != null){
			view = request.getRequestDispatcher("admin/ItemListView.jsp");
			request.setAttribute("list", list);
			request.setAttribute("category", category);
			request.setAttribute("vender", vender);
			view.forward(request, response);
		}else{
			// 에러페이지 출력
		}
	}
}
