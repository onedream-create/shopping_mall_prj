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
import kr.co.shopping_mall.model.OrderDetailVO;
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
	///////////// inner class ////////////
	public class SelectPrdInfo implements RowMapper<ProductVO>{
		public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException{
			ProductVO pv=new ProductVO();
			pv.setPro_name(rs.getString("pro_name"));
			pv.setPro_price(rs.getInt("pro_price"));
			pv.setPro_img(rs.getString("pro_img"));
			return pv;
		}//mapRow
	}//SelectPro	
	///////////// inner class ////////////
	public class SelectOrdDetailInfo implements RowMapper<OrderDetailVO>{
		public OrderDetailVO mapRow(ResultSet rs, int rowNum) throws SQLException{
			OrderDetailVO odv=new OrderDetailVO();
			odv.setOrdd_cd(rs.getString("ordd_cd"));
			odv.setPro_cd(rs.getString("pro_cd"));
			odv.setOrdd_qty(rs.getInt("ordd_qty"));			
			return odv;
		}//mapRow
	}//SelectOrdDetailInfo	
	
	//???????? ????
	public List<OrderInfoVO> selectOrder(String user_id)throws SQLException{
		List<OrderInfoVO> list=null;
		
		//1. Spring Container ????
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ????
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ?????? ????
		StringBuilder selectOrder=new StringBuilder();
		selectOrder.append("	select pr.pro_name, od.ord_cd, od.ord_date, od.ord_price, ost.ord_stat_name, odt.ordd_cd, odt.ordd_qty		")
		.append("	from orders od, order_stat ost, order_detail odt, product pr	")
		.append("	where ost.ord_stat_cd=od.ord_stat_cd and odt.ord_cd=od.ord_cd and pr.pro_cd=odt.pro_cd and od.user_id=?	")
		.append("	order by od.ord_date desc 	");
		
		list=jt.query(selectOrder.toString(), new Object[] {user_id}, new SelectOrderInfo());
		
		//4. Spring Container ????
		gjt.closeAc();
		
		return list;
	}//selectOrder
	
	//???? ?????????? ???????? ????
	public List<ProductVO> selectPrd(String ord_cd)throws SQLException{
		List<ProductVO> list=null;
		
		//1. Spring Container ????
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate ????
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. ?????? ????
		StringBuilder selectPrd=new StringBuilder();
		selectPrd.append("	select pr.pro_name,  pr.pro_img, pr.pro_price	")
		.append("	from orders od, order_stat ost, order_detail odt, product pr	")
		.append("	where ost.ord_stat_cd=od.ord_stat_cd and odt.ord_cd=od.ord_cd and pr.pro_cd=odt.pro_cd and od.ord_cd=?	");
		
		list=jt.query(selectPrd.toString(), new Object[] {ord_cd}, new SelectPrdInfo());
		
		//4. Spring Container ????
		gjt.closeAc();
		
		return list;
	}//selectOrder
	
	public int updateOrderInfo(String ord_cd) throws DataAccessException{
		int cnt=0;
		//Spring Container ????
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//JdbcTemplate ????
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//???? ????
		String updateOrder="update orders set ord_stat_cd='4' where ord_cd=?";
		
		//update orders set ord_stat_cd='4' where ord_cd=?;
		cnt=jt.update(updateOrder,ord_cd);
		//?????????????? ????
		gjt.closeAc();
		
		return cnt;
	}//updateEmp	
	
	/**
	 * orders, delivery, order_detail ???????? ???? ????
	 * @param dVO 
	 * @throws DataAccessException
	 */
	@SuppressWarnings("resource")
	public void insertOrder(DeliveryVO dVO,ArrayList<ProductVO> cartList,String user_id) throws Exception {
		//Spring Container ????
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
	
		Connection con = null;
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		DataSource dataSource = gjt.getDataSource();
		
		ArrayList<ProductVO> cart = cartList;
		
		try {
			//DataSource???? Connection?? ???? 
			con=dataSource.getConnection();
			
			con.setAutoCommit(false);
			
			//1. ???????? ???? ????
			String seq="select concat('O_',lpad(ord_cd_seq.nextval,10,0)) from dual";
			pstmt=con.prepareStatement(seq);
			rs=pstmt.executeQuery();
			String prdCode="";
			if(rs.next()) {
			prdCode= rs.getString(1);
			}
			
			//2. ???????????? ????
			String insertOrders =
					"insert into orders(ord_cd, user_id, ord_price) values(?,?,?)"; 
			int total=0;
			int totalSum=0;
			for(int i = 0; i < cart.size(); i++) {
				ProductVO pv = cart.get(i);
					total = pv.getPro_price() * pv.getCnt();
					totalSum += total;
			}
			//?????? ???? ????
			pstmt=con.prepareStatement(insertOrders);
			//?????????? ?????? ???????? ???????? ???????? ?? ????
			pstmt.setString(1, prdCode); 
			pstmt.setString(2, user_id);
			pstmt.setInt(3, totalSum);
			//???? ????
			int cnt=pstmt.executeUpdate();
			
			//3. ???????????? ???? 
			String insertDelivery = "insert into delivery(ord_cd, dv_name, dv_tel, dv_addr, dv_memo) values(?,?,?,?,?)";
			pstmt=con.prepareStatement(insertDelivery);
			//?????????? ?????? ???????? ???????? ???????? ?? ????
			pstmt.setString(1, prdCode);
			pstmt.setString(2, dVO.getDv_name());
			pstmt.setString(3, dVO.getDv_tel());
			pstmt.setString(4, dVO.getDv_addr());
			pstmt.setString(5, dVO.getDv_memo());
			//???? ????
			int cnt2=pstmt.executeUpdate();
			
			//4.?????? ???? ????
			String insertOrderDetail = "insert into order_detail(ordd_cd,ord_cd, pro_cd, ordd_qty) values(concat('OD_',lpad(ordd_cd_seq.nextval,9,0)),?,?,?)";
			//ArrayList<ProductVO> cart=cartList;
			
			pstmt=con.prepareStatement(insertOrderDetail);
			//cartList?? ???????? ?????? insert ????
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
			//?????? ?????? list?? size?? ????
			if(check!=cart.size()) {
				System.out.println("????????1");
				con.rollback();
				throw new Exception();
			}
			//1,2,3?????? ???? ?????? ???????? commit ?? ?????????? rollback?? ????
			if(!(cnt==cnt2&&cnt2==check/cart.size())) {
				System.out.println("????????2");
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
	 * ?????? ???????? ???? ???? ???? ???? 
	 * @param user_id
	 * @return ord_cd
	 * @throws SQLException
	 */
	public String selectOrdCd(String user_id) throws SQLException {
		String ord_cd = "";

		// 1. Spring Container ????
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate ????
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. ????????
		String selectOrdCd = "select ord_cd	from orders	"+
		"where user_id=? and ord_date=(select max(ord_date) from orders)";
		try {
			// ???????? ?????????? ?????? ????
			ord_cd = jt.queryForObject(selectOrdCd, new Object[] { user_id }, String.class);
		} catch (EmptyResultDataAccessException erdae) {
			// ?????????? ???? ?????? ????????
			ord_cd = "";
		} // end catch
			// 4. Spring Container ????
		gjt.closeAc();
		return ord_cd;
	}// selectId
	
	
	/**
	 * ???????????? ?????? ????
	 * @param ord_cd
	 * @return returnOrdd_cd
	 * @throws SQLException
	 */
	public List<OrderDetailVO> selectOrdDetail(String ord_cd) throws SQLException {
		List<OrderDetailVO> list=null;

		// 1. Spring Container ????
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate ????
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. ????????
		String selectOrdDetail = "select ordd_cd, pro_cd, ordd_qty from order_detail where ord_cd=?";
		try {
			// ???????? ?????????? ?????? ????
			list = jt.query(selectOrdDetail.toString(), new Object[] { ord_cd }, new SelectOrdDetailInfo());
					
		} catch (EmptyResultDataAccessException erdae) {
			// ?????????? ???? ?????? ????????
			list = null;
		} // end catch
			// 4. Spring Container ????
		gjt.closeAc();
		return list;
	}// selectId
	
	/**
	 * ???????? ?????? ????
	 * @param ord_cd
	 * @return returnOrdd_cd
	 * @throws SQLException
	 */
	public DeliveryVO selectDelivery(String ord_cd) throws SQLException {
		DeliveryVO dVO=null;
		
		// 1. Spring Container ????
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate ????
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. ????????
		String selectDelivery = "select dv_name, dv_tel, dv_addr, dv_memo from delivery where ord_cd=?";
		try {
			// ???????? ?????????? ?????? ????
			dVO = jt.queryForObject(selectDelivery, new Object[] { ord_cd }, 
					new RowMapper<DeliveryVO>() {
				public DeliveryVO mapRow(ResultSet rs, int rowNum)throws SQLException{
					DeliveryVO dVO=new DeliveryVO();
					dVO.setDv_name(rs.getString("dv_name"));
					dVO.setDv_tel(rs.getString("dv_tel"));
					dVO.setDv_addr(rs.getString("dv_addr"));
					dVO.setDv_memo(rs.getString("dv_memo"));
					return dVO;
				}
			});
		} catch (EmptyResultDataAccessException erdae) {
			// ?????????? ???? ?????? ????????
			dVO = null;
		} // end catch
		// 4. Spring Container ????
		gjt.closeAc();
		return dVO;
	}// selectId
}//class
