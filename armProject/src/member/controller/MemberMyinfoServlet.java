package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberMyinfoServlet
 */
@WebServlet("/myinfo")
public class MemberMyinfoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberMyinfoServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//회원조회 처리용 컨트롤러
		System.out.println("회원정보 구동됨..");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=uth-8");
		
		String userId = request.getParameter("userid");
		
		Member member = new MemberService().selectUser(userId);
		RequestDispatcher rd = null;
		
		if(member != null) {
			
			rd = request.getRequestDispatcher("mypage/MyinfoDetail.jsp");
			request.setAttribute("member", member);
			rd.forward(request, response);
		}else {
			rd = request.getRequestDispatcher("member/memberError.jsp");
			request.setAttribute("code", "myinfo");
			rd.forward(request, response);
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
