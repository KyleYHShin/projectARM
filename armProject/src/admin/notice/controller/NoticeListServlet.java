package admin.notice.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import admin.notice.model.service.NoticeService;
import admin.notice.model.vo.Faqnotice;
import admin.notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeListServlet
 */
@WebServlet("/nlist")
public class NoticeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeListServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//공지글 전체 조회 처리용 컨트롤러
		System.out.println("구동...");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		String status = request.getParameter("status");
		String spage = request.getParameter("page");
		int page = 1;
		if(spage != null){
			page = Integer.parseInt(spage);
		}
		ArrayList<Notice> list = null;
		ArrayList<Faqnotice> flist = null;
		if(status==null){
			page = 1;
			list = new NoticeService().selectAll(page);
			flist = new NoticeService().selectFaq(page);
		}else if(status.equals("notice")){
			list = new NoticeService().selectAll(page);
			flist = new NoticeService().selectFaq(1);
		}else if(status.equals("faq")){
			list = new NoticeService().selectAll(1);
			flist = new NoticeService().selectFaq(page);
		}
		int totalCount = new NoticeService().getNoticeCount();
		int ftotalCount = new NoticeService().getFaqCount();
		
		RequestDispatcher view = null;

		if(list != null && flist!=null) {
			view = request.getRequestDispatcher("notice/notice.jsp");
			
			request.setAttribute("list", list); 
			request.setAttribute("flist", flist);
			request.setAttribute("page", page);
			request.setAttribute("status", status);
			request.setAttribute("totalCount", totalCount);
			request.setAttribute("ftotalCount", ftotalCount);
			view.forward(request, response);
		}else {
			view = request.getRequestDispatcher("mainlist");
			request.setAttribute("msg", "공지사항 조회가 정상적으로 이루어지지 않았습니다.");
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
