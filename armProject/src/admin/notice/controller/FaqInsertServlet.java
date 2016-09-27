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
 * Servlet implementation class FaqInsertServlet
 */
@WebServlet("/finsert")
public class FaqInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FaqInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("faq입력 구동..");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		
		int fcategory = Integer.parseInt(request.getParameter("fcate"));
		String ftitle = request.getParameter("ftitle");
		String fcontent = request.getParameter("fcontent");
		
		Faqnotice faq = new Faqnotice();
		faq.setFaqcatNo(fcategory);
		faq.setFaqTitle(ftitle);
		faq.setFaqContent(fcontent);
		
		int result2 = new NoticeService().insertNotice(faq);
		if(result2>0) {
			response.sendRedirect("nlist");
		}else {
			System.out.println("faq입력실패");
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
