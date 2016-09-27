package admin.item.controller;

import java.io.IOException;
import java.util.ArrayList;

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
 * Servlet implementation class ItemSortListView
 */
@WebServlet("/ItemSortListView")
public class ItemSortListView extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemSortListView() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("관리자 상품 정렬 서블릿 구동..");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		 //카테고리 가져오기
	      ArrayList<Category> category= new ItemService().getCategory();
	      //판매처 가져오기
	      ArrayList<Vender> vender=new ItemService().getVender();
		
		String status = request.getParameter("status");
		int sortNo = Integer.parseInt(request.getParameter("sortNo"));
		
		String sort_col = null;
		
		ArrayList<Item> list = null;
		
		switch(sortNo){
		case 1://상품등록날짜(내림차순)
			sort_col = "order by item_update desc";
			System.out.println("날짜 내림차순");
			break;
		case 2://상품등록날짜(오름차순)
			sort_col = "order by item_update asc";
			System.out.println("날짜 오름차순");
			break;
		case 3://상품 이름(내림차순)
			sort_col = "order by item_name desc";
			System.out.println("상품이름 내림차순");
			break;
		case 4://상품 이름(오름차순)
			sort_col = "order by item_name asc";
			System.out.println("상품이름 오름차순");
			break;
		}
		
		RequestDispatcher view = null;
		view = request.getRequestDispatcher("admin/ItemListView.jsp");
		
		list = new ItemService().selectMainList(sort_col);
		
		if(list != null){
			request.setAttribute("sortNo", sortNo);
			request.setAttribute("category", category);
	        request.setAttribute("vender", vender);
	        request.setAttribute("list",list);
	        view.forward(request, response);
			
		
		}else{
			request.setAttribute("sortNo", 0);
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
