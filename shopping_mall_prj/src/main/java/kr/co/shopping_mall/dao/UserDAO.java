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
	 * 아이디 비밀번호 검사
	 * @param inputId
	 * @param inputPw
	 * @return
	 * @throws DataAccessException
	 */
	public String checkAccount(String inputId,String inputPw) throws DataAccessException{
		String user_id=""; 
		//1. Spring COntainer 생성
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2.JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. 쿼리문수행
		String selectId="select user_id from users where user_id=? and user_pw=?";
		user_id = jt.queryForObject(selectId, new Object[] {inputId,inputPw},  String.class);
		//4. Spring COntainer 닫기
		gjt.closeAc();
		return user_id;
	}
	
	//마이페이지_개인정보 페이지 개인정보 조회
	public UserInfoVO selectInfo(String user_id)throws SQLException{
		UserInfoVO uv=null;
		
		//1. Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. 쿼리문 실행
		String select="select u.user_id, u.user_pw, u.user_name, ud.grade_name, u.user_tel, u.user_email, u.user_addr	"
				+ "	from users u, user_grade ud	"
				+ "	where ud.grade_no=u.grade_no and u.user_id=? ";
		//interface를 anonymous inner class 로 생성하여 그 안에서 조회결과를 VO에 할당
		uv=jt.queryForObject(select, new Object[] { user_id }, 
				new RowMapper<UserInfoVO>() {
					//추상메소드 오버라이딩
					public UserInfoVO mapRow(ResultSet rs, int rowNum)throws SQLException{
						UserInfoVO uv=new UserInfoVO();
						//ResultSet을 사용하여 조회결과를 VO에 저장
						uv.setUser_id(rs.getString("user_id"));
						uv.setUser_name(rs.getString("user_name"));
						uv.setGrade_name(rs.getString("grade_name"));
						uv.setUser_tel(rs.getString("user_tel"));
						uv.setUser_email(rs.getString("user_email"));
						uv.setUser_addr(rs.getString("user_addr"));
						uv.setUser_pw(rs.getString("user_pw"));
						//조회결과를 저장한 uv반환
						return uv;
					}
				});	
		//4. Spring Container 닫기
		gjt.closeAc();
		
		return uv;
	}//selectInfo
	
	//회원정보수정(이메일, 주소)
	public int updateInfo(String user_id, String email, String addr) throws SQLException{
		int cnt=0;
		
		//1. Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. 쿼리문 실행
		String infoUpdate="update users set user_email=?, user_addr=? where user_id=?";
		cnt=jt.update(infoUpdate, email, addr, user_id);
		//4. Spring Container 닫기
		gjt.closeAc();
		
		return cnt;
	}//updateInfo
	
	//비밀번호 변경
	public int updatePass(String user_id, String user_pw) throws SQLException{
		int cnt=0;
		
		//1. Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. 쿼리문 실행
		String passUpdate="update users set user_pw=? where user_id=?";
		cnt=jt.update(passUpdate, user_pw, user_id);
		//4. Spring Container 닫기
		gjt.closeAc();
		
		return cnt;
	}//updatePass
	
	//아이디 찾기(이름, 이메일로 조회)
	public String findId(String inputName,String inputEmail) throws DataAccessException{
		String user_id=""; 
		//1. Spring COntainer 생성
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2.JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. 쿼리문수행
		String selectId="select user_id from users where user_name=? and user_email=?";
		user_id = jt.queryForObject(selectId, new Object[] {inputName,inputEmail},  String.class);
		//4. Spring COntainer 닫기
		gjt.closeAc();
		return user_id;
	}//findId
	
	//비밀번호 찾기(이름, 이메일, 비밀번호로 조회)
	public String findPw(String inputName,String inputEmail, String inputId) throws DataAccessException{
		String user_id=""; 
		//1. Spring COntainer 생성
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		//2.JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		//3. 쿼리문수행
		String selectId="select user_id from users where user_name=? and user_email=? and user_id=?";
		user_id = jt.queryForObject(selectId, new Object[] {inputName,inputEmail, inputId},  String.class);
		//4. Spring COntainer 닫기
		gjt.closeAc();
		return user_id;
	}//findId
	
	//탈퇴 플래그 변경
		public int updateDelFl(String user_id, String user_pw) throws SQLException{
			int cnt=0;
			
			//1. Spring Container 얻기
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate 얻기
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. 쿼리문 실행
			String delFlUpdate="update users set user_pw=null, user_name=null, user_tel=null, user_email=null, del_fl='y', sec_date=sysdate where user_id=?and user_pw=?";
			cnt=jt.update(delFlUpdate, user_id, user_pw);
			//4. Spring Container 닫기
			gjt.closeAc();
			
			return cnt;
		}//updatePass
}// class
