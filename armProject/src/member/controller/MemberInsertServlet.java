package member.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import member.model.service.MemberService;
import member.model.vo.Member;

/**
 * Servlet implementation class MemberInsertServlet
 */
@WebServlet("/mjoin")
public class MemberInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public MemberInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 회원가입 처리용 컨트롤러
		//1. 전송값에 한글이 있을 경우, 문자 인코딩 처리 
		request.setCharacterEncoding("utf-8"); //html에서 보내는 문자셋을 써줘야한다
		//2. 클라이언트로 보낼 정보에 한글이 포함되어 있을 경우도 인코딩처리함
		response.setContentType("text/html; charset=utf-8"); //다시 보내는 문자셋설정 여기서 오류가 뜨면 파일다운방식으로 변함.서블릿이 연결이안됨
		
		//3. 전송값 꺼내서 변수에 저장하기
		String userId = request.getParameter("userid");
		String userPwd = request.getParameter("userpwd");
		String userName = request.getParameter("username");
		Date birthDate = Date.valueOf(request.getParameter("birthdate"));
		String phone = request.getParameter("phone");
		String email = request.getParameter("email");
		char gender = request.getParameter("gender").charAt(0);
		String zipcode = request.getParameter("zcode");
		StringBuilder sb = new StringBuilder();

		sb.append(request.getParameter("address") +","+request.getParameter("address2"));
		String address = sb.toString();

		
		
		Member member = new Member(userId, userPwd, userName, birthDate, phone, email, gender, zipcode, address);
		
		System.out.println(member);
		//4. dao 객체 메소드 실행하고 결과받음
		//중복된 아이디값이 들어오면 다시 회원가입 메세지를 띄워야댐
		
	
		int result = new MemberService().insertMember(member);
				
		
		if(result>0) {
			response.sendRedirect("member/Login.jsp");
		}else {
			response.sendRedirect("member/MemberJoin.jsp");
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
