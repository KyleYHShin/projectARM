package payment.vo;

import java.sql.Date;

public class Payment implements java.io.Serializable {

	private int payment_no;
	private String payment_method;
	private String payment_company;
	private int payment_price;
	private Date payment_date;

	public Payment() {
		// TODO Auto-generated constructor stub
	}

	public Payment(int payment_no, String payment_method, String payment_company, int payment_price, Date payment_date) {
		super();
		this.payment_no = payment_no;
		this.payment_method = payment_method;
		this.payment_company = payment_company;
		this.payment_price = payment_price;
		this.payment_date = payment_date;
	}

	@Override
	public String toString() {
		return "Payment [payment_no=" + payment_no + ", payment_method=" + payment_method + ", payment_company=" + payment_company
				+ ", payment_price=" + payment_price + ", payment_date=" + payment_date + "]";
	}

	public int getPayment_no() {
		return payment_no;
	}

	public void setPayment_no(int payment_no) {
		this.payment_no = payment_no;
	}

	public String getPayment_method() {
		return payment_method;
	}

	public void setPayment_method(String payment_method) {
		this.payment_method = payment_method;
	}

	public String getPayment_company() {
		return payment_company;
	}

	public void setPayment_company(String payment_company) {
		this.payment_company = payment_company;
	}

	public int getPayment_price() {
		return payment_price;
	}

	public void setPayment_price(int payment_price) {
		this.payment_price = payment_price;
	}

	public Date getPayment_date() {
		return payment_date;
	}

	public void setPayment_date(Date payment_date) {
		this.payment_date = payment_date;
	}

}
