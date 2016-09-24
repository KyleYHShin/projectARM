package admin.item.model.vo;

import java.sql.Date;

public class Item implements java.io.Serializable{
	private int ItemNo;
	private String ItemName;
	private int ItemCatNo;
	private int ItemPrice;
	private int ItemCount;
	private Date ItemUpdate;
	private int ItemVender;
	private String ItemImgMini;
	private String ItemImg;
	private String ItemImgDetail;
	private String ItemTag;
	
	public Item(){}

	
	public Item(String itemName, int itemCatNo, int itemPrice, int itemVender, String itemTag) {
		super();
		ItemName = itemName;
		ItemCatNo = itemCatNo;
		ItemPrice = itemPrice;
		ItemVender = itemVender;
		ItemTag = itemTag;
	}

	public Item(int itemNo, String itemName, int itemCatNo, int itemPrice, Date itemUpdate, int itemVender,
			String itemImgMini, String itemImg, String itemImgDetail, String itemTag) {
		super();
		ItemNo = itemNo;
		ItemName = itemName;
		ItemCatNo = itemCatNo;
		ItemPrice = itemPrice;
		ItemUpdate = itemUpdate;
		ItemVender = itemVender;
		ItemImgMini = itemImgMini;
		ItemImg = itemImg;
		ItemImgDetail = itemImgDetail;
		ItemTag = itemTag;
	}

	public int getItemNo() {
		return ItemNo;
	}

	public void setItemNo(int itemNo) {
		ItemNo = itemNo;
	}

	public String getItemName() {
		return ItemName;
	}

	public void setItemName(String itemName) {
		ItemName = itemName;
	}

	public int getItemCatNo() {
		return ItemCatNo;
	}

	public void setItemCatNo(int itemCatNo) {
		ItemCatNo = itemCatNo;
	}

	public int getItemPrice() {
		return ItemPrice;
	}

	public void setItemPrice(int itemPrice) {
		ItemPrice = itemPrice;
	}

	public int getItemCount() {
		return ItemCount;
	}

	public void setItemCount(int itemCount) {
		ItemCount = itemCount;
	}

	public Date getItemUpdate() {
		return ItemUpdate;
	}

	public void setItemUpdate(Date itemUpdate) {
		ItemUpdate = itemUpdate;
	}

	public int getItemVender() {
		return ItemVender;
	}

	public void setItemVender(int itemVender) {
		ItemVender = itemVender;
	}

	public String getItemImgMini() {
		return ItemImgMini;
	}

	public void setItemImgMini(String itemImgMini) {
		ItemImgMini = itemImgMini;
	}

	public String getItemImg() {
		return ItemImg;
	}

	public void setItemImg(String itemImg) {
		ItemImg = itemImg;
	}

	public String getItemImgDetail() {
		return ItemImgDetail;
	}

	public void setItemImgDetail(String itemImgDetail) {
		ItemImgDetail = itemImgDetail;
	}

	public String getItemTag() {
		return ItemTag;
	}

	public void setItemTag(String itemTag) {
		ItemTag = itemTag;
	}

	@Override
	public String toString() {
		return ItemNo + ", " + ItemName + ", " + ItemCatNo + ", " + ItemPrice + ", " + ItemCount + ", " + 
				ItemUpdate + ", " + ItemVender + ", " + ItemImgMini + ", " + ItemImg + ", " + ItemImgDetail + ", " +  ItemTag;
	}
	
	
}
