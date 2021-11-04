package kr.co.shopping_mall.model;

public class AdminVO {
	
	private String admin_pw;

	public AdminVO() {
	}

	public AdminVO(String admin_pw) {
		this.admin_pw = admin_pw;
	}

	public String getAdmin_pw() {
		return admin_pw;
	}

	public void setAdmin_pw(String admin_pw) {
		this.admin_pw = admin_pw;
	}
}
