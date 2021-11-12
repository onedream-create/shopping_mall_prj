package kr.co.shopping_mall.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.shopping_mall.model.ProductVO;

public class AdminDAO {
	
	//HOME===================================================================================================
	public String checkAccount(String inputId, String inputPw) throws DataAccessException {
		String admin_id = "";
		// 1. Spring COntainer ����
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2.JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. ����������
		String selectId = "select admin_id from admin where admin_id=? and admin_pw=?";
		admin_id = jt.queryForObject(selectId, new Object[] { inputId, inputPw }, String.class);
		// 4. Spring COntainer �ݱ�
		gjt.closeAc();
		return admin_id;
	}

	public int changePass(String admin_id, String newPass) throws DataAccessException {
		int cnt = 0;

		// �����������̳� ���
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// ���� ����
		String updatePw = "update admin set admin_pw=? where admin_id=?";
		cnt = jt.update(updatePw, newPass, admin_id);
		// �����������̳� �ݱ�
		gjt.closeAc();

		return cnt;
	}
	
	//Product===================================================================================================
	//��ǰ�߰�
	public void addPro(ProductVO pVO) throws DataAccessException {
		// �����������̳� ���
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// ���� ����
		StringBuilder insertProduct = new StringBuilder();
		insertProduct.append(" insert into product(pro_cd,category_cd,pro_name,pro_detail,pro_img,pro_price) ")
					 .append(" values(concat(to_char(sysdate, '\"P\"YYMMDD\"'),lpad(pro_cd_seq.nextval,5,'0')),?,?,?,?,?" );
		jt.update(insertProduct.toString(), pVO.getCategory_cd(), pVO.getPro_name(), pVO.getPro_detail(), pVO.getPro_img(),
				pVO.getPro_price());
		// �����������̳� �ݱ�
		gjt.closeAc();
	}
	
	//��ǰ RowMapper
	public class SelectPro implements RowMapper<ProductVO> {
		public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			ProductVO pv = new ProductVO();
			pv.setNo(rs.getString("rnum"));
			pv.setPro_cd(rs.getString("pro_cd"));
			pv.setCategory_cd(rs.getInt("category_cd"));
			pv.setPro_name(rs.getString("pro_name"));
			pv.setPro_detail(rs.getString("pro_detail"));
			pv.setPro_img(rs.getString("pro_img"));
			pv.setPro_price(rs.getInt("pro_price"));
			pv.setSell_fl(rs.getString("sell_fl"));
			pv.setInput_date(rs.getString("input_date"));
			return pv;
		}
	}
	
	//��ǰ ����Ʈ ���
	public List<ProductVO> searchPro(String division, String searchValue, int category_cd, int start, int rowsPerPage) throws SQLException {
		List<ProductVO> list = null;
		// 1. Spring Container ���
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. ������ ����
		StringBuilder selectPro = new StringBuilder();
		selectPro.append(" Select * ") 
				 .append(" from (select rownum as rnum, p.* ")
		         		.append(" from ( select * ")
		         				.append(" from product ");
					if(division.equals("1")) {
						selectPro.append("where pro_name");		 
					} else {
						selectPro.append("where pro_cd");
					}
						selectPro.append(" like '%' || ? || '%' ");
					if(category_cd != 0) {
						selectPro.append(" and category_cd=? ");
					}
						selectPro.append(" order by input_date desc) p) ")
							 	 .append(" where rnum > ? and rnum <= ?+? ")	
							 	 .append(" order by rnum ");
		if (category_cd == 0) {
			// �ڵ尡 0�̸� ��ü�з��� ��ǰ�� ��ȸ
			list = jt.query(selectPro.toString(),new Object[] {String.valueOf(searchValue), Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, new SelectPro());
		} else {
			// ī�װ��� ��ǰ������ ��ȸ
			list = jt.query(selectPro.toString(), new Object[] {String.valueOf(searchValue), String.valueOf(category_cd),Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) },new SelectPro());
		} // end else

		// 4. Spring Container �ݱ�
		gjt.closeAc();

		return list;
	}
	
	//����¡�� ���� ��ü ������ ���ڵ� ���� ��� �޼ҵ�
	public String countSearchPro(String division, String searchValue, int category_cd) throws SQLException{
		String cnt = null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		StringBuilder countPro = new StringBuilder();
		countPro.append(" select count(pro_cd) from product ");
			if(division.equals("1")) {
				countPro.append(" where pro_name ");
			} else {
				countPro.append(" where pro_cd ");	
			}
					
			countPro.append(" like '%' || ? || '%' ");
						
			if(category_cd != 0) {
				countPro.append(" and category_cd=? ");
						
				cnt=jt.queryForObject(countPro.toString(), new Object[] {String.valueOf(searchValue),String.valueOf(category_cd)},String.class);
			} else {	
				cnt=jt.queryForObject(countPro.toString(), new Object[] {String.valueOf(searchValue)},String.class);
			}
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return cnt;
	}	
	
	//pro_cd�� �ش��ϴ� ��ǰ��������ȸ
	public ProductVO getProInfo(String pro_cd) throws SQLException{
		ProductVO pv=null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		String selectProInfo=" select rownum as rnum, p.* from product p where pro_cd=? ";
		pv=jt.queryForObject(selectProInfo, new Object[] { String.valueOf(pro_cd) }, new SelectPro());
				
		//4. Spring Container �ݱ�
		gjt.closeAc();

		return pv;
	}
	
	//��ǰ����
	public void deletePro(String pro_cd) throws SQLException {
		// �����������̳� ���
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// ���� ����
		String deletePro = " delete from product where pro_cd=? ";
		jt.update(deletePro, pro_cd);
		// �����������̳� �ݱ�
		gjt.closeAc();
	}
	
	//��ǰ����
	public void updatePro(String pro_cd , String pro_name, String pro_price ,String sell_fl) throws SQLException {
		// �����������̳� ���
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// ���� ����
		String updatePro = " update product set pro_name=?, pro_price=?, sell_fl=?, input_date=sysdate where pro_cd=?";
		jt.update(updatePro, pro_name, pro_price, sell_fl, pro_cd);
		// �����������̳� �ݱ�
		gjt.closeAc();
	}
	
	public String countDashData(String flag) throws SQLException {
		String cnt = null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		StringBuilder countPro = new StringBuilder();
		countPro.append(" select count(pro_cd) from product ");
			
		if(flag == "y" || flag == "n") {countPro.append(" where sell_fl=? ");}
						
		if(flag == "a") {
			cnt=jt.queryForObject(countPro.toString(),String.class);
		} else {	
			cnt=jt.queryForObject(countPro.toString(), new Object[] {String.valueOf(flag)},String.class);
		}
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return cnt;
	}
}
