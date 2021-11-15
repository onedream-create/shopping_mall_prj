package kr.co.shopping_mall.dao;


import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * Spring JDBC를 사용하여 DBMS 작업을 하기 위해 jdbcTemplate을 반환하는 일
 * 
 * @author user
 */
public class GetJdbcTemplate {

	private ApplicationContext ac;

	private static GetJdbcTemplate gjt;

	public GetJdbcTemplate() {
	}

	public static GetJdbcTemplate getInstance() {
		if (gjt == null) {
			gjt = new GetJdbcTemplate();
		}
		return gjt;
	}

	private ApplicationContext getAc() {
		//ac 객체가 생성되지 않았거나 , ac 활성화 상태가 아니라면
		if (ac == null || ac != null && !(((ClassPathXmlApplicationContext)ac).isActive())) {
			ac = new ClassPathXmlApplicationContext("kr/co/shopping_mall/dao/applicationContext.xml");
		}
		return ac;
	}

	/**
	 * DBCP 기반의 DBMS 작업을 수행하는 org.springframework.jdbc.core.jdbc.Template 클래스의 객체를
	 * 반환하는 일.
	 * 
	 * @return
	 */
	public JdbcTemplate getJdbcTemplate() {
		JdbcTemplate jt = null;

		ApplicationContext ac = getAc();

		jt = ac.getBean(JdbcTemplate.class);

		return jt;
	}
//	org.apache.commons.dbcp2.BasicDataSource
	public BasicDataSource getDataSource() {
		ApplicationContext ac=getAc();
		BasicDataSource ds= ac.getBean(BasicDataSource.class, "dataSource");
		return ds;
	}

	public void closeAc() {
		// Spring Container에서 메모리 누수가 발생하지 않도록 닫아준다.
		if (ac != null) {
			((ClassPathXmlApplicationContext) ac).close();
			ac=null;
		}
	}
}
