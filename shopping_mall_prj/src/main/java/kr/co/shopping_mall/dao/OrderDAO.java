package kr.co.shopping_mall.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.dao.DataAccessException;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.shopping_mall.model.DeliveryVO;
import kr.co.shopping_mall.model.OrderInfoVO;
import kr.co.shopping_mall.model.ProductVO;


public class OrderDAO {
	///////////// inner class ////////////
	public class SelectOrderInfo implements RowMapper<OrderInfoVO>{
		public OrderInfoVO mapRow(ResultSet rs, int rowNum) throws SQLException{
			OrderInfoVO oiv=new OrderInfoVO();
			oiv.setPro_name(rs.getString("pro_name"));
			oiv.setOrd_cd(rs.getString("ord_cd"));
			oiv.setOrd_date(rs.getString("ord_date"));
			oiv.setOrd_stat_name(rs.getString("ord_stat_name"));
			oiv.setOrdd_cd(rs.getString("ordd_cd"));
			oiv.setOrd_price(rs.getInt("ord_price"));
			oiv.setOrdd_qty(rs.getInt("ordd_qty"));
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
		selectOrder.append("	select pr.pro_name, od.ord_cd, od.ord_date, od.ord_price, ost.ord_stat_name, odt.ordd_cd, odt.ordd_qty		")
		.append("	from orders od, order_stat ost, order_detail odt, product pr	")
		.append("	where ost.ord_stat_cd=od.ord_stat_cd and odt.ord_cd=od.ord_cd and pr.pro_cd=odt.pro_cd and od.user_id=?	")
		.append("	order by od.ord_date desc 	");
		
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
	 * orders, delivery, order_detail 테이블에 정보 추가
	 * @param dVO 
	 * @throws DataAccessException
	 */
	@SuppressWarnings("resource")
	public void insertOrder(DeliveryVO dVO,ArrayList<ProductVO> cartList,String user_id) throws Exception {
		//Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
	
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		DataSource dataSource = gjt.getDataSource();
		
		ArrayList<ProductVO> cart = cartList;
		
		try {
			//DataSource에서 Connection을 얻기 
			con=dataSource.getConnection();
			
			con.setAutoCommit(false);
			
			//1. 공통사용 코드 얻기
			String seq="select concat('O_',lpad(ord_cd_seq.nextval,10,0)) from dual";
			pstmt=con.prepareStatement(seq);
			rs=pstmt.executeQuery();
			String prdCode="";
			if(rs.next()) {
			prdCode= rs.getString(1);
			}
			
			//2. 주문테이블에 추가
			String insertOrders =
					"insert into orders(ord_cd, user_id, ord_price) values(?,?,?)"; 
			int total=0;
			int totalSum=0;
			for(int i = 0; i < cart.size(); i++) {
				ProductVO pv = cart.get(i);
					total = pv.getPro_price() * pv.getCnt();
					totalSum += total;
			}
			//수행할 쿼리 정의
			pstmt=con.prepareStatement(insertOrders);
			//매개변수로 전달된 데이터를 쿼리문의 물음표에 값 매핑
			pstmt.setString(1, prdCode); 
			pstmt.setString(2, user_id);
			pstmt.setInt(3, totalSum);
			//쿼리 수행
			int cnt=pstmt.executeUpdate();
			
			//3. 배송테이블에 추가 
			String insertDelivery = "insert into delivery(ord_cd, dv_name, dv_tel, dv_addr, dv_memo) values(?,?,?,?,?)";
			pstmt=con.prepareStatement(insertDelivery);
			//매개변수로 전달된 데이터를 쿼리문의 물음표에 값 매핑
			pstmt.setString(1, prdCode);
			pstmt.setString(2, dVO.getDv_name());
			pstmt.setString(3, dVO.getDv_tel());
			pstmt.setString(4, dVO.getDv_addr());
			pstmt.setString(5, dVO.getDv_memo());
			//쿼리 수행
			int cnt2=pstmt.executeUpdate();
			
			//4.수행할 쿼리 정의
			String insertOrderDetail = "insert into order_detail(ordd_cd,ord_cd, pro_cd, ordd_qty) values(concat('OD_',lpad(ordd_cd_seq.nextval,9,0)),?,?,?)";
			//ArrayList<ProductVO> cart=cartList;
			
			pstmt=con.prepareStatement(insertOrderDetail);
			//cartList에 들어있는 내용을 insert 수행
			int check=0;
			for(int i=0 ; i < cart.size() ;i++) {
				ProductVO pv = cart.get(i);
				pstmt.setString(1, prdCode);
				pstmt.setString(2, pv.getPro_cd());
				pstmt.setInt(3, pv.getCnt());
				//check4+=1;
				check+=pstmt.executeUpdate();
			}
			//int cnt3=pstmt.executeUpdate();
			//수행된 행수를 list의 size와 비교
			if(check!=cart.size()) {
				System.out.println("문제발생1");
				con.rollback();
				throw new Exception();
			}
			//1,2,3쿼리의 수행 횟수를 비교하여 commit 을 수행하거나 rollback을 수행
			if(!(cnt==cnt2&&cnt2==check/cart.size())) {
				System.out.println("문제발생2");
				con.rollback();
				throw new Exception();
			}else {
				con.commit();
			}
		} /*
			 * catch(Exception e) { System.out.println("exception"); e.printStackTrace(); }
			 */finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(con!=null) con.close();
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
	}//insertOrder
	
	/**
	 * 입려한 아이디의 최신 주문 번호 조회 
	 * @param user_id
	 * @return ord_cd
	 * @throws SQLException
	 */
	public String selectOrdCd(String user_id) throws SQLException {
		String ord_cd = "";

		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. 쿼리실행
		String selectOrdCd = "select ord_cd	from orders	"+
		"where user_id=? and ord_date=(select max(ord_date) from orders)";
		try {
			// 조회되면 조회결과가 변수에 저장
			ord_cd = jt.queryForObject(selectOrdCd, new Object[] { user_id }, String.class);
		} catch (EmptyResultDataAccessException erdae) {
			// 조회결과가 없을 때에는 예외발생
			ord_cd = "";
		} // end catch
			// 4. Spring Container 닫기
		gjt.closeAc();
		return ord_cd;
	}// selectId
	
}//class
