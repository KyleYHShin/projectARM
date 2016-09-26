package itemqna.model.vo;

import java.sql.Date;

public class Question implements java.io.Serializable {
	//Field
	private int question_no;
	private String m_id;
	private int item_no;
	private String item_name;
	private int item_sub_no;
	private String item_sub_name;
	private String content;
	private Date date;
	private Answer answer;
	
	//Constructor
	public Question(){}

	public Question(int question_no, String content){
		super();
		this.question_no = question_no;
		this.content = content;		
	}
	
	public Question(int question_no, String m_id, int item_no, String item_name, int item_sub_no, String item_sub_name,
			String content, Date date, Answer answer) {
		super();
		this.question_no = question_no;
		this.m_id = m_id;
		this.item_no = item_no;
		this.item_name = item_name;
		this.item_sub_no = item_sub_no;
		this.item_sub_name = item_sub_name;
		this.content = content;
		this.date = date;
		this.answer = answer;
	}

	public Question(String m_id, int item_no, int item_sub_no, String content) {
		super();
		this.m_id = m_id;
		this.item_no = item_no;
		this.item_sub_no = item_sub_no;
		this.content = content;
	}
	
	

	public Question(int question_no, String m_id, String item_name, String item_sub_name, String content, Date date) {
		super();
		this.question_no = question_no;
		this.m_id = m_id;
		this.item_name = item_name;
		this.item_sub_name = item_sub_name;
		this.content = content;
		this.date = date;
	}

	//Getter & Setter
	public int getQuestion_no() {
		return question_no;
	}

	public void setQuestion_no(int question_no) {
		this.question_no = question_no;
	}

	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}

	public int getItem_no() {
		return item_no;
	}

	public void setItem_no(int item_no) {
		this.item_no = item_no;
	}

	public String getItem_name() {
		return item_name;
	}

	public void setItem_name(String item_name) {
		this.item_name = item_name;
	}

	public int getItem_sub_no() {
		return item_sub_no;
	}

	public void setItem_sub_no(int item_sub_no) {
		this.item_sub_no = item_sub_no;
	}

	public String getItem_sub_name() {
		return item_sub_name;
	}

	public void setItem_sub_name(String item_sub_name) {
		this.item_sub_name = item_sub_name;
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

	public Answer getAnswer() {
		return answer;
	}

	public void setAnswer(Answer answer) {
		this.answer = answer;
	}
	
	@Override
	public String toString(){
		return question_no + ", " + m_id + ", " + item_no + ", " + item_name + "," + item_sub_no
				+ ", " + item_sub_name + ", " + content + ", " + date;
	}
	
}
