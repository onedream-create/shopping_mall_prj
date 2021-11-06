package kr.co.shopping_mall.dao;

import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.shopping_mall.model.AdminVO;

public class AdminDAO {
	
	public String selectLogin(AdminVO aVO) {
		String admin_id = "";
		//1.스프링 컨테이너 생성
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2.JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. 쿼리문수행
		String selectId="select admin_id from admin where admin_id=? and admin_pw=?";
		admin_id = jt.queryForObject(selectId, new Object[] {aVO.getAdmin_id(),aVO.getAdmin_pw()},  String.class);
		//4. 스프링컨테이너 닫기
		gjt.closeAc();
		return admin_id;
	}
}
