package kr.co.shopping_mall.dao;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;

import kr.co.shopping_mall.model.DeliveryVO;
import kr.co.shopping_mall.model.OrderVO;
import kr.co.shopping_mall.model.UserVO;

public class DeliveryDAO {

	/**
	 * ��� ���� �߰�
	 * 
	 * @param oVO �� �Ķ���� ���� ���� VO
	 * @throws DataAccessException
	 */
	public void insertOrders(OrderVO oVO) throws DataAccessException {
		// 1. ������ �����̳� ����
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate ���
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. ������ ����
		String insertOrders = "insert into orders(ord_cd, dv_name, dv_tel, dv_addr, dv_memo) values(concat(to_char(sysdate, '\\\"P\\\"YYMMDD\\\"\\\"'),lpad(ord_cd_seq.nextval,5,'0')),?,?,?,?)";
		jt.update(insertOrders,oVO.getDv_name(), oVO.getDv_tel(), oVO.getDv_addr(), oVO.getDv_memo());
		String insertDelivery = "insert into delivery(ord_cd, dv_name, dv_tel, dv_addr, dv_memo) values(concat(to_char(sysdate, '\\\"P\\\"YYMMDD\\\"\\\"'),lpad(ord_cd_seq.nextval,5,'0')),?,?,?,?)";
		jt.update(insertDelivery,oVO.getDv_name(), oVO.getDv_tel(), oVO.getDv_addr(), oVO.getDv_memo());
		// 4. �����������̳� �ݱ�
		gjt.closeAc();
	}// insertDelivery
}//class
