package item.model.vo;

import java.sql.Date;

public class Answer implements java.io.Serializable{
	//field
	private int aNo;
	private String aContent;
	private Date aDate;
	
	//constructor
	public Answer(){}

	public Answer(int aNo, String aContent, Date aDate) {
		super();
		this.aNo = aNo;
		this.aContent = aContent;
		this.aDate = aDate;
	}
	
	//getter,setter
	public int getaNo() {
		return aNo;
	}

	public void setaNo(int aNo) {
		this.aNo = aNo;
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
		return "Answer [aNo=" + aNo + ", aContent=" + aContent + ", aDate=" + aDate + "]";
	}	
}
