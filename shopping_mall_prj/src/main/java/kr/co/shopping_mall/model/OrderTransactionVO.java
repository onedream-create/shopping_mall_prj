package kr.co.shopping_mall.model;

public class OrderTransactionVO {
	private String ord_cd;
	private int ord_stat_cd;
	private String user_id;
	private int ord_price;
	private String ord_date;
	private String dv_name;
	private String dv_tel;
	private String dv_addr;
	private String dv_memo;
	private String ordd_cd;
	private String pro_cd;
	private int ordd_qty;
	
	public OrderTransactionVO() {
	}
	
	public OrderTransactionVO(String ord_cd, int ord_stat_cd, String user_id, int ord_price, String ord_date,
			String dv_name, String dv_tel, String dv_addr, String dv_memo, String ordd_cd, String pro_cd,
			int ordd_qty) {
		this.ord_cd = ord_cd;
		this.ord_stat_cd = ord_stat_cd;
		this.user_id = user_id;
		this.ord_price = ord_price;
		this.ord_date = ord_date;
		this.dv_name = dv_name;
		this.dv_tel = dv_tel;
		this.dv_addr = dv_addr;
		this.dv_memo = dv_memo;
		this.ordd_cd = ordd_cd;
		this.pro_cd = pro_cd;
		this.ordd_qty = ordd_qty;
	}

	public String getOrd_cd() {
		return ord_cd;
	}
	public void setOrd_cd(String ord_cd) {
		this.ord_cd = ord_cd;
	}
	public int getOrd_stat_cd() {
		return ord_stat_cd;
	}
	public void setOrd_stat_cd(int ord_stat_cd) {
		this.ord_stat_cd = ord_stat_cd;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public int getOrd_price() {
		return ord_price;
	}
	public void setOrd_price(int ord_price) {
		this.ord_price = ord_price;
	}
	public String getOrd_date() {
		return ord_date;
	}
	public void setOrd_date(String ord_date) {
		this.ord_date = ord_date;
	}
	public String getDv_name() {
		return dv_name;
	}
	public void setDv_name(String dv_name) {
		this.dv_name = dv_name;
	}
	public String getDv_tel() {
		return dv_tel;
	}
	public void setDv_tel(String dv_tel) {
		this.dv_tel = dv_tel;
	}
	public String getDv_addr() {
		return dv_addr;
	}
	public void setDv_addr(String dv_addr) {
		this.dv_addr = dv_addr;
	}
	public String getDv_memo() {
		return dv_memo;
	}
	public void setDv_memo(String dv_memo) {
		this.dv_memo = dv_memo;
	}
	public String getOrdd_cd() {
		return ordd_cd;
	}
	public void setOrdd_cd(String ordd_cd) {
		this.ordd_cd = ordd_cd;
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
