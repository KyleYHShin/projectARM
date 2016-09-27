package admin.notice.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.notice.model.service.NoticeService;
import admin.notice.model.vo.Faqnotice;

/**
 * Servlet implementation class FaqUpdateServlet
 */
@WebServlet("/faqupdate")
public class FaqUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("연결됐다");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset= utf-8");
		
		int faqno = Integer.parseInt(request.getParameter("faqno"));
		int fcatno = Integer.parseInt(request.getParameter("fcate"));
		String ftitle = request.getParameter("ftitle");
		String fcontent = request.getParameter("fcontent");
		
		Faqnotice faq = new Faqnotice(faqno, fcatno, ftitle, fcontent);
		
		int result = new NoticeService().updateFAQ(faq);
		
		if(result>0) {
			response.sendRedirect("/arm/nlist");
		}else {
			System.out.println("연결오류");
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
