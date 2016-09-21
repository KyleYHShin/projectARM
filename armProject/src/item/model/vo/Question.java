package item.model.vo;

import java.sql.Date;

public class Question implements java.io.Serializable{
	//field
	private int qNo;
	private String mId;
	private int itemNo;
	private int itemSubNo;
	private String qContent;
	private Date qDate;
	private Answer answer;
	
	//constructor
	public Question(){}

	public Question(int qNo, String mId, int itemNo, int itemSubNo, String qContent, Date qDate, Answer answer) {
		super();
		this.qNo = qNo;
		this.mId = mId;
		this.itemNo = itemNo;
		this.itemSubNo = itemSubNo;
		this.qContent = qContent;
		this.qDate = qDate;
		this.answer = answer;
	}
	
	//getter,setter
	public int getqNo() {
		return qNo;
	}

	public void setqNo(int qNo) {
		this.qNo = qNo;
	}

	public String getmId() {
		return mId;
	}

	public void setmId(String mId) {
		this.mId = mId;
	}

	public int getItemNo() {
		return itemNo;
	}

	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}

	public int getItemSubNo() {
		return itemSubNo;
	}

	public void setItemSubNo(int itemSubNo) {
		this.itemSubNo = itemSubNo;
	}

	public String getqContent() {
		return qContent;
	}

	public void setqContent(String qContent) {
		this.qContent = qContent;
	}

	public Date getqDate() {
		return qDate;
	}

	public void setqDate(Date qDate) {
		this.qDate = qDate;
	}

	public Answer getAnswer() {
		return answer;
	}

	public void setAnswer(Answer answer) {
		this.answer = answer;
	}

	@Override
	public String toString() {
		return "Question [qNo=" + qNo + ", mId=" + mId + ", itemNo=" + itemNo + ", itemSubNo=" + itemSubNo
				+ ", qContent=" + qContent + ", qDate=" + qDate + ", answer=" + answer + "]";
	}
}
