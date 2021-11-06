package kr.co.shopping_mall.dao;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.shopping_mall.model.AdminVO;

public class AdminDAO {
	
	public String checkAccount(String inputId,String inputPw) throws DataAccessException{
		String admin_id=""; 
		//1. Spring COntainer ����
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2.JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. ����������
		String selectLogin="select admin_id from admin where admin_id=? and admin_pw=?";
		admin_id = jt.queryForObject(selectLogin, new Object[] {inputId,inputPw},  String.class);
		//4. Spring COntainer �ݱ�
		gjt.closeAc();
		
		return admin_id;
	}
}
