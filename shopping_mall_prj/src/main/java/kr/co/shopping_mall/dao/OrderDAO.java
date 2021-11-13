package kr.co.shopping_mall.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.naming.InitialContext;
import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.transaction.annotation.Transactional;

import kr.co.shopping_mall.model.OrderInfoVO;
import kr.co.shopping_mall.model.OrderTransactionVO;
import kr.co.shopping_mall.model.OrderVO;


public class OrderDAO {
	///////////// inner class ////////////
	public class SelectOrderInfo implements RowMapper<OrderInfoVO>{
		public OrderInfoVO mapRow(ResultSet rs, int rowNum) throws SQLException{
			OrderInfoVO oiv=new OrderInfoVO();
			oiv.setPro_name(rs.getString("pro_name"));
			oiv.setOrd_cd(rs.getString("ord_cd"));
			oiv.setOrd_date(rs.getString("ord_date"));
			oiv.setOrd_stat_name(rs.getString("ord_stat_name"));
			oiv.setOrd_price(rs.getInt("ord_price"));
			return oiv;
		}//mapRow
	}//SelectPro	
	
	//�ֹ����� ��ȸ
	public List<OrderInfoVO> selectOrder(String user_id)throws SQLException{
		List<OrderInfoVO> list=null;
		
		//1. Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ������ ����
		StringBuilder selectOrder=new StringBuilder();
		selectOrder.append("	select pr.pro_name, od.ord_cd, od.ord_date, od.ord_price, ost.ord_stat_name	")
		.append("	from orders od, order_stat ost, order_detail odt, product pr	")
		.append("	where ost.ord_stat_cd=od.ord_stat_cd and odt.ord_cd=od.ord_cd and pr.pro_cd=odt.pro_cd and od.user_id=?	");
		
		list=jt.query(selectOrder.toString(), new Object[] {user_id}, new SelectOrderInfo());
		
		//4. Spring Container �ݱ�
		gjt.closeAc();
		
		return list;
	}//selectOrder
	
	public int updateOrderInfo(String ord_cd) throws DataAccessException{
		int cnt=0;
		//Spring Container ���
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//JdbcTemplate ���
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//���� ����
		String updateOrder="update orders set ord_stat_cd='4' where ord_cd=?";
		
		//update orders set ord_stat_cd='4' where ord_cd=?;
		cnt=jt.update(updateOrder,ord_cd);
		//�����������̳� �ݱ�
		gjt.closeAc();
		
		return cnt;
	}//updateEmp	
	
	/**
	 * orders, delivery, order_detail ���� �߰�
	 * 
	 * @param otVO �� �Ķ���� ���� ���� VO
	 * @throws DataAccessException
	 */
	@SuppressWarnings({ "resource" })
	public void insertOrder(OrderTransactionVO otVO) throws DataAccessException {
		DataSource dataSource = null;
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		
		String seq="select ord_cd_seq.nextval from dual";
		String insertOrders =
			    "insert into orders(ord_cd, user_id, ord_price) values(concat(to_char(sysdate, '\\\"P\\\"YYMMDD\\\"\\\"'),lpad(seq,5,'0')),?,?)"; 
		String insertDelivery = "insert into delivery(ord_cd, dv_name, dv_tel, dv_addr, dv_memo) values(concat(to_char(sysdate, '\\\"P\\\"YYMMDD\\\"\\\"'),lpad(seq,5,'0')),?,?,?,?)";
		String insertOrderDetail = "insert into order_detail(ord_cd, pro_cd, ordd_qty) values(concat(to_char(sysdate, '\\\"P\\\"YYMMDD\\\"\\\"'),lpad(seq,5,'0')),?,?)";
		//String ="select pro_cd, ordd_qty from product where ord_cd=?";
		//"jdbc:oracle:thin:@211.63.89.144:1521:orcl","mall","1234"
		try {
			//1. JNDI ���� ��ü ����
			InitialContext ic= new InitialContext();
			//JDBC Driver �ε�
			dataSource=(DataSource) ic.lookup("dataSource");
			con=dataSource.getConnection();
			try {
				con.setAutoCommit(false);
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			//������ ���� ����
			pstmt=con.prepareStatement(insertOrders);
			//�Ű������� ���޵� �����͸� �������� ����ǥ�� �� ����
			pstmt.setString(1, otVO.getUser_id());
			pstmt.setInt(1, otVO.getOrd_price());
			pstmt.addBatch();
			//���� ����
			pstmt.executeBatch();
			
			//������ ���� ����
			pstmt=con.prepareStatement(insertDelivery);
			//�Ű������� ���޵� �����͸� �������� ����ǥ�� �� ����
			pstmt.setString(1, otVO.getDv_name());
			pstmt.setString(2, otVO.getDv_tel());
			pstmt.setString(3, otVO.getDv_addr());
			pstmt.setString(4, otVO.getDv_memo());
			pstmt.addBatch();
			//���� ����
			pstmt.executeBatch();
			
			//������ ���� ����
			pstmt=con.prepareStatement(insertOrderDetail);
			//�Ű������� ���޵� �����͸� �������� ����ǥ�� �� ����
			pstmt.setString(1, otVO.getPro_cd());
			pstmt.setInt(2, otVO.getOrdd_qty());
			
			pstmt.addBatch();
			//���� ����
			pstmt.executeBatch();
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			}catch(Exception e) {
				e.printStackTrace();
				
			}
		}
	}//insertOrder
	
	/*
	 * public void insertOrders2(OrderVO oVO) throws DataAccessException { // 1. ������
	 * �����̳� ���� GetJdbcTemplate gjt = GetJdbcTemplate.getInstance(); // 2.
	 * JdbcTemplate ��� JdbcTemplate jt = gjt.getJdbcTemplate(); // 3. ������ ����
	 * 
	 * String insertOrders =
	 * "insert into orders(ord_cd, user_id, ord_price) values(concat(to_char(sysdate, '\\\"P\\\"YYMMDD\\\"\\\"'),lpad(ord_cd_seq.nextval,5,'0')),?,?)"
	 * ; jt.update(insertOrders,oVO.getUser_id(), oVO.getOrd_price());
	 * 
	 * String insertDelivery =
	 * "insert into delivery(ord_cd, dv_name, dv_tel, dv_addr, dv_memo) values(concat(to_char(sysdate, '\\\"P\\\"YYMMDD\\\"\\\"'),lpad(ord_cd_seq.curval,5,'0')),?,?,?,?)"
	 * ; jt.update(insertDelivery,oVO.getDv_name(), oVO.getDv_tel(),
	 * oVO.getDv_addr(), oVO.getDv_memo());
	 * 
	 * String insertOrderDetail =
	 * "insert into order_detail(ord_cd, pro_cd, ordd_qty) values(concat(to_char(sysdate, '\\\"P\\\"YYMMDD\\\"\\\"'),lpad(ord_cd_seq.curval,5,'0')),?,?)"
	 * ; //jt.update(insertOrderDetail,pro_cd,ordd_qty); // 4. �����������̳� �ݱ�
	 * gjt.closeAc(); }// insertDelivery
	 */}//class
