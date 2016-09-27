package admin.notice.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;


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
 * Servlet implementation class NoticeUpdateServlet
 */
@WebServlet("/nupdate")
public class NoticeUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NoticeUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		System.out.println("수정 구동");
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
		
		int sizeLimit = 1024*1024*100;
		

		boolean isMultipart = ServletFileUpload.isMultipartContent(request);
		if(!isMultipart){
			System.out.println("multipart가 아님....");
		}
		String savePath = request.getSession().getServletContext().getRealPath("uploadFile");
		System.out.println("저장경로 : " + savePath);
		
		String onfile = null;
		String nnfile = null;
		
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit, "utf-8", new DefaultFileRenamePolicy());
		
		int noticeNo = Integer.parseInt(multi.getParameter("noticeno"));
		int category = Integer.parseInt(multi.getParameter("cate"));
		String titleName = multi.getParameter("ntitle");
		String content = multi.getParameter("content");
		System.out.println("선택한 번호" +noticeNo);
		Notice notice = new Notice();
		notice.setNoticeNo(noticeNo);
		notice.setCatNo(category);
		notice.setNoticeTitle(titleName);
		notice.setContent(content);
		System.out.println("값이 들어갔나요" + notice );
		Notice ofile = new NoticeService().selectone(noticeNo);
		
		onfile = multi.getFilesystemName("nfile");
		
		String webPath = "arm/web/uploadFile";
		
		if(onfile !=null) {
			if(ofile.getNoticeFile()!=null) {
			String oldfileName = ofile.getNoticeFile().substring(ofile.getNoticeFile().indexOf(webPath)+webPath.length());
			File oldFile = new File(savePath+ "\\" + oldfileName);
			oldFile.delete();
			
		}
		nnfile = noticeNo+"_file."+onfile.substring(onfile.indexOf(".")+1);
		File saveFile = new File(savePath + "\\" + onfile);
		File nowFile = new File(savePath + "\\" + nnfile);
		
		if(!saveFile.renameTo(nowFile)) {
			int read = 0;
			
			byte[] buf = new byte[1024];
			
			//파일 입력용 스트림
			FileInputStream fin = new FileInputStream(saveFile);
			FileOutputStream fout = new FileOutputStream(nowFile);
			
			while((read = fin.read(buf, 0, buf.length)) != -1){
				fout.write(buf);
			}
			fin.close();
			fout.close();
			saveFile.delete();
			
		}
		notice.setNoticeFile(webPath+nnfile);
	}else {
		notice.setNoticeFile(ofile.getNoticeFile());
	}
	
		int result = new NoticeService().updateNotice(notice);
		
		if(result>0){
			response.sendRedirect("/arm/nlist");
		}else{
			RequestDispatcher view = request.getRequestDispatcher("notice/noticeError.jsp");
			request.setAttribute("code", "nupdate");
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
