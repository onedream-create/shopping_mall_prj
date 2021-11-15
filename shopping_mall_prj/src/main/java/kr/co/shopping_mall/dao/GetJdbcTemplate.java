package kr.co.shopping_mall.dao;


import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 * Spring JDBC�� ����Ͽ� DBMS �۾��� �ϱ� ���� jdbcTemplate�� ��ȯ�ϴ� ��
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
		//ac ��ü�� �������� �ʾҰų� , ac Ȱ��ȭ ���°� �ƴ϶��
		if (ac == null || ac != null && !(((ClassPathXmlApplicationContext)ac).isActive())) {
			ac = new ClassPathXmlApplicationContext("kr/co/shopping_mall/dao/applicationContext.xml");
		}
		return ac;
	}

	/**
	 * DBCP ����� DBMS �۾��� �����ϴ� org.springframework.jdbc.core.jdbc.Template Ŭ������ ��ü��
	 * ��ȯ�ϴ� ��.
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
		// Spring Container���� �޸� ������ �߻����� �ʵ��� �ݾ��ش�.
		if (ac != null) {
			((ClassPathXmlApplicationContext) ac).close();
			ac=null;
		}
	}
}
