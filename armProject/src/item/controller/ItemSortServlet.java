package item.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.StringTokenizer;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import item.model.vo.Item;

/**
 * Servlet implementation class ItemSortServlet
 */
@WebServlet("/isort")
public class ItemSortServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ItemSortServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	@SuppressWarnings("unchecked")
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//정렬 서블릿
		System.out.println("정렬서블릿 구동..");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		 
		//json으로 보낸 값을 string으로 받는다
		String data = request.getParameter("list");
		//받은 값 확인
		
		System.out.println(data);
		StringTokenizer st = new StringTokenizer(data, "[], ");
		
		System.out.println(st.countTokens());
		int j = 0;
		while(st.hasMoreTokens()){
			System.out.println(st.nextToken());
			switch(j%10){
			case 1://itemNo
			case 2://itemName
			case 3://itemCatNo
			case 4://itemPrice
			case 5://itemCount
			case 6://itemUpdate
			case 7://itemTH
			case 8://itemImg
			case 9://itemImgDt
			}	
			j++;
		}
		
		/*
		//정렬을 누른 화면에서 setAttribute("list",list)처리 해주면 제대로 받을 수 있는거냐..
		ArrayList<Item> list = (ArrayList<Item>)request.getAttribute("list");
		//제대로안받아짐.. 어떡하지...
		
		System.out.println("sort서블릿구동");
		System.out.println(list.toString());
		//제대로 받아진다는 가정아래,
		int sortNo = Integer.parseInt(request.getParameter("sortno"));
		
		switch(sortNo){
		case 1://신상품(update날짜순)
			
			break;
		case 2://조회수
			break;
		case 3://가격높은순
			break;
		case 4://가격낮은순
			break;
		}
		//이게 구현가능한 경우, 각각 comparator상속받은 클래스 하나씩 생성
		
		//정렬한 arraylist 보냄
		RequestDispatcher view = request.getRequestDispatcher("SubPage.jsp");
		request.setAttribute("list", list);
		view.forward(request, response);
		*/
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
