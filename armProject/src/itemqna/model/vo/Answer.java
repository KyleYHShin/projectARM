package itemqna.model.vo;

import java.sql.Date;

public class Answer implements java.io.Serializable {
	//Field
	private int answer_no;
	private String content;
	private Date date;
	
	//Constructor
	public Answer(){}
	
	public Answer(int answer_no, String content, Date date) {
		super();
		this.answer_no = answer_no;
		this.content = content;
		this.date = date;
	}

	//Getter & Setter
	public int getAnswer_no() {
		return answer_no;
	}

	public void setAnswer_no(int answer_no) {
		this.answer_no = answer_no;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getDate() {
		return date;
	}

	public void setDate(Date date) {
		this.date = date;
	}
	
	@Override
	public String toString(){
		return answer_no + ", " + content + ", " + date;
	}
	
}
