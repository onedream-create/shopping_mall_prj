package kr.co.shopping_mall.dao;

import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.shopping_mall.model.AdminVO;

public class AdminDAO {
	
	public String selectLogin(AdminVO aVO) {
		String admin_id = "";
		//1.������ �����̳� ����
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2.JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. ����������
		String selectId="select admin_id from admin where admin_id=? and admin_pw=?";
		admin_id = jt.queryForObject(selectId, new Object[] {aVO.getAdmin_id(),aVO.getAdmin_pw()},  String.class);
		//4. �����������̳� �ݱ�
		gjt.closeAc();
		return admin_id;
	}
}
