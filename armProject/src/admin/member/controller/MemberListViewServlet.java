package admin.member.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.member.model.service.MemberService;
import admin.member.model.vo.Member;

/**
 * Servlet implementation class MemberListViewServlet
 */
@WebServlet("/amlist")
public class MemberListViewServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberListViewServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		 request.setCharacterEncoding("utf-8");
	      response.setContentType("text/html; charset=utf-8");
	      
	      ArrayList<Member> list = new MemberService().memberAll();
	      RequestDispatcher view = null;
	      
	      if(list != null){
	         view = request.getRequestDispatcher("admin/MemberListView.jsp");
	         request.setAttribute("list", list);
	         view.forward(request, response);
	      }else{
	    	  view = request.getRequestDispatcher("admin/MemberListView.jsp");
		      request.setAttribute("msg", "회원 정보 조회가 정상적으로 이루어지지 않았습니다.");
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
