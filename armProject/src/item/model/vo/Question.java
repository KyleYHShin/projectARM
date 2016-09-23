package item.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Question implements Serializable {
	// Field
	private int qNo;
	private String mId;
	private int itemNo;
	private int itemSubNo;
	private String qContent;
	private Date qDate;

	// Constructor
	public Question() {
	}

	public Question(int qNo, String mId, int itemNo, int itemSubNo, String qContent, Date qDate) {
		super();
		this.qNo = qNo;
		this.mId = mId;
		this.itemNo = itemNo;
		this.itemSubNo = itemSubNo;
		this.qContent = qContent;
		this.qDate = qDate;
	}

	// Getter & Setter
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

	@Override
	public String toString() {
		return qNo + ", " + mId + ", " + itemNo + ", " + itemSubNo + ", " + qContent + ", " + qDate;
	}
}
