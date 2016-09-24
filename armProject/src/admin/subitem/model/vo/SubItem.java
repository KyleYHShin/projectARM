package admin.subitem.model.vo;

public class SubItem {
	private int ItemSubNo;
	private String ItemSubName;
	private int ItemSubPrice;
	private int Quantity;
	
	public SubItem(){}

	public SubItem(int itemSubNo, String itemSubName, int itemSubPrice, int quantity) {
		super();
		ItemSubNo = itemSubNo;
		ItemSubName = itemSubName;
		ItemSubPrice = itemSubPrice;
		Quantity = quantity;
	}

	public int getItemSubNo() {
		return ItemSubNo;
	}

	public void setItemSubNo(int itemSubNo) {
		ItemSubNo = itemSubNo;
	}

	public String getItemSubName() {
		return ItemSubName;
	}

	public void setItemSubName(String itemSubName) {
		ItemSubName = itemSubName;
	}

	public int getItemSubPrice() {
		return ItemSubPrice;
	}

	public void setItemSubPrice(int itemSubPrice) {
		ItemSubPrice = itemSubPrice;
	}

	public int getQuantity() {
		return Quantity;
	}

	public void setQuantity(int quantity) {
		Quantity = quantity;
	}

	@Override
	public String toString() {
		return ItemSubNo + ", " + ItemSubName + ", " + ItemSubPrice + ", " + Quantity;
	}
	
	
	
}
