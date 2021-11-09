package kr.co.shopping_mall.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.shopping_mall.model.ProductVO;


public class ProductDAO {
	/**
	 * ī�װ��� ��ǰ������ ���� ī�װ� �ڵ�, ����¡�� ���� ���۵�������ġ, ���İ����� �Ű������� �޴� select
	 * @param category_cd
	 * @param start
	 * @param len
	 * @return
	 * @throws SQLException
	 */
	public List<ProductVO> selectPro(int category_cd, int start, int len) throws SQLException{
		List<ProductVO> list=null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		StringBuilder selectPro=new StringBuilder();
		selectPro.append("select *	")
		.append("	from(select ROWNUM AS RNUM, P.*		")
		.append("	from product P	");
		if(category_cd == 0) {
			selectPro.append("	where ROWNUM <= ?+?)		");
		}else {
			selectPro.append("	where ROWNUM <= ?+? and P.category_cd=?)		");
		}//end else
		selectPro.append("	where RNUM > ?		");
		
		//Dynamic query
		if(category_cd != 0) {
			selectPro.append("	and category_cd=?");
		}//end if
				   
		if(category_cd == 0) {
			//�ڵ尡 0�̸� ��� ��ǰ������ ��ȸ
			list=jt.query(selectPro.toString(),new Object[] {Long.valueOf(start),Long.valueOf(len),Long.valueOf(start)},new SelectPro());
		}else {
			//ī�װ��� ��ǰ������ ��ȸ
			list=jt.query(selectPro.toString(),new Object[] {Long.valueOf(start),Long.valueOf(len),String.valueOf(category_cd),Long.valueOf(start),String.valueOf(category_cd)},new SelectPro());		
		}//end else
		
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return list;
	}//selectDeptEmp
	
	///////////// inner class : ī�װ��� ��ǰ������ ������ ������ Ŭ���� ����////////////
	public class SelectPro implements RowMapper<ProductVO>{
		public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException{
			ProductVO pv=new ProductVO();
			pv.setPro_cd(rs.getString("pro_cd"));
			pv.setCategory_cd(rs.getInt("category_cd"));
			pv.setPro_name(rs.getString("pro_name"));
			pv.setPro_detail(rs.getString("pro_detail"));
			pv.setPro_img(rs.getString("pro_img"));
			pv.setPro_price(rs.getInt("pro_price"));
			pv.setSell_fl(rs.getString("sell_fl"));
			pv.setInput_date(rs.getString("input_date"));
			return pv;
		}//mapRow
	}//SelectPro	
	
	//����¡�� ���� ��ü ������ ���ڵ� ���� ��� �޼ҵ�(ī�װ���)
	public String countPro(int category_cd) throws SQLException{
		String cnt=null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		String count=null;
		
		if(category_cd==0) {
			count="select count(pro_cd) from product";
			cnt=jt.queryForObject(count, String.class);
		}else {
			count="select count(pro_cd) from product where category_cd=?";
			cnt=jt.queryForObject(count, new Object[] {String.valueOf(category_cd)},String.class);
		}//end else
		
		
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return cnt;
	}//countPro	
	
	//����¡�� ���� ��ü ������ ���ڵ� ���� ��� �޼ҵ�(�˻�)
	public String countSearchPro(String searchValue) throws SQLException{
		String cnt=null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		String count=null;
		
		
		count="select count(pro_cd) from product where pro_name like '%' || ? || '%'";
		cnt=jt.queryForObject(count, new Object[] {String.valueOf(searchValue)},String.class);
		
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return cnt;
	}//countPro	
	
	
	//�˻��� ���� ������ ������ ����
	public List<ProductVO> selectSearchPro(String searchValue) throws SQLException{
		List<ProductVO> list=null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		String selectSearch="select * from product where pro_name like '%' || ? || '%'";
		list=jt.query(selectSearch, new Object[] {String.valueOf(searchValue)},new SelectPro());
		//4. Spring Container �ݱ�
		gjt.closeAc();

		return list;
	}//selectSearchPro
	
	//pro_cd�� �ش��ϴ� ��ǰ��������ȸ
	public ProductVO selectPro(String pro_cd) throws SQLException{
		ProductVO pv=null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		String selectDetail="select * from product where pro_cd=?";
		pv=jt.queryForObject(selectDetail, new Object[] { String.valueOf(pro_cd) }, new SelectPro());
				
		//4. Spring Container �ݱ�
		gjt.closeAc();

		return pv;
	}//selectPro
	
}//class
