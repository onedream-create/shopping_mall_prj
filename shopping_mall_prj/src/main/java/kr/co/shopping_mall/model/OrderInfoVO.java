package kr.co.shopping_mall.model;

public class OrderInfoVO {
	private String pro_name, ord_cd, ord_date, ord_stat_name;
	private int ord_price;
	
	public String getPro_name() {
		return pro_name;
	}
	public void setPro_name(String pro_name) {
		this.pro_name = pro_name;
	}
	public String getOrd_cd() {
		return ord_cd;
	}
	public void setOrd_cd(String ord_cd) {
		this.ord_cd = ord_cd;
	}
	public String getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(String ord_date) {
		this.ord_date = ord_date;
	}
	public String getOrd_stat_name() {
		return ord_stat_name;
	}
	public void setOrd_stat_name(String ord_stat_name) {
		this.ord_stat_name = ord_stat_name;
	}
	public int getOrd_price() {
		return ord_price;
	}
	public void setOrd_price(int ord_price) {
		this.ord_price = ord_price;
	}
	
	
}
