package admin.notice.model.vo;

import java.sql.Date;

public class Faqnotice implements java.io.Serializable{

	private int faqNo;
	private int faqcatNo;
	private String faqcatName;
	private String faqTitle;
	private String faqContent;
	private Date faqDate;
	
	
	public Faqnotice() {
		
	}


	public Faqnotice(int faqNo, int faqcatNo, String faqcatName, String faqTitle, String faqContent, Date faqDate) {
		super();
		this.faqNo = faqNo;
		this.faqcatNo = faqcatNo;
		this.faqcatName = faqcatName;
		this.faqTitle = faqTitle;
		this.faqContent = faqContent;
		this.faqDate = faqDate;
	}
	
	

	public Faqnotice(int faqNo, int faqcatNo, String faqTitle, String faqContent) {
		super();
		this.faqNo = faqNo;
		this.faqcatNo = faqcatNo;
		this.faqTitle = faqTitle;
		this.faqContent = faqContent;
	}
	

	public Faqnotice(int faqcatNo, String faqTitle, String faqContent) {
		super();
		this.faqcatNo = faqcatNo;
		this.faqTitle = faqTitle;
		this.faqContent = faqContent;
	}


	public int getFaqNo() {
		return faqNo;
	}


	public void setFaqNo(int faqNo) {
		this.faqNo = faqNo;
	}


	public int getFaqcatNo() {
		return faqcatNo;
	}


	public void setFaqcatNo(int faqcatNo) {
		this.faqcatNo = faqcatNo;
	}


	public String getFaqTitle() {
		return faqTitle;
	}


	public void setFaqTitle(String faqTitle) {
		this.faqTitle = faqTitle;
	}


	public String getFaqContent() {
		return faqContent;
	}


	public void setFaqContent(String faqContent) {
		this.faqContent = faqContent;
	}


	public Date getFaqDate() {
		return faqDate;
	}


	public void setFaqDate(Date faqDate) {
		this.faqDate = faqDate;
	}
	

	public String getFaqcatName() {
		return faqcatName;
	}


	public void setFaqcatName(String faqcatName) {
		this.faqcatName = faqcatName;
	}


	@Override
	public String toString() {
		return faqNo + ", " + faqcatNo + ", " + faqcatName + ", " + faqTitle + ", " + faqContent + ", " + faqDate;
	}
	
	
}

