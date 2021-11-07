package kr.co.shopping_mall.dao;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

public class AdminDAO {
	
	public String checkAccount(String inputId,String inputPw) throws DataAccessException{
		String admin_id=""; 
		//1. Spring COntainer ����
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2.JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. ����������
		String selectId="select admin_id from admin where admin_id=? and admin_pw=?";
		admin_id = jt.queryForObject(selectId, new Object[] {inputId,inputPw},  String.class);
		//4. Spring COntainer �ݱ�
		gjt.closeAc();
		return admin_id;
	}
	
	public int changePass(String admin_id, String newPass) {
		int cnt = 0;
		
		//�����������̳� ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//���� ����
		String updatePw="update admin set admin_pw=? where admin_id=?";
		cnt=jt.update(updatePw,newPass,admin_id);
		//�����������̳� �ݱ�
		gjt.closeAc();
		
		return cnt;
	}
}
