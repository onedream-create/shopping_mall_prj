package kr.co.shopping_mall.dao;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.shopping_mall.model.ProductVO;

public class AdminDAO {
	
	public String checkAccount(String inputId,String inputPw) throws DataAccessException{
		String admin_id=""; 
		//1. Spring COntainer 생성
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2.JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. 쿼리문수행
		String selectId="select admin_id from admin where admin_id=? and admin_pw=?";
		admin_id = jt.queryForObject(selectId, new Object[] {inputId,inputPw},  String.class);
		//4. Spring COntainer 닫기
		gjt.closeAc();
		return admin_id;
	}
	
	public int changePass(String admin_id, String newPass) throws DataAccessException {
		int cnt = 0;
		
		//스프링컨테이너 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//쿼리 실행
		String updatePw="update admin set admin_pw=? where admin_id=?";
		cnt=jt.update(updatePw,newPass,admin_id);
		//스프링컨테이너 닫기
		gjt.closeAc();
		
		return cnt;
	}
	
	public void addProduct(ProductVO pVO) throws DataAccessException {
		//스프링컨테이너 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//쿼리 실행
		String insertProduct="insert into product(pro_cd,category_cd,pro_name,pro_detail,pro_img,pro_price) values(concat(to_char(sysdate, '\"P\"YYMMDD\"\"'),lpad(pro_cd_seq.nextval,5,'0')),?,?,?,?,?)";
		jt.update(insertProduct,pVO.getCategory_cd(),pVO.getPro_name(),pVO.getPro_detail(),pVO.getPro_img(),pVO.getPro_price());
		//스프링컨테이너 닫기
		gjt.closeAc();
	}
}
