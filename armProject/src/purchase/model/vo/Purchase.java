package purchase.model.vo;

import java.sql.Date;
import java.util.ArrayList;

import order.vo.Order;
import payment.vo.Payment;

public class Purchase implements java.io.Serializable{

	private int purchase_no;
	private String m_name;
	private String grade_name;
	private String m_phone;
	private String m_email;
	private int purchase_price;
	private int delivery;
	private Date purchase_date;
	private ArrayList<Order> orderList;
	private Payment payment;	
	
	public Purchase() {
		// TODO Auto-generated constructor stub
	}

	public Purchase(int purchase_no, String m_name, String grade_name, String m_phone, String m_email, int purchase_price, int delivery,
			Date purchase_date, ArrayList<Order> orderList, Payment payment) {
		super();
		this.purchase_no = purchase_no;
		this.m_name = m_name;
		this.grade_name = grade_name;
		this.m_phone = m_phone;
		this.m_email = m_email;
		this.purchase_price = purchase_price;
		this.delivery = delivery;
		this.purchase_date = purchase_date;
		this.orderList = orderList;
		this.payment = payment;
	}

	@Override
	public String toString() {
		return "Purchase [purchase_no=" + purchase_no + ", m_name=" + m_name + ", grade_name=" + grade_name + ", m_phone=" + m_phone + ", m_email="
				+ m_email + ", purchase_price=" + purchase_price + ", delivery=" + delivery + ", purchase_date=" + purchase_date + ", orderList="
				+ orderList + ", payment=" + payment + "]";
	}

	public int getPurchase_no() {
		return purchase_no;
	}

	public void setPurchase_no(int purchase_no) {
		this.purchase_no = purchase_no;
	}

	public String getM_name() {
		return m_name;
	}

	public void setM_name(String m_name) {
		this.m_name = m_name;
	}

	public String getGrade_name() {
		return grade_name;
	}

	public void setGrade_name(String grade_name) {
		this.grade_name = grade_name;
	}

	public String getM_phone() {
		return m_phone;
	}

	public void setM_phone(String m_phone) {
		this.m_phone = m_phone;
	}

	public String getM_email() {
		return m_email;
	}

	public void setM_email(String m_email) {
		this.m_email = m_email;
	}

	public int getPurchase_price() {
		return purchase_price;
	}

	public void setPurchase_price(int purchase_price) {
		this.purchase_price = purchase_price;
	}

	public int getDelivery() {
		return delivery;
	}

	public void setDelivery(int delivery) {
		this.delivery = delivery;
	}

	public Date getPurchase_date() {
		return purchase_date;
	}

	public void setPurchase_date(Date purchase_date) {
		this.purchase_date = purchase_date;
	}

	public ArrayList<Order> getOrderList() {
		return orderList;
	}

	public void setOrderList(ArrayList<Order> orderList) {
		this.orderList = orderList;
	}

	public Payment getPayment() {
		return payment;
	}

	public void setPayment(Payment payment) {
		this.payment = payment;
	}
}
