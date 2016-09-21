package item.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
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
		
		 
		//list.toString으로 받는다
		String data = request.getParameter("list");
		//정렬방식
		int sortNo = Integer.parseInt(request.getParameter("sortno"));
		//받은 값 확인
		System.out.println(data);
		
		RequestDispatcher view = null;
		if(!data.equals("null")){
			//분리, 변수명=값 으로 추출
			StringTokenizer st = new StringTokenizer(data, "[],");
			//총 토큰수 확인
			System.out.println(st.countTokens());
			
			//토근 string 배열에 값만 담기. 단, i%10==0 은 Item객체명.(객체하나당 10개 토큰)
			String[] stArr = new String[st.countTokens()];
			for(int i = 0; i < stArr.length; i ++){
				if(i%10 != 0){
					String temp = st.nextToken().split("=")[1];
					stArr[i] = temp;
					System.out.println(stArr[i]);
				}else{
					stArr[i] = st.nextToken();
					System.out.println(stArr[i]);
				}
			}
			
			//ArrayList<Item>형태로 담기
			ArrayList<Item> list = new ArrayList<Item>();
			for(int i = 0; i < stArr.length/10; i++){
				Item item = new Item();
				item.setItemNo(Integer.parseInt(stArr[1+(i*10)]));
				item.setItemName(stArr[2+(i*10)]);
				item.setItemCatNo(Integer.parseInt(stArr[3+(i*10)]));
				item.setItemPrice(Integer.parseInt(stArr[4+(i*10)]));
				item.setItemCount(Integer.parseInt(stArr[5+(i*10)]));
				item.setItemUpdate(Date.valueOf(stArr[6+(i*10)]));
				item.setItemTH(stArr[7+(i*10)]);
				item.setItemImg(stArr[8+(i*10)]);
				item.setItemImgDt(stArr[9+(i*10)]);
				list.add(item);
				
				System.out.println(item.toString());
				System.out.println("arrayList에담기.."+i);
			}
			
			//정렬방식대 따른 정렬
			switch(sortNo){
			case 1://최신상품(update날짜순)
				list.sort(new DescDate());
				System.out.println("날짜 내림차순..");
				break;
			case 2://조회수
				list.sort(new DescCount());
				System.out.println("조회수 내림차순..");
				break;
			case 3://가격높은순
				list.sort(new DescPrice());
				System.out.println("가격 내림차순..");
				break;
			case 4://가격낮은순
				list.sort(new AscPrice());
				System.out.println("가격 오름차순..");
				break;
			}
			
			//정렬한 arraylist 보냄
			view = request.getRequestDispatcher("SubPage.jsp");
			request.setAttribute("list", list);
			view.forward(request, response);
		}else{
			view = request.getRequestDispatcher("SubPage.jsp");
			request.setAttribute("msg", "정렬할 상품이 존재하지 않아요!");
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
