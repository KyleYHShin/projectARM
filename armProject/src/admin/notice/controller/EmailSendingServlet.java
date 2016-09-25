package admin.notice.controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
 
/**
 * A servlet that takes message details from user and send it as a new e-mail
 * through an SMTP server.
 * 
 * @author www.codejava.net
 * 
 */
@WebServlet("/EmailSendingServlet")
public class EmailSendingServlet extends HttpServlet {
    private String host;
    private String port;
    private String user;
    private String pass;
 
    public void init() {
        // reads SMTP server setting from web.xml file
        ServletContext context = getServletContext();
        host = context.getInitParameter("host");
        port = context.getInitParameter("port");
        user = context.getInitParameter("user");
        pass = context.getInitParameter("pass");
    }
 
    protected void doPost(HttpServletRequest request,
            HttpServletResponse response) throws ServletException, IOException {
        // reads form fields
    	request.setCharacterEncoding("utf-8");
		response.setContentType("text/html; charset=utf-8");
        String recipient = request.getParameter("recipient");
        String subject = request.getParameter("subject");
        
        StringBuilder sb = new StringBuilder();

		sb.append("\t"+ request.getParameter("phone1") + "\t"+request.getParameter("phone2") + 
				"\t"+ request.getParameter("phone3") + "\t"+request.getParameter("email") +
				"\t"+request.getParameter("content"));
		String content = sb.toString();
      
 
        String resultMessage = "";
 
        try {
            EmailUtility.sendEmail(host, port, user, pass, recipient, subject,
                    content);
            resultMessage = "The e-mail was sent successfully";
        } catch (Exception ex) {
            ex.printStackTrace();
        } finally {
        	response.sendRedirect("nlist");
        }
    }
}
