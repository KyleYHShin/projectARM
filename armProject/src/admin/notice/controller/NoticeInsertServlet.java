package admin.notice.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.tomcat.util.http.fileupload.servlet.ServletFileUpload;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import admin.notice.model.service.NoticeService;

import admin.notice.model.vo.Notice;

/**
 * Servlet implementation class NoticeInsertServlet
 */
@WebServlet("/ninsert")
public class NoticeInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeInsertServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("공지입력 구동..");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		
		int sizeLimit = 1024*1024*10;
		
		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(!isMultipart){
			RequestDispatcher errorPage = request.getRequestDispatcher("notice/noticeError.jsp");
			request.setAttribute("code", "nomulti");
			errorPage.forward(request, response);
		}
//		저장위치 설정
		String savePath = request.getSession().getServletContext().getRealPath("/uploadFile/");	
		String originalFileName = null;
		String renameFileName = null;
		
		long currentTime = System.currentTimeMillis();
		
		SimpleDateFormat formatFileName = new SimpleDateFormat("yyyyMMddHHmmss");
		
	
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8",
				new DefaultFileRenamePolicy());
		
		
		
		int category = Integer.parseInt(multi.getParameter("cate"));
		String ntitle = multi.getParameter("nTitle");
		String content = multi.getParameter("nContent");
		
		originalFileName = multi.getFilesystemName("nfile");
		
		if(originalFileName != null) {
		renameFileName = formatFileName.format(new java.sql.Date(currentTime)) + "."
				+ originalFileName.substring(originalFileName.lastIndexOf(".")+1);
		
		File saveFile = new File(savePath + "\\" + originalFileName);
		File newFile = new File(savePath + "\\" + renameFileName);
		
		if(!saveFile.renameTo(newFile)){
			int read = 0;
			byte[] buf = new byte[1024];
			
			FileInputStream fin = new FileInputStream(saveFile);
			FileOutputStream fout = new FileOutputStream(newFile);
			
			while((read = fin.read(buf, 0, buf.length))!=-1){
				fout.write(buf);
			}
			fin.close();
			fout.close();
			saveFile.delete();
		}
		
		}else {
			originalFileName = multi.getFilesystemName("null");
		}
		
		Notice notice = new Notice(category, ntitle, content, renameFileName);
			
		int result = new NoticeService().insertNotice(notice);
		System.out.println(notice);
		
		if(result>0) {
			response.sendRedirect("nlist");
		} else {
			RequestDispatcher view = request.getRequestDispatcher("notice/noticeError.jsp");
			request.setAttribute("code", "ninsert");
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
