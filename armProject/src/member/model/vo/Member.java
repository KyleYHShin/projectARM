package member.model.vo;

import java.sql.Date;

public class Member implements java.io.Serializable {

	private String userId;
	private String userPwd;
	private String userName;
	private Date birthDate;
	private String phone;
	private String email;
	private char gender;
	private String address;
	private int grade;
	private Date joinDate;
	private String zipCode;
	private String carts;

	public Member() {
	}

	public Member(String userId, String userPwd, String userName) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
	}

	public Member(String userId, String userPwd, String userName, Date birthDate, String phone, String email, char gender, String address, int grade,
			Date joinDate, String zipCode, String carts) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.birthDate = birthDate;
		this.phone = phone;
		this.email = email;
		this.gender = gender;
		this.address = address;
		this.grade = grade;
		this.joinDate = joinDate;
		this.zipCode = zipCode;
		this.carts = carts;
	}

	public Member(String userId, String userPwd, String phone, String email, String zipCode, String address) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.phone = phone;
		this.email = email;
		this.address = address;
		this.zipCode = zipCode;
	}

	public Member(String userId, String userPwd, String userName, Date birthDate, String phone, String email, char gender, String zipCode,
			String address) {
		super();
		this.userId = userId;
		this.userPwd = userPwd;
		this.userName = userName;
		this.birthDate = birthDate;
		this.phone = phone;
		this.email = email;
		this.gender = gender;
		this.address = address;
		this.grade = grade;
		this.zipCode = zipCode;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getUserPwd() {
		return userPwd;
	}

	public void setUserPwd(String userPwd) {
		this.userPwd = userPwd;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public Date getBirthDate() {
		return birthDate;
	}

	public void setBirthDate(Date birthDate) {
		this.birthDate = birthDate;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public char getGender() {
		return gender;
	}

	public void setGender(char gender) {
		this.gender = gender;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getGrade() {
		return grade;
	}

	public void setGrade(int grade) {
		this.grade = grade;
	}

	public Date getJoinDate() {
		return joinDate;
	}

	public void setJoinDate(Date joinDate) {
		this.joinDate = joinDate;
	}

	public String getZipCode() {
		return zipCode;
	}

	public void setZipCode(String zipCode) {
		this.zipCode = zipCode;
	}

	public String getCarts() {
		return carts;
	}

	public void setCarts(String carts) {
		this.carts = carts;
	}

	@Override
	public String toString() {
		return userId + ", " + userPwd + ", " + userName + ", " + birthDate + ", " + phone + ", " + email + ", " + gender + ", " + zipCode + ", "
				+ address + ", " + joinDate;
	}
}