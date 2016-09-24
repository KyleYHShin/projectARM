package item.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Answer implements Serializable {

	// Field
	private int aNo;
	private int qNo;
	private String aContent;
	private Date aDate;

	// Constructor
	public Answer() {}

	public Answer(int aNo, int qNo, String aContent, Date aDate) {
		super();
		this.aNo = aNo;
		this.qNo = qNo;
		this.aContent = aContent;
		this.aDate = aDate;
	}

	// Getter & Setter
	public int getaNo() {
		return aNo;
	}

	public void setaNo(int aNo) {
		this.aNo = aNo;
	}

	public int getqNo() {
		return qNo;
	}

	public void setqNo(int qNo) {
		this.qNo = qNo;
	}

	public String getaContent() {
		return aContent;
	}

	public void setaContent(String aContent) {
		this.aContent = aContent;
	}

	public Date getaDate() {
		return aDate;
	}

	public void setaDate(Date aDate) {
		this.aDate = aDate;
	}

	@Override
	public String toString() {
		return aNo + ", " + qNo + ", " + aContent + ", " + aDate;
	}

}
