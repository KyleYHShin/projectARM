package admin.notice.controller;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class FileDownServlet
 */
@WebServlet("/filedown")
public class FileDownServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public FileDownServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("파일다운 연결...");
		request.setCharacterEncoding("utf-8");
		
		String originalFileName = request.getParameter("ofile");
		String path = request.getSession().getServletContext().getRealPath("/uploadFile/");
		System.out.println(path + originalFileName);
		ServletOutputStream downOut = response.getOutputStream();
		File downfile = new File(path + originalFileName);
		
		response.setContentType("text/plain; charset=utf-8");		
		//한글 파일명 인코딩 처리
		response.addHeader("Content-Disposition", "attachment; filename=\"" + 
		 new String(originalFileName.getBytes("UTF-8"), "ISO-8859-1") + 
		 "\"");
		response.setContentLength((int) downfile.length());

		FileInputStream input = new FileInputStream(downfile);
		BufferedInputStream buf = new BufferedInputStream(input);
		int readBytes = 0;

		while ((readBytes = buf.read()) != -1) {
			downOut.write(readBytes);
		}
		downOut.close();
		buf.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
