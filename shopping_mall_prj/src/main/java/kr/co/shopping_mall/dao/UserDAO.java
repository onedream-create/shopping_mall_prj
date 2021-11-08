package kr.co.shopping_mall.dao;

import java.sql.SQLException;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.shopping_mall.model.UserVO;
import kr.co.shopping_mall.dao.GetJdbcTemplate;

public class UserDAO {
	/**
	 * 아이디 중복검사 : 아이디가 DB Table에 존재하는지?
	 * 
	 * @param user_id 조회할 id
	 * @return 조회된 user_id
	 * @throws SQLException
	 */
	public String selectId(String user_id) throws SQLException {
		String returnId = "";

		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. 쿼리실행
		String selectId = "select user_id from users where user_id=?";
		try {
			// 조회되면 조회결과가 변수에 저장
			returnId = jt.queryForObject(selectId, new Object[] { user_id }, String.class);
		} catch (EmptyResultDataAccessException erdae) {
			// 조회결과가 없을 때에는 예외발생
			returnId = "";
		} // end catch
			// 4. Spring Container 닫기
		gjt.closeAc();
		return returnId;
	}// selectId

	/**
	 * 회원 정보 추가
	 * 
	 * @param uVO 웹 파라메터 값을 가진 VO
	 * @throws DataAccessException
	 */
	public void insertMember(UserVO uVO) throws DataAccessException {
		// 1. 스프링 컨테이너 생성
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. 쿼리문 수행
		String insertMember = "insert into users(user_id, user_pw, user_name, user_tel, user_email, user_addr) values(?,?,?,?,?,?)";
		jt.update(insertMember, uVO.getUser_id(), uVO.getUser_pw(), uVO.getUser_name(), uVO.getUser_tel(),
				uVO.getUser_email(), uVO.getUser_addr());
		// 4. 스프링컨테이너 닫기
		gjt.closeAc();
	}// insertMember

	/**
	 * 아이디와 비밀번호를 입력받아 이름을 조회하는 일
	 * 
	 * @param uVO
	 * @return
	 * @throws SQLException
	 */
	public String selectLogin(UserVO uVO) throws DataAccessException {
		String user_name = "";// 이름은 AES 암호화되어 있다.
		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. 쿼리문 수행
		String selectId = "select user_name from users where user_id=? and user_pw=?";
		user_name = jt.queryForObject(selectId, new Object[] { uVO.getUser_id(), uVO.getUser_pw() }, String.class);
		// 4. Spring Container 닫기
		gjt.closeAc();
		return user_name;
	}// selectLogin

}// class
