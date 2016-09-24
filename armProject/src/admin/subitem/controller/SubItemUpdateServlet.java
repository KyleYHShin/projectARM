package admin.subitem.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.subitem.model.service.SubItemService;
import admin.subitem.model.vo.SubItem;

/**
 * Servlet implementation class SubItemUpdateServlet
 */
@WebServlet("/asupdate")
public class SubItemUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubItemUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//상품수정 서블릿
		System.out.println("수정 서블릿 구동..");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int itemNo = Integer.parseInt(request.getParameter("itemno"));
		int itemSubNo = Integer.parseInt(request.getParameter("subno"));
		String itemSubName = request.getParameter("sname");
		int itemSubPrice = Integer.parseInt(request.getParameter("sprice"));
		int itemSubQty = Integer.parseInt(request.getParameter("sqty"));
		
		SubItem subItem = new SubItem(itemSubNo, itemSubName, itemSubPrice, itemSubQty);
		
		int result = new SubItemService().updateOne(subItem);
		
		if(result > 0){
			response.sendRedirect("SubItemViewServlet?itemNo="+itemNo);
		}else{
			System.out.println("수정실패...");
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
