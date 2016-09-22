package admin.notice.model.vo;

import java.sql.Date;

public class Notice implements java.io.Serializable{

	private int noticeNo;
	private int catNo;
	private String noticeTitle;
	private String content;
	private String noticeFile;
	private Date noticeDate;
		
	public Notice() {
		
	}

	public Notice(int noticeNo, int catNo, String noticeTitle, String content, String noticeFile, Date noticeDate) {
		super();
		this.noticeNo = noticeNo;
		this.catNo = catNo;
		this.noticeTitle = noticeTitle;
		this.content = content;
		this.noticeFile = noticeFile;
		this.noticeDate = noticeDate;
	}

	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public int getCatNo() {
		return catNo;
	}

	public void setCatNo(int catNo) {
		this.catNo = catNo;
	}

	public String getNoticeTitle() {
		return noticeTitle;
	}

	public void setNoticeTitle(String noticeTitle) {
		this.noticeTitle = noticeTitle;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getNoticeFile() {
		return noticeFile;
	}

	public void setNoticeFile(String noticeFile) {
		this.noticeFile = noticeFile;
	}

	public Date getNoticeDate() {
		return noticeDate;
	}

	public void setNoticeDate(Date noticeDate) {
		this.noticeDate = noticeDate;
	}

	@Override
	public String toString() {
		return noticeNo + ", " + catNo + ", " + noticeTitle + ", " + content + ", " + 
				noticeFile + ", " + noticeDate;
	}
	
	
}
