package kr.co.shopping_mall.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.shopping_mall.model.OrderInfoVO;
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
	
	//주문정보 조회
	public List<OrderInfoVO> selectOrder(String user_id)throws SQLException{
		List<OrderInfoVO> list=null;
		
		//1. Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. 쿼리문 실행
		StringBuilder selectOrder=new StringBuilder();
		selectOrder.append("	select pr.pro_name, od.ord_cd, od.ord_date, od.ord_price, ost.ord_stat_name	")
		.append("	from orders od, order_stat ost, order_detail odt, product pr	")
		.append("	where ost.ord_stat_cd=od.ord_stat_cd and odt.ord_cd=od.ord_cd and pr.pro_cd=odt.pro_cd and od.user_id=?	");
		
		list=jt.query(selectOrder.toString(), new Object[] {user_id}, new SelectOrderInfo());
		
		//4. Spring Container 닫기
		gjt.closeAc();
		
		return list;
	}//selectOrder
	
	public int updateOrderInfo(String ord_cd) throws DataAccessException{
		int cnt=0;
		//Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//쿼리 실행
		String updateOrder="update orders set ord_stat_cd='4' where ord_cd=?";
		
		//update orders set ord_stat_cd='4' where ord_cd=?;
		cnt=jt.update(updateOrder,ord_cd);
		//스프링컨테이너 닫기
		gjt.closeAc();
		
		return cnt;
	}//updateEmp	
	
	/**
	 * orders, delivery, order_detail 정보 추가
	 * 
	 * @param oVO 웹 파라메터 값을 가진 VO
	 * @throws DataAccessException
	 */
	public void insertOrders(OrderVO oVO) throws DataAccessException {
		// 1. 스프링 컨테이너 생성
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. 쿼리문 수행
		
	    String insertOrders =
	    "insert into orders(ord_cd, user_id, ord_price) values(concat(to_char(sysdate, '\\\"P\\\"YYMMDD\\\"\\\"'),lpad(ord_cd_seq.nextval,5,'0')),?,?)"; 
	    jt.update(insertOrders,oVO.getUser_id(), oVO.getOrd_price());
		
		String insertDelivery = "insert into delivery(ord_cd, dv_name, dv_tel, dv_addr, dv_memo) values(concat(to_char(sysdate, '\\\"P\\\"YYMMDD\\\"\\\"'),lpad(ord_cd_seq.curval,5,'0')),?,?,?,?)";
		jt.update(insertDelivery,oVO.getDv_name(), oVO.getDv_tel(), oVO.getDv_addr(), oVO.getDv_memo());
		
		String insertOrderDetail = "insert into order_detail(ord_cd, pro_cd, ordd_qty) values(concat(to_char(sysdate, '\\\"P\\\"YYMMDD\\\"\\\"'),lpad(ord_cd_seq.curval,5,'0')),?,?)";
		//jt.update(insertOrderDetail,pro_cd,ordd_qty);
		// 4. 스프링컨테이너 닫기
		gjt.closeAc();
	}// insertDelivery
}//class
