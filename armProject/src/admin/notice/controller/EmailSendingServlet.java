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
		String cat = request.getParameter("q_category");
		
		String recipient = "";
		String cat_name = "";
		
		switch(cat){
		case "delivery": 
			recipient="huaruya@gmail.com";	
			cat_name="배송";
			break;
		case "product" : 
			recipient="huaruya@gmail.com";	
			cat_name="상품";
			break;
		case "order" : 
			recipient="huaruya@gmail.com";	
			cat_name="주문";
			break;
		case "payment" : 
			recipient = "huaruya@gmail.com";	
			cat_name="결제";
			break;
		case "ch/rfd": 
			recipient="huaruya@gmail.com";
			cat_name="교환/환불";
			break;
		case "membership": 
			recipient="huaruya@gmail.com";	
			cat_name="회원";
			break;
		case "etc": 
			recipient="huaruya@gmail.com";	
			cat_name="기타";
			break;
		default : 
			recipient = "huaruya@gmail.com";
			cat_name="기타";
			break;
		}
		
        String subject = "["+cat_name+"] "+request.getParameter("subject");
        
        StringBuilder sb = new StringBuilder();

		sb.append("[연락처] : "+ request.getParameter("phone1") + "-"+request.getParameter("phone2") + 
				"-"+ request.getParameter("phone3") + "\n[이메일] : "+request.getParameter("email") +
				"\n"+request.getParameter("content"));
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
