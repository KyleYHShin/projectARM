package admin.item.model.vo;

public class Vender {
	private int venId;
	private String venName;
	public Vender(){}
	public Vender(int venId, String venName) {
		super();
		this.venId = venId;
		this.venName = venName;
	}
	public int getVenId() {
		return venId;
	}
	public void setVenId(int venId) {
		this.venId = venId;
	}
	public String getVenName() {
		return venName;
	}
	public void setVenName(String venName) {
		this.venName = venName;
	}
	@Override
	public String toString() {
		return "Vender [venId=" + venId + ", venName=" + venName + "]";
	};
	
}
