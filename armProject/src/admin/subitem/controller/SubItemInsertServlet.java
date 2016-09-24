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
 * Servlet implementation class SubItemInsertServlet
 */
@WebServlet("/asinsert")
public class SubItemInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SubItemInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//서브아이탬 추가
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String itemSubName = request.getParameter("sname");
		int itemNo = Integer.parseInt(request.getParameter("itemno"));
		int itemSubPrice = Integer.parseInt(request.getParameter("sprice"));
		int itemSubQty = Integer.parseInt(request.getParameter("sqty"));
		System.out.println(itemNo);
		
		SubItem subItem = new SubItem();
		subItem.setItemSubName(itemSubName);
		subItem.setItemSubPrice(itemSubPrice);
		subItem.setQuantity(itemSubQty);
		
		int result = new SubItemService().insertSubItem(itemNo, subItem);
		
		if(result > 0){
			response.sendRedirect("aslist?itemNo="+itemNo);
		}else{
			//오류
			System.out.println("상품추가오류");
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
