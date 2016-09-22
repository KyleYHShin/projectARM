package cart.model.vo;

public class Cart implements java.io.Serializable{

	private int cart_no;
	
	private int item_no;
	private String item_name;
	private String item_img_mini;
	private int item_price;
	
	private int item_sub_no;
	private String item_sub_name;
	private int item_sub_price;
	
	private int quantity;	
	private int total_price;
	
	public Cart() {
		// TODO Auto-generated constructor stub
	}

	public Cart(int cart_no, int item_no, String item_name, String item_img_mini, int item_price, int item_sub_no, String item_sub_name,
			int item_sub_price, int quantity, int total_price) {
		super();
		this.cart_no = cart_no;
		this.item_no = item_no;
		this.item_name = item_name;
		this.item_img_mini = item_img_mini;
		this.item_price = item_price;
		this.item_sub_no = item_sub_no;
		this.item_sub_name = item_sub_name;
		this.item_sub_price = item_sub_price;
		this.quantity = quantity;
		this.total_price = total_price;
	}

	@Override
	public String toString() {
		return "Cart [cart_no=" + cart_no + ", item_no=" + item_no + ", item_name=" + item_name + ", item_img_mini=" + item_img_mini + ", item_price="
				+ item_price + ", item_sub_no=" + item_sub_no + ", item_sub_name=" + item_sub_name + ", item_sub_price=" + item_sub_price
				+ ", quantity=" + quantity + ", total_price=" + total_price + "]";
	}

	public int getCart_no() {
		return cart_no;
	}

	public void setCart_no(int cart_no) {
		this.cart_no = cart_no;
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

	public String getItem_img_mini() {
		return item_img_mini;
	}

	public void setItem_img_mini(String item_img_mini) {
		this.item_img_mini = item_img_mini;
	}

	public int getItem_price() {
		return item_price;
	}

	public void setItem_price(int item_price) {
		this.item_price = item_price;
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

	public int getItem_sub_price() {
		return item_sub_price;
	}

	public void setItem_sub_price(int item_sub_price) {
		this.item_sub_price = item_sub_price;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public int getTotal_price() {
		return total_price;
	}

	public void setTotal_price(int total_price) {
		this.total_price = total_price;
	}

	
}
