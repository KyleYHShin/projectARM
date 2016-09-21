package item.model.vo;

import java.sql.Date;

public class Item implements java.io.Serializable{
	//field
	private int itemNo;
	private String itemName;
	private int itemCatNo;
	private int itemPrice;
	private int itemCount;
	private Date itemUpdate;
	private String itemTH;
	private String itemImg;
	private String itemImgDt;
	
	//constructor
	public Item(){}

	public Item(int itemNo, String itemName, int itemCatNo, int itemPrice, int itemCount, Date itemUpdate,
			String itemTH, String itemImg, String itemImgDt) {
		super();
		this.itemNo = itemNo;
		this.itemName = itemName;
		this.itemCatNo = itemCatNo;
		this.itemPrice = itemPrice;
		this.itemCount = itemCount;
		this.itemUpdate = itemUpdate;
		this.itemTH = itemTH;
		this.itemImg = itemImg;
		this.itemImgDt = itemImgDt;
	}
	//getter,setter
	public int getItemNo() {
		return itemNo;
	}

	public void setItemNo(int itemNo) {
		this.itemNo = itemNo;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public int getItemCatNo() {
		return itemCatNo;
	}

	public void setItemCatNo(int itemCatNo) {
		this.itemCatNo = itemCatNo;
	}

	public int getItemPrice() {
		return itemPrice;
	}

	public void setItemPrice(int itemPrice) {
		this.itemPrice = itemPrice;
	}

	public int getItemCount() {
		return itemCount;
	}

	public void setItemCount(int itemCount) {
		this.itemCount = itemCount;
	}

	public Date getItemUpdate() {
		return itemUpdate;
	}

	public void setItemUpdate(Date itemUpdate) {
		this.itemUpdate = itemUpdate;
	}

	public String getItemTH() {
		return itemTH;
	}

	public void setItemTH(String itemTH) {
		this.itemTH = itemTH;
	}

	public String getItemImg() {
		return itemImg;
	}

	public void setItemImg(String itemImg) {
		this.itemImg = itemImg;
	}

	public String getItemImgDt() {
		return itemImgDt;
	}

	public void setItemImgDt(String itemImgDt) {
		this.itemImgDt = itemImgDt;
	}

	@Override
	public String toString() {
		return "Item [itemNo=" + itemNo + ", itemName=" + itemName + ", itemCatNo=" + itemCatNo + ", itemPrice="
				+ itemPrice + ", itemCount=" + itemCount + ", itemUpdate=" + itemUpdate + ", itemTH=" + itemTH
				+ ", itemImg=" + itemImg + ", itemImgDt=" + itemImgDt + "]";
	}
	

}
