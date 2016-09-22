package member.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.model.dao.MemberDao;
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
		
		String userName = new MemberDao().login(userId, userPwd);
		
		if(userName != null) {
			HttpSession session = request.getSession(); //새로생성
			System.out.println("session id : " + session.getId());
//			session.setAttribute("loginName", userName);
			User loginUser = new User(userId, userName);
			session.setAttribute("loginUser", loginUser);
//			response.sendRedirect("member/loginsucces.jsp");
			response.sendRedirect("MainLogin.jsp");
			
		}else {
			//실패했을시 불러올 화면
			response.sendRedirect("member/LoginError.jsp");
		}
	}

}
