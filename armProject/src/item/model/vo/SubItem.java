package item.model.vo;

import java.io.Serializable;

public class SubItem implements Serializable {

	// Field
	private int itemSubNo;
	private String itemSubName;
	private int itemSubPrice;
	private int itemSubQty;

	// Constructor
	public SubItem() {
	}

	public SubItem(int itemSubNo, String itemSubName, int itemSubPrice, int itemSubQty) {
		super();
		this.itemSubNo = itemSubNo;
		this.itemSubName = itemSubName;
		this.itemSubPrice = itemSubPrice;
		this.itemSubQty = itemSubQty;
	}

	// Getter & Setter
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
		return itemSubNo + ", " + itemSubName + ", " + itemSubPrice + ", " + itemSubQty;
	}

}
