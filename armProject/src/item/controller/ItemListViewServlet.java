package item.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import item.model.service.ItemService;
import item.model.vo.Item;

/**
 * Servlet implementation class ItemListViewServlet
 */
@WebServlet("/mainlist")
public class ItemListViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemListViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//메인화면, 전체 상품목록보기
		HttpSession session = request.getSession();
		
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		
		System.out.println("메인서블릿 구동..");
		ArrayList<Item> list = new ItemService().selectAllList();
		System.out.println(list);
		
		RequestDispatcher view = null;
		if(list != null){
			//불러오는데 성공했을 경우
			view = request.getRequestDispatcher("Main.jsp");
			request.setAttribute("list", list);
			view.forward(request, response);
			
		}else{
			//불러오는데 실패했거나 조회결과가 없거나.
			view = request.getRequestDispatcher("Main.jsp");
			view.forward(request, response);
			System.out.println("[servlet] 조회 실패...");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		doGet(request, response);
	}

}
