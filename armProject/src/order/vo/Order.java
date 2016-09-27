package order.vo;

public class Order implements java.io.Serializable {

	private int order_no;
	private int item_no;
	private String item_name;
	private int item_sub_no;
	private String item_sub_name;
	private int order_qty;
	private int order_price;
	private int order_review_no;
	
	//후기 입력 시 사용하기 위한 추가 필드
	private String m_id;

	public Order() {
		// TODO Auto-generated constructor stub
	}

	public Order(int order_no, int item_no, String item_name, int item_sub_no, String item_sub_name, int order_qty, int order_price,
			int order_review_no) {
		super();
		this.order_no = order_no;
		this.item_no = item_no;
		this.item_name = item_name;
		this.item_sub_no = item_sub_no;
		this.item_sub_name = item_sub_name;
		this.order_qty = order_qty;
		this.order_price = order_price;
		this.order_review_no = order_review_no;
	}
	
	public Order(int item_sub_no, String item_sub_name, String m_id) {
		super();
		this.item_sub_no = item_sub_no;
		this.item_sub_name = item_sub_name;
		this.m_id = m_id;
	}

	@Override
	public String toString() {
		return "Order [order_no=" + order_no + ", item_no=" + item_no + ", item_name=" + item_name + ", item_sub_no=" + item_sub_no
				+ ", item_sub_name=" + item_sub_name + ", order_qty=" + order_qty + ", order_price=" + order_price + ", order_review_no="
				+ order_review_no + "]";
	}

	public int getOrder_no() {
		return order_no;
	}

	public void setOrder_no(int order_no) {
		this.order_no = order_no;
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

	public int getOrder_qty() {
		return order_qty;
	}

	public void setOrder_qty(int order_qty) {
		this.order_qty = order_qty;
	}

	public int getOrder_price() {
		return order_price;
	}

	public void setOrder_price(int order_price) {
		this.order_price = order_price;
	}

	public int getOrder_review_no() {
		return order_review_no;
	}

	public void setOrder_review_no(int order_review_no) {
		this.order_review_no = order_review_no;
	}
	
	//후기 입력용 추가 Getter & Setter
	public String getM_id() {
		return m_id;
	}

	public void setM_id(String m_id) {
		this.m_id = m_id;
	}	

}