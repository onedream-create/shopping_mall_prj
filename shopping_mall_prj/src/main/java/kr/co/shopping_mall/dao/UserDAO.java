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

}// class
