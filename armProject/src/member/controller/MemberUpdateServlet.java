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
 * Servlet implementation class MemberUpdateServlet
 */
@WebServlet("/mupdate")
public class MemberUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//회원정보 수정 처리용 컨트롤러
		System.out.println("수정 서블릿 구동");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String userId = request.getParameter("userid");
		String password = request.getParameter("password");
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		String zcode = request.getParameter("zcode");
		StringBuilder sb = new StringBuilder();

		sb.append(request.getParameter("address")+",,"+request.getParameter("address2"));
		String address = sb.toString();

		
		Member member = new Member(userId, password, phone, email, zcode, address);
		
		System.out.println(member);
		int result = new MemberService().updateMember(member);
		
		if(result>0) {
			response.sendRedirect("/arm/myinfo?userid="+userId);
			
		}else {
			RequestDispatcher view = request.getRequestDispatcher("myinfo?userid="+userId);
			request.setAttribute("almsg", "회원 탈퇴가 정상적으로 이루어지지 않았습니다");
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
