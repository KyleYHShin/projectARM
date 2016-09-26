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
 * Servlet implementation class ItemPagingServlet
 */
@WebServlet("/ipage")
public class ItemPagingServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemPagingServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 페이징처리용 서블릿
		System.out.println("페이징처리 서블릿 구동..");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String status = (String)request.getParameter("status");
		
		ArrayList<Item> list = null;
		
		//정렬방식
		String ssn = request.getParameter("sortno");
		int sortNo = 0;
		if(ssn != null){
			sortNo = Integer.parseInt(ssn);
		}
		String sort_col = null;
		switch(sortNo){
		case 1://최신상품(update날짜순)
			sort_col = " order by item_update desc";
			System.out.println("날짜 내림차순..");
			break;
		case 2://조회수
			sort_col = " order by item_count desc";
			System.out.println("조회수 내림차순..");
			break;
		case 3://가격높은순
			sort_col = " order by item_price desc";
			System.out.println("가격 내림차순..");
			break;
		case 4://가격낮은순
			sort_col = " order by item_price asc";
			System.out.println("가격 오름차순..");
			break;
		}
		
		//전달된 (출력할)page값
		int page = Integer.parseInt(request.getParameter("page"));
		
		RequestDispatcher view = null;
		view = request.getRequestDispatcher("SubPage.jsp");
		int totalCount = 0;
		//status에 따라 다른 list를 가짐 > list수도 다르다!
		if(status.equals("main")){
			list = new ItemService().selectMainList(sort_col, page);
			totalCount = new ItemService().getTotalCount();
			request.setAttribute("status", status);
		}else if(status.equals("search")){
			String keyword = (String)request.getParameter("keyword");
			list = new ItemService().searchItem(keyword, sort_col, page);
			request.setAttribute("status", status);
			request.setAttribute("keyword", keyword);
		}else if(status.equals("err")){
			request.setAttribute("msg", "정렬할 상품이 존재하지 않아요!");
		}else{
			int categoryNo = Integer.parseInt(status);
			list = new ItemService().selectCategoryList(categoryNo, sort_col, page);
			totalCount = new ItemService().getCategoryCount(categoryNo);
			request.setAttribute("status", status);
		}
	
		if(list != null){
			//총 줄 수
			request.setAttribute("list", list);
			//현제 페이지 전달
			request.setAttribute("totalCount", totalCount);
			
			//pagedraw에서 사용
			request.setAttribute("page", page);
			request.setAttribute("sortNo", sortNo);
			view.forward(request, response);
		}else{
			view = request.getRequestDispatcher("SubPage.jsp");
			request.setAttribute("totalCount", 0);
			request.setAttribute("page", page);
			request.setAttribute("sortNo", 0);
			request.setAttribute("msg", "페이징에러!");
			request.setAttribute("status", "err");
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