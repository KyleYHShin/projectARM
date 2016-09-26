package admin.notice.controller;

import java.io.BufferedInputStream; 
import java.io.File; 
import java.io.FileInputStream; 
import java.io.IOException; 
import java.io.OutputStream;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet; 
import javax.servlet.http.HttpServletRequest; 
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CheckEmailServlet
 */
@WebServlet("/echeck")
public class CheckEmailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CheckEmailServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected void getImage(HttpServletRequest req, HttpServletResponse resp) throws Exception { 
        // 받을 key 
        String userId= req.getParameter("userId");         

        // 표시할 Image 
        String convFileNm = "C:/Users/Seul/Desktop/실험용img/phone-icon.png"; 
        File tempFile = new File(convFileNm); 

        // 타입 설정. 
        resp.setContentType("image/gif"); 
        javax.servlet.ServletOutputStream servletoutputstream1 = resp 
                .getOutputStream(); 

        // 파일 쓰기. 
        dumpFile(tempFile, servletoutputstream1); 

        servletoutputstream1.flush(); 
        servletoutputstream1.close(); 

        // DB에 저장 등 Open 한 경우에 대한 처리 로 직을 구현합니다. 
         
    } 

    /** 
     * @see outputstrame 에 파일 쓰기. 
     * @param realFile 
     * @param outputstream 
     */ 
    private void dumpFile(File realFile, OutputStream outputstream) { 
        int MAX_BYTE = 4096; 
        byte readByte[] = new byte[MAX_BYTE]; 

        try { 
            BufferedInputStream bufferedinputstream = new BufferedInputStream( 
                    new FileInputStream(realFile)); 
            int i; 
            while ((i = bufferedinputstream.read(readByte, 0, MAX_BYTE)) != -1) { 
                outputstream.write(readByte, 0, i); 
            } 
            bufferedinputstream.close(); 
        } catch (Exception e) { 
           e.printStackTrace();
        } 
    } 
    /* (non-Javadoc) 
     * @see javax.servlet.http.HttpServlet#doGet(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse) 
     */ 
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
                    throws ServletException, IOException { 
        try { 
            getImage(req, resp); 
            System.out.println("메일을 확인했다");
        }catch (Exception e) { 
            System.out.println("err = "  + e.getMessage()); 
        } 
    }

    /* (non-Javadoc) 
     * @see javax.servlet.http.HttpServlet#doPost(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse) 
     */ 
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
                    throws ServletException, IOException { 
        try { 
            getImage(req, resp); 
            System.out.println("메일을 확인했다11");
        }catch (Exception e) { 
            System.out.println("err = "  + e.getMessage()); 
        } 
    } 
}