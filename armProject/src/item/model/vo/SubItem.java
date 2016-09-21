package item.model.vo;

public class SubItem implements java.io.Serializable{
	//field
	private int itemSubNo;
	private String itemSubName;
	private int itemSubPrice;
	private int itemSubQty;
	
	//constructor
	public SubItem() {}

	public SubItem(int itemSubNo, String itemSubName, int itemSubPrice, int itemSubQty) {
		super();
		this.itemSubNo = itemSubNo;
		this.itemSubName = itemSubName;
		this.itemSubPrice = itemSubPrice;
		this.itemSubQty = itemSubQty;
	}
	
	//getter,setter
	public int getItemSubNo() {
		return itemSubNo;
	}

	public void setItemSubNo(int itemSubNo) {
		this.itemSubNo = itemSubNo;
	}

	public String getItemSubName() {
		return itemSubName;
	}

	public void setItemSubName(String itemSubName) {
		this.itemSubName = itemSubName;
	}

	public int getItemSubPrice() {
		return itemSubPrice;
	}

	public void setItemSubPrice(int itemSubPrice) {
		this.itemSubPrice = itemSubPrice;
	}

	public int getItemSubQty() {
		return itemSubQty;
	}

	public void setItemSubQty(int itemSubQty) {
		this.itemSubQty = itemSubQty;
	}

	@Override
	public String toString() {
		return "SubItem [itemSubNo=" + itemSubNo + ", itemSubName=" + itemSubName + ", itemSubPrice=" + itemSubPrice
				+ ", itemSubQty=" + itemSubQty + "]";
	}
	

}
