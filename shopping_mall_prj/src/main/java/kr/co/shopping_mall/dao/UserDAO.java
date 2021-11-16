package kr.co.shopping_mall.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.shopping_mall.model.UserInfoVO;
import kr.co.shopping_mall.model.UserVO;
import kr.co.shopping_mall.dao.GetJdbcTemplate;

public class UserDAO {
	/**
	 * ���̵� �ߺ��˻� : ���̵� DB Table�� �����ϴ���?
	 * 
	 * @param user_id ��ȸ�� id
	 * @return ��ȸ�� user_id
	 * @throws SQLException
	 */
	public String selectId(String user_id) throws SQLException {
		String returnId = "";

		// 1. Spring Container ���
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. ��������
		String selectId = "select user_id from users where user_id=?";
		try {
			// ��ȸ�Ǹ� ��ȸ����� ������ ����
			returnId = jt.queryForObject(selectId, new Object[] { user_id }, String.class);
		} catch (EmptyResultDataAccessException erdae) {
			// ��ȸ����� ���� ������ ���ܹ߻�
			returnId = "";
		} // end catch
			// 4. Spring Container �ݱ�
		gjt.closeAc();
		return returnId;
	}// selectId

	/**
	 * ȸ�� ���� �߰�
	 * 
	 * @param uVO �� �Ķ���� ���� ���� VO
	 * @throws DataAccessException
	 */
	public void insertMember(UserVO uVO) throws DataAccessException {
		// 1. ������ �����̳� ����
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. ������ ����
		String insertMember = "insert into users(user_id, user_pw, user_name, user_tel, user_email, user_addr) values(?,?,?,?,?,?)";
		jt.update(insertMember, uVO.getUser_id(), uVO.getUser_pw(), uVO.getUser_name(), uVO.getUser_tel(),
				uVO.getUser_email(), uVO.getUser_addr());
		// 4. �����������̳� �ݱ�
		gjt.closeAc();
	}// insertMember
	
	/**
	 * ���̵� ��й�ȣ �˻�
	 * @param inputId
	 * @param inputPw
	 * @return
	 * @throws DataAccessException
	 */
	public String checkAccount(String inputId,String inputPw) throws DataAccessException{
		String user_id=""; 
		//1. Spring COntainer ����
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2.JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. ����������
		String selectId="select user_id from users where user_id=? and user_pw=?";
		user_id = jt.queryForObject(selectId, new Object[] {inputId,inputPw},  String.class);
		//4. Spring COntainer �ݱ�
		gjt.closeAc();
		return user_id;
	}
	
	//����������_�������� ������ �������� ��ȸ
	public UserInfoVO selectInfo(String user_id)throws SQLException{
		UserInfoVO uv=null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		String select="select u.user_id, u.user_pw, u.user_name, ud.grade_name, u.user_tel, u.user_email, u.user_addr	"
				+ "	from users u, user_grade ud	"
				+ "	where ud.grade_no=u.grade_no and u.user_id=? ";
		//interface�� anonymous inner class �� �����Ͽ� �� �ȿ��� ��ȸ����� VO�� �Ҵ�
		uv=jt.queryForObject(select, new Object[] { user_id }, 
				new RowMapper<UserInfoVO>() {
					//�߻�޼ҵ� �������̵�
					public UserInfoVO mapRow(ResultSet rs, int rowNum)throws SQLException{
						UserInfoVO uv=new UserInfoVO();
						//ResultSet�� ����Ͽ� ��ȸ����� VO�� ����
						uv.setUser_id(rs.getString("user_id"));
						uv.setUser_name(rs.getString("user_name"));
						uv.setGrade_name(rs.getString("grade_name"));
						uv.setUser_tel(rs.getString("user_tel"));
						uv.setUser_email(rs.getString("user_email"));
						uv.setUser_addr(rs.getString("user_addr"));
						uv.setUser_pw(rs.getString("user_pw"));
						//��ȸ����� ������ uv��ȯ
						return uv;
					}
				});	
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return uv;
	}//selectInfo
	
	//ȸ����������(�̸���, �ּ�)
	public int updateInfo(String user_id, String email, String addr) throws SQLException{
		int cnt=0;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		String infoUpdate="update users set user_email=?, user_addr=? where user_id=?";
		cnt=jt.update(infoUpdate, email, addr, user_id);
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return cnt;
	}//updateInfo
	
	//��й�ȣ ����
	public int updatePass(String user_id, String user_pw) throws SQLException{
		int cnt=0;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		String passUpdate="update users set user_pw=? where user_id=?";
		cnt=jt.update(passUpdate, user_pw, user_id);
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return cnt;
	}//updatePass
	
	//���̵� ã��(�̸�, �̸��Ϸ� ��ȸ)
	public String findId(String inputName,String inputEmail) throws DataAccessException{
		String user_id=""; 
		//1. Spring COntainer ����
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2.JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. ����������
		String selectId="select user_id from users where user_name=? and user_email=?";
		user_id = jt.queryForObject(selectId, new Object[] {inputName,inputEmail},  String.class);
		//4. Spring COntainer �ݱ�
		gjt.closeAc();
		return user_id;
	}//findId
	
	//��й�ȣ ã��(�̸�, �̸���, ��й�ȣ�� ��ȸ)
	public String findPw(String inputName,String inputEmail, String inputId) throws DataAccessException{
		String user_id=""; 
		//1. Spring COntainer ����
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2.JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. ����������
		String selectId="select user_id from users where user_name=? and user_email=? and user_id=?";
		user_id = jt.queryForObject(selectId, new Object[] {inputName,inputEmail, inputId},  String.class);
		//4. Spring COntainer �ݱ�
		gjt.closeAc();
		return user_id;
	}//findId
	
	//Ż�� �÷��� ����
		public int updateDelFl(String user_id, String user_pw) throws SQLException{
			int cnt=0;
			
			//1. Spring Container ���
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate ���
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. ������ ����
			String delFlUpdate="update users set user_pw=null, user_name=null, user_tel=null, user_email=null, del_fl='y', sec_date=sysdate where user_id=?and user_pw=?";
			cnt=jt.update(delFlUpdate, user_id, user_pw);
			//4. Spring Container �ݱ�
			gjt.closeAc();
			
			return cnt;
		}//updatePass
}// class
