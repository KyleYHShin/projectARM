package member.model.vo;

public class User implements java.io.Serializable{

	private String userId;
	
	private String userName;
	private String grade;
	private int discount;
	
	public User() {}

	public User(String userId,  String userName) {
		super();
		this.userId = userId;
		this.userName = userName;
	}

	

	public User(String userId, String userName, String grade, int discount) {
		super();
		this.userId = userId;
		
		this.userName = userName;
		this.grade = grade;
		this.discount = discount;
	}

	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getGrade() {
		return grade;
	}

	public void setGrade(String grade) {
		this.grade = grade;
	}

	public int getDiscount() {
		return discount;
	}

	public void setDiscount(int discount) {
		this.discount = discount;
	}

	@Override
	public String toString() {
		return userId + ", " + userName + ", " + grade + ", " + discount;
	}
	
	
}
