package kr.co.shopping_mall.dao;

import java.sql.SQLException;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

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
	 * ���̵�� ��й�ȣ�� �Է¹޾� �̸��� ��ȸ�ϴ� ��
	 * 
	 * @param uVO
	 * @return
	 * @throws SQLException
	 */
	public String selectLogin(UserVO uVO) throws DataAccessException {
		String user_name = "";// �̸��� AES ��ȣȭ�Ǿ� �ִ�.
		// 1. Spring Container ���
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. ������ ����
		String selectId = "select user_name from users where user_id=? and user_pw=?";
		user_name = jt.queryForObject(selectId, new Object[] { uVO.getUser_id(), uVO.getUser_pw() }, String.class);
		// 4. Spring Container �ݱ�
		gjt.closeAc();
		return user_name;
	}// selectLogin

	/**
	 * ���̵�, ��й�ȣ�ǰ˻� : ���̵�� ��й�ȣ�� DB Table�� �����ϴ���?
	 * 
	 * @param user_id ��ȸ�� id, user_pw ��ȸ�� pw
	 * @return ��ȸ�� user_name
	 * @throws SQLException
	 */
	public String selectIdpw(String user_id,String user_pw) throws SQLException {
		String user_name = "";

		// 1. Spring Container ���
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. ��������
		String selectId = "select user_name from users where user_id=?, user_pw=?";
		try {
			// ��ȸ�Ǹ� ��ȸ����� ������ ����
			user_name = jt.queryForObject(selectId, new Object[] { user_id, user_pw }, String.class);
		} catch (EmptyResultDataAccessException erdae) {
			// ��ȸ����� ���� ������ ���ܹ߻�
			user_name = "";
		} // end catch
			// 4. Spring Container �ݱ�
		gjt.closeAc();
		return user_name;
	}// selectId

	/**
	 * ���̵�� ��й�ȣ�� �Է¹޾� DB�� �ִ��� ��ȸ�ϴ� ��
	 * 
	 * @param mvou
	 * @throws SQLException
	 */
	/*
	 * @SuppressWarnings("null") public UserVO searchLogin(String user_id, String
	 * user_pw) throws DataAccessException{ UserVO uv=null;
	 * 
	 * //1. Spring Container ��� GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
	 * //2. JdbcTemplate ��� JdbcTemplate jt=gjt.getJdbcTemplate(); //3. ������ ����
	 * String
	 * searchId="select user_id, user_pw from users where user_id=? and user_pw=?";
	 * uv=jt.queryForObject(searchId, new Object[]
	 * {uv.getUser_id(),uv.getUser_pw()}, new RowMapper<UserVO>() { public UserVO
	 * mapRow(ResultSet rs, int rowNum) throws SQLException{ UserVO uv=new UserVO();
	 * //ResultSet�� ����Ͽ� ��ȸ����� VO�� ���� uv.setUser_id(rs.getString("user_id"));
	 * uv.setUser_pw(rs.getString("user_pw")); //��ȸ����� ������ dv ��ȯ return uv; } });
	 * //4. Spring Container �ݱ� gjt.closeAc(); return uv; }//selectLogin
	 */
}// class
