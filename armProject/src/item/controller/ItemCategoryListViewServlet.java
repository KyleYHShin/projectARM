package item.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import item.model.service.ItemService;
import item.model.vo.Item;

/**
 * Servlet implementation class ItemCategoryListViewServlet
 */
@WebServlet("/catlist")
public class ItemCategoryListViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemCategoryListViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//카테고리별 상품목록 보기
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		System.out.println("category servlet 구동..");
		
		int categoryNo = Integer.parseInt(request.getParameter("categoryno"));
		
		ArrayList<Item> list = new ItemService().selectCategoryList(categoryNo);
		
		RequestDispatcher view = null;
		if(list != null){
			//조회성공시
			view = request.getRequestDispatcher("SubPage.jsp");
			request.setAttribute("list", list);
			view.forward(request, response);
		}else{
			//조회실패시 어떻게 처리할까
			view = request.getRequestDispatcher("SubPage.jsp");
			request.setAttribute("msg", "해당하는 상품이 없어요! 죄송..");
			System.out.println("[category servlet] 조회실패..");
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
