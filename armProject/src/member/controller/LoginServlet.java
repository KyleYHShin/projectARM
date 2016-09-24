package member.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.service.MemberService;
import member.model.vo.User;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("LoginServlet 구동됨...");
		
		String userId=request.getParameter("userid");
		String userPwd=request.getParameter("userpwd");
		
		System.out.println(userId);
		
		User loginUser = new MemberService().login(userId, userPwd);
		
		if(loginUser != null) {
			HttpSession session = request.getSession(); //새로생성
			System.out.println("session id : " + session.getId());
			session.setAttribute("loginUser", loginUser);
			response.sendRedirect("/arm/SubPage.jsp");
			
		}else {
			//실패했을시 불러올 화면
			RequestDispatcher view = request.getRequestDispatcher("member/Login.jsp");
			request.setAttribute("msg", "아이디 혹은 비밀번호가 다릅니다. 다시 입력해 주세요.");
			view.forward(request, response);
		}
	}

}
