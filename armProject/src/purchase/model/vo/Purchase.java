package purchase.model.vo;

import java.sql.Date;
import java.util.ArrayList;

import order.vo.Order;

public class Purchase implements java.io.Serializable{

	private int purchaseNo;
	private String gradeName;
	private String userId;
	private String name;
	private String phone;
	private String email;
	private String zipcode;
	private String address;
	private int totalItemPrice;
	private int delivery;
	private Date purchaseDate;
	private char paid;	
	private ArrayList<Order> orderList;
	
	public Purchase() {
		// TODO Auto-generated constructor stub
	}

	public Purchase(int purchaseNo, String gradeName, String userId, String name, String phone, String email, String zipcode, String address,
			int totalItemPrice, int delivery, Date purchaseDate, char paid, ArrayList<Order> orderList) {
		super();
		this.purchaseNo = purchaseNo;
		this.gradeName = gradeName;
		this.userId = userId;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.zipcode = zipcode;
		this.address = address;
		this.totalItemPrice = totalItemPrice;
		this.delivery = delivery;
		this.purchaseDate = purchaseDate;
		this.paid = paid;
		this.orderList = orderList;
	}

	@Override
	public String toString() {
		return "Purchase [purchaseNo=" + purchaseNo + ", gradeName=" + gradeName + ", userId=" + userId + ", name=" + name + ", phone=" + phone
				+ ", email=" + email + ", zipcode=" + zipcode + ", address=" + address + ", totalItemPrice=" + totalItemPrice + ", delivery="
				+ delivery + ", purchaseDate=" + purchaseDate + ", paid=" + paid + ", orderList=" + orderList + "]";
	}

	public int getPurchaseNo() {
		return purchaseNo;
	}

	public void setPurchaseNo(int purchaseNo) {
		this.purchaseNo = purchaseNo;
	}

	public String getGradeName() {
		return gradeName;
	}

	public void setGradeName(String gradeName) {
		this.gradeName = gradeName;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
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

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public int getTotalItemPrice() {
		return totalItemPrice;
	}

	public void setTotalItemPrice(int totalItemPrice) {
		this.totalItemPrice = totalItemPrice;
	}

	public int getDelivery() {
		return delivery;
	}

	public void setDelivery(int delivery) {
		this.delivery = delivery;
	}

	public Date getPurchaseDate() {
		return purchaseDate;
	}

	public void setPurchaseDate(Date purchaseDate) {
		this.purchaseDate = purchaseDate;
	}

	public char getPaid() {
		return paid;
	}

	public void setPaid(char paid) {
		this.paid = paid;
	}

	public ArrayList<Order> getOrderList() {
		return orderList;
	}

	public void setOrderList(ArrayList<Order> orderList) {
		this.orderList = orderList;
	}

}
