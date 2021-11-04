package kr.co.shopping_mall.model;

public class OrderDetailVO {

	private String ordd_cd;
	private String ord_cd;
	private String pro_cd;
	private int ordd_qty;
	
	public OrderDetailVO() {
	}

	public OrderDetailVO(String ordd_cd, String ord_cd, String pro_cd, int ordd_qty) {
		this.ordd_cd = ordd_cd;
		this.ord_cd = ord_cd;
		this.pro_cd = pro_cd;
		this.ordd_qty = ordd_qty;
	}

	public String getOrdd_cd() {
		return ordd_cd;
	}

	public void setOrdd_cd(String ordd_cd) {
		this.ordd_cd = ordd_cd;
	}

	public String getOrd_cd() {
		return ord_cd;
	}

	public void setOrd_cd(String ord_cd) {
		this.ord_cd = ord_cd;
	}

	public String getPro_cd() {
		return pro_cd;
	}

	public void setPro_cd(String pro_cd) {
		this.pro_cd = pro_cd;
	}

	public int getOrdd_qty() {
		return ordd_qty;
	}

	public void setOrdd_qty(int ordd_qty) {
		this.ordd_qty = ordd_qty;
	}
}
