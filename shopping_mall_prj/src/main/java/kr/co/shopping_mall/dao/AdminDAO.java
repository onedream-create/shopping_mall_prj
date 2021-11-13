package kr.co.shopping_mall.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.shopping_mall.model.ProductVO;
import kr.co.shopping_mall.model.UserVO;

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
		insertProduct.append(" insert into product(pro_cd, category_cd, pro_name, pro_detail, pro_img, pro_price) ")
					 .append(" values(concat(to_char(sysdate, '\"P\"YYMMDD\"'),lpad(pro_cd_seq.nextval,5,'0')),?,?,?,?,?)" );
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
	
	//��ǰ��ú��� ��ǰ���� ī��Ʈ
	public String countProDashData(String flag) throws SQLException {
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
	
	//��ǰ��ú��� ����Ʈ ���
		public List<ProductVO> proDashSearch(String flag, int start, int rowsPerPage) throws SQLException {
			List<ProductVO> list = null;
			// 1. Spring Container ���
			GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
			// 2. JdbcTemplate ���
			JdbcTemplate jt = gjt.getJdbcTemplate();
			// 3. ������ ����
			StringBuilder selectPro = new StringBuilder();
			
			selectPro.append(" select * ");
			selectPro.append(" from	(select rownum as rnum, p.* ");
			selectPro.append("   	 from (select * from product ");
			if(!flag.equals("a")) {
				selectPro.append(" where sell_fl=? ");
			}
			selectPro.append(" order by input_date desc) p) ");  
			selectPro.append(" where  rnum > ? and rnum <= ?+? ");  
			selectPro.append(" order by rnum ");  
			
			if(!flag.equals("a")) {
				list = jt.query(selectPro.toString(),new Object[] {String.valueOf(flag), Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, new SelectPro());
			} else {
				list = jt.query(selectPro.toString(),new Object[] {Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, new SelectPro());				
			}
			// 4. Spring Container �ݱ�
			gjt.closeAc();

			return list;
		}
		
		//��ǰ��ú��� ��ǰ���� ī��Ʈ
		public String countUserDashData(String flag) throws SQLException {
			String cnt = null;
			
			//1. Spring Container ���
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate ���
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. ������ ����
			StringBuilder countUser = new StringBuilder();
			countUser.append(" select count(user_id) from users ");
				
			if(flag == "n" || flag == "y") {
				countUser.append(" where del_fl=? ");
				countUser.append(" and to_char(reg_date,'YYYYMMDD') = to_char(sysdate,'YYYYMMDD') ");
			}

			if(flag == "a") {
				countUser.append(" where del_fl='n' ");
				cnt=jt.queryForObject(countUser.toString(),String.class);
			} else {	
				cnt=jt.queryForObject(countUser.toString(), new Object[] {String.valueOf(flag)},String.class);
			}
			//4. Spring Container �ݱ�
			gjt.closeAc();
			
			return cnt;
		}
		
		//Product===================================================================================================
		//���� RowMapper
		public class SelectUser implements RowMapper<UserVO> {
			public UserVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				UserVO uv = new UserVO();
				uv.setNo(rs.getString("rnum"));
				uv.setUser_id(rs.getString("user_id"));
				uv.setUser_pw(rs.getString("user_pw"));
				uv.setUser_name(rs.getString("user_name"));
				uv.setUser_tel(rs.getString("user_tel"));
				uv.setUser_email(rs.getString("user_email"));
				uv.setUser_addr(rs.getString("user_addr"));
				uv.setGrade_no(rs.getString("grade_no"));
				uv.setGrade_name(rs.getString("grade_name"));
				uv.setReg_date(rs.getString("reg_date"));
				uv.setDel_fl(rs.getString("del_fl"));
				uv.setSec_date(rs.getString("sec_date"));
				return uv;
			}
		}
		
		//���� ��ú��� ����Ʈ���
		public List<UserVO> userDashSearch(String flag, int start, int rowsPerPage){
			List<UserVO> list = null;
			// 1. Spring Container ���
			GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
			// 2. JdbcTemplate ���
			JdbcTemplate jt = gjt.getJdbcTemplate();
			// 3. ������ ����
			StringBuilder selectUser = new StringBuilder();
			
			selectUser.append(" select * ");
			selectUser.append(" from	(select rownum as rnum, u.*, g.grade_name ");
			selectUser.append("   	 from (select * from users ");
			if(!flag.equals("a")) {
				selectUser.append(" 			where del_fl=? ");
				selectUser.append(" 			and to_char(reg_date,'YYYYMMDD') = to_char(sysdate,'YYYYMMDD') ");
			} else { selectUser.append(" 				where del_fl='n' "); }
				
			selectUser.append(" 				order by reg_date desc) u, user_grade g ");
			selectUser.append(" 		 where u.grade_no = g.grade_no) ");
			selectUser.append(" where  rnum > ? and rnum <= ?+? ");  
			selectUser.append(" order by rnum ");  
			
			if(!flag.equals("a")) {
				list = jt.query(selectUser.toString(),new Object[] {String.valueOf(flag), Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, new SelectUser());
			} else {
				list = jt.query(selectUser.toString(),new Object[] {Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, new SelectUser());				
			}
			// 4. Spring Container �ݱ�
			gjt.closeAc();

			return list;
		}
		
		//user_id�� �ش��ϴ� ��������ȸ
		public UserVO getUserInfo(String user_id) throws SQLException{
			UserVO uv=null;
			
			//1. Spring Container ���
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate ���
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. ������ ����
			String selectUserInfo=" select rownum as rnum, u.*, g.grade_name from users u, user_grade g where u.grade_no = g.grade_no and user_id=? ";
			uv=jt.queryForObject(selectUserInfo, new Object[] { String.valueOf(user_id) }, new SelectUser());
					
			//4. Spring Container �ݱ�
			gjt.closeAc();

			return uv;
		}
		
		public void updateUser(String user_name, String grade_no, String user_tel, String user_addr, String user_email, String user_id) {
			// �����������̳� ���
			GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
			// JdbcTemplate ���
			JdbcTemplate jt = gjt.getJdbcTemplate();
			// ���� ����
			String updateUser = " update users set user_name=?, grade_no=?, user_tel=?, user_addr=?, user_email=? where user_id=?";
			jt.update(updateUser, user_name, grade_no, user_tel, user_addr, user_email, user_id);
			// �����������̳� �ݱ�
			gjt.closeAc();
		}
		
		public void secessionUser(String user_id) {
			// �����������̳� ���
			GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
			// JdbcTemplate ���
			JdbcTemplate jt = gjt.getJdbcTemplate();
			// ���� ����
			String secessionUser = " update users set user_pw=null, user_name=null, user_tel=null, user_email=null, del_fl='y', sec_date=sysdate where user_id=?";
			jt.update(secessionUser, user_id);
			// �����������̳� �ݱ�
			gjt.closeAc();
		}
}
