package item.model.vo;

import java.io.Serializable;
import java.sql.Date;

public class Review implements Serializable {

	// Field
	private int reviewNo;
	private String mId;
	private int itemNo;
	private int itemSubNo;
	private int score;
	private String reviewContent;
	private Date reviewDate;

	// Constructor
	public Review() {}

	public Review(int reviewNo, String mId, int itemNo, int itemSubNo, int score, String reviewContent, Date reviewDate) {
		super();
		this.reviewNo = reviewNo;
		this.mId = mId;
		this.itemNo = itemNo;
		this.itemSubNo = itemSubNo;
		this.score = score;
		this.reviewContent = reviewContent;
		this.reviewDate = reviewDate;
	}

	// Getter & Setter
	public int getReviewNo() {
		return reviewNo;
	}

	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
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

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public String getReviewContent() {
		return reviewContent;
	}

	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}

	public Date getReviewDate() {
		return reviewDate;
	}

	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}

	@Override
	public String toString() {
		return reviewNo + ", " + mId + ", " + itemNo + ", " + itemSubNo + ", " + score + ", " + reviewContent + ", "
				+ reviewDate;
	}

}
