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
 * Servlet implementation class ItemSearchServlet
 */
@WebServlet("/isearch")
public class ItemSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemSearchServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//검색처리 서블릿
		System.out.println("검색 servlet 구동..");
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String keyword = request.getParameter("keyword");
		
		ArrayList<Item> list = new ItemService().searchItem(keyword);
		
		RequestDispatcher view = null;
		if(list != null){
			//조회된 내용이 있을 때
			
			//1페이지만 출력하기 위함.
			int totalCount = list.size();
			ArrayList<Item> viewList = new ArrayList<Item>();
			int pLast = 2;
			if(pLast>=list.size()){
				pLast = list.size();
			}
			for(int i = 0 ; i < pLast; i++){
				viewList.add(list.get(i));
			}
			
			view = request.getRequestDispatcher("SubPage.jsp");
			request.setAttribute("list", viewList);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("page", 1);
			request.setAttribute("status", "search");
			request.setAttribute("keyword", keyword);
			request.setAttribute("sortNo", 0);
			view.forward(request, response);
		}else{
			//조회된 내용이 없거나 실패시
			view = request.getRequestDispatcher("SubPage.jsp");
			request.setAttribute("msg", "해당 키워드로 검색된 상품이 없어요!");
			request.setAttribute("status", "err");
			view.forward(request, response);
			System.out.println("조회자료 없거나 실패...");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
