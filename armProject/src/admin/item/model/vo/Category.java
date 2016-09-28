package admin.item.model.vo;

public class Category {
	private int itemCategoryNo;
	private String itemCategoryName;
	
	public Category(){}

	public Category(int itemCategoryNo, String itemCategoryName) {
		super();
		this.itemCategoryNo = itemCategoryNo;
		this.itemCategoryName = itemCategoryName;
	}

	public int getItemCategoryNo() {
		return itemCategoryNo;
	}

	public void setItemCategoryNo(int itemCategoryNo) {
		this.itemCategoryNo = itemCategoryNo;
	}

	public String getItemCategoryName() {
		return itemCategoryName;
	}

	public void setItemCategoryName(String itemCategoryName) {
		this.itemCategoryName = itemCategoryName;
	}

	@Override
	public String toString() {
		return "Category [itemCategoryNo=" + itemCategoryNo + ", itemCategoryString=" + itemCategoryName + "]";
	};
	
	
}