package kr.co.shopping_mall.dao;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import kr.co.shopping_mall.model.OrderDetailVO;
import kr.co.shopping_mall.model.OrderVO;
import kr.co.shopping_mall.model.ProductVO;
import kr.co.shopping_mall.model.UserVO;

public class AdminDAO {
	//HOME===================================================================================================
	public String checkAccount(String inputId, String inputPw) throws DataAccessException {
		String admin_id = "";
		// 1. Spring COntainer 생성
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2.JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. 쿼리문수행
		String selectId = "select admin_id from admin where admin_id=? and admin_pw=?";
		admin_id = jt.queryForObject(selectId, new Object[] { inputId, inputPw }, String.class);
		// 4. Spring COntainer 닫기
		gjt.closeAc();
		return admin_id;
	}

	public int changePass(String admin_id, String newPass) throws DataAccessException {
		int cnt = 0;

		// 스프링컨테이너 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 쿼리 실행
		String updatePw = "update admin set admin_pw=? where admin_id=?";
		cnt = jt.update(updatePw, newPass, admin_id);
		// 스프링컨테이너 닫기
		gjt.closeAc();

		return cnt;
	}
	
	//Product===================================================================================================
	//상품추가
	public void addPro(ProductVO pVO) throws DataAccessException {
		// 스프링컨테이너 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 쿼리 실행
		StringBuilder insertProduct = new StringBuilder();
		insertProduct.append(" insert into product(pro_cd, category_cd, pro_name, pro_detail, pro_img, pro_price) ")
					 .append(" values(concat('P_',lpad(pro_cd_seq.nextval,10,'0')),?,?,?,?,?)" );
		jt.update(insertProduct.toString(), pVO.getCategory_cd(), pVO.getPro_name(), pVO.getPro_detail(), pVO.getPro_img(),
				pVO.getPro_price());
		// 스프링컨테이너 닫기
		gjt.closeAc();
	}
	
	//상품 RowMapper
	public class SelectPro implements RowMapper<ProductVO> {
		public ProductVO mapRow(ResultSet rs, int rowNum) throws SQLException {
			ProductVO pv = new ProductVO();
			pv.setNo(rs.getString("rnum"));
			pv.setPro_cd(rs.getString("pro_cd"));
			pv.setCategory_cd(rs.getInt("category_cd"));
			pv.setPro_name(rs.getString("pro_name"));
			pv.setPro_detail(rs.getString("pro_detail"));
			pv.setPro_img(rs.getString("pro_img"));
			pv.setPro_price(rs.getInt("pro_price"));
			pv.setSell_fl(rs.getString("sell_fl"));
			pv.setInput_date(rs.getString("input_date"));
			return pv;
		}
	}
	
	//상품 리스트 얻기
	public List<ProductVO> searchPro(String division, String searchValue, int category_cd, int start, int rowsPerPage) throws SQLException {
		List<ProductVO> list = null;
		// 1. Spring Container 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// 2. JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 3. 쿼리문 실행
		StringBuilder selectPro = new StringBuilder();
		selectPro.append(" select * ") 
				 .append(" from (select rownum as rnum, p.* ")
		         		.append(" from ( select * ")
		         				.append(" from product ");
					if(division.equals("1")) {
						selectPro.append("where pro_name");		 
					} else {
						selectPro.append("where pro_cd");
					}
						selectPro.append(" like '%' || ? || '%' ");
					if(category_cd != 0) {
						selectPro.append(" and category_cd=? ");
					}
						selectPro.append(" order by input_date desc) p) ")
							 	 .append(" where rnum > ? and rnum <= ?+? ")	
							 	 .append(" order by rnum ");
		if (category_cd == 0) {
			// 코드가 0이면 전체분류의 상품을 조회
			list = jt.query(selectPro.toString(),new Object[] {String.valueOf(searchValue), Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, new SelectPro());
		} else {
			// 카테고리별 상품정보를 조회
			list = jt.query(selectPro.toString(), new Object[] {String.valueOf(searchValue), String.valueOf(category_cd),Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) },new SelectPro());
		} // end else

		// 4. Spring Container 닫기
		gjt.closeAc();

		return list;
	}
	
	//페이징을 위한 전체 데이터 레코드 수를 얻는 메소드
	public String countSearchPro(String division, String searchValue, int category_cd) throws SQLException{
		String cnt = null;
		
		//1. Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. 쿼리문 실행
		StringBuilder countPro = new StringBuilder();
		countPro.append(" select count(pro_cd) from product ");
			if(division.equals("1")) {
				countPro.append(" where pro_name ");
			} else {
				countPro.append(" where pro_cd ");	
			}
					
			countPro.append(" like '%' || ? || '%' ");
						
			if(category_cd != 0) {
				countPro.append(" and category_cd=? ");
						
				cnt=jt.queryForObject(countPro.toString(), new Object[] {String.valueOf(searchValue),String.valueOf(category_cd)},String.class);
			} else {	
				cnt=jt.queryForObject(countPro.toString(), new Object[] {String.valueOf(searchValue)},String.class);
			}
		//4. Spring Container 닫기
		gjt.closeAc();
		
		return cnt;
	}	
	
	//pro_cd에 해당하는 상품상세정보조회
	public ProductVO getProInfo(String pro_cd) throws SQLException{
		ProductVO pv=null;
		
		//1. Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. 쿼리문 실행
		String selectProInfo=" select rownum as rnum, p.* from product p where pro_cd=? ";
		pv=jt.queryForObject(selectProInfo, new Object[] { String.valueOf(pro_cd) }, new SelectPro());
				
		//4. Spring Container 닫기
		gjt.closeAc();

		return pv;
	}
	
	//상품삭제
	public void deletePro(String pro_cd) throws SQLException {
		// 스프링컨테이너 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 쿼리 실행
		String deletePro = " delete from product where pro_cd=? ";
		jt.update(deletePro, pro_cd);
		// 스프링컨테이너 닫기
		gjt.closeAc();
	}
	
	//상품수정
	public void updatePro(String pro_cd , String pro_name, String pro_price ,String sell_fl) throws SQLException {
		// 스프링컨테이너 얻기
		GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
		// JdbcTemplate 얻기
		JdbcTemplate jt = gjt.getJdbcTemplate();
		// 쿼리 실행
		String updatePro = " update product set pro_name=?, pro_price=?, sell_fl=?, input_date=sysdate where pro_cd=?";
		jt.update(updatePro, pro_name, pro_price, sell_fl, pro_cd);
		// 스프링컨테이너 닫기
		gjt.closeAc();
	}
	
	//상품대시보드 상품개수 카운트
	public String countProDashData(String flag) throws SQLException {
		String cnt = null;
		
		//1. Spring Container 얻기
		GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
		//2. JdbcTemplate 얻기
		JdbcTemplate jt=gjt.getJdbcTemplate();
		//3. 쿼리문 실행
		StringBuilder countPro = new StringBuilder();
		countPro.append(" select count(pro_cd) from product ");
			
		if(flag == "y" || flag == "n") {countPro.append(" where sell_fl=? ");}
						
		if(flag == "a") {
			cnt=jt.queryForObject(countPro.toString(),String.class);
		} else {	
			cnt=jt.queryForObject(countPro.toString(), new Object[] {String.valueOf(flag)},String.class);
		}
		//4. Spring Container 닫기
		gjt.closeAc();
		
		return cnt;
	}
	
	//상품대시보드 리스트 얻기
		public List<ProductVO> proDashSearch(String flag, int start, int rowsPerPage) throws SQLException {
			List<ProductVO> list = null;
			// 1. Spring Container 얻기
			GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
			// 2. JdbcTemplate 얻기
			JdbcTemplate jt = gjt.getJdbcTemplate();
			// 3. 쿼리문 실행
			StringBuilder selectPro = new StringBuilder();
			
			selectPro.append(" select * ");
			selectPro.append(" from	(select rownum as rnum, p.* ");
			selectPro.append("   	 from (select * from product ");
			if(!flag.equals("a")) {
				selectPro.append(" where sell_fl=? ");
			}
			selectPro.append(" order by input_date desc) p) ");  
			selectPro.append(" where  rnum > ? and rnum <= ?+? ");  
			selectPro.append(" order by rnum ");  
			
			if(!flag.equals("a")) {
				list = jt.query(selectPro.toString(),new Object[] {String.valueOf(flag), Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, new SelectPro());
			} else {
				list = jt.query(selectPro.toString(),new Object[] {Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, new SelectPro());				
			}
			// 4. Spring Container 닫기
			gjt.closeAc();

			return list;
		}
		
		//User===================================================================================================
		//유저대시보드 오늘기준 가입 탈퇴, 총회원 수 카운트
		public String countUserDashData(String flag) throws SQLException {
			String cnt = null;
			
			//1. Spring Container 얻기
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate 얻기
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. 쿼리문 실행
			StringBuilder countUser = new StringBuilder();
			countUser.append(" select count(user_id) from users ");
				
			if(flag == "n" || flag == "y") {
				countUser.append(" where del_fl=? ");
				countUser.append(" and to_char(reg_date,'YYYYMMDD') = to_char(sysdate,'YYYYMMDD') ");
			}

			if(flag == "a") {
				countUser.append(" where del_fl='n' ");
				cnt=jt.queryForObject(countUser.toString(),String.class);
			} else {	
				cnt=jt.queryForObject(countUser.toString(), new Object[] {String.valueOf(flag)},String.class);
			}
			//4. Spring Container 닫기
			gjt.closeAc();
			
			return cnt;
		}
		
		//유저 RowMapper
		public class SelectUser implements RowMapper<UserVO> {
			public UserVO mapRow(ResultSet rs, int rowNum) throws SQLException {
				UserVO uv = new UserVO();
				uv.setNo(rs.getString("rnum"));
				uv.setUser_id(rs.getString("user_id"));
				uv.setUser_pw(rs.getString("user_pw"));
				uv.setUser_name(rs.getString("user_name"));
				uv.setUser_tel(rs.getString("user_tel"));
				uv.setUser_email(rs.getString("user_email"));
				uv.setUser_addr(rs.getString("user_addr"));
				uv.setGrade_no(rs.getString("grade_no"));
				uv.setGrade_name(rs.getString("grade_name"));
				uv.setReg_date(rs.getString("reg_date"));
				uv.setDel_fl(rs.getString("del_fl"));
				uv.setSec_date(rs.getString("sec_date"));
				return uv;
			}
		}
		
		//유저 대시보드 리스트얻기
		public List<UserVO> userDashSearch(String flag, int start, int rowsPerPage){
			List<UserVO> list = null;
			// 1. Spring Container 얻기
			GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
			// 2. JdbcTemplate 얻기
			JdbcTemplate jt = gjt.getJdbcTemplate();
			// 3. 쿼리문 실행
			StringBuilder selectUser = new StringBuilder();
			
			selectUser.append(" select * ");
			selectUser.append(" from	(select rownum as rnum, u.*, g.grade_name ");
			selectUser.append("   	 from (select * from users ");
			if(!flag.equals("a")) {
				selectUser.append(" 			where del_fl=? ");
				selectUser.append(" 			and to_char(reg_date,'YYYYMMDD') = to_char(sysdate,'YYYYMMDD') ");
			} else { selectUser.append(" 				where del_fl='n' "); }
				
			selectUser.append(" 				order by reg_date desc) u, user_grade g ");
			selectUser.append(" 		 where u.grade_no = g.grade_no) ");
			selectUser.append(" where  rnum > ? and rnum <= ?+? ");  
			selectUser.append(" order by rnum ");  
			
			if(!flag.equals("a")) {
				list = jt.query(selectUser.toString(),new Object[] {String.valueOf(flag), Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, new SelectUser());
			} else {
				list = jt.query(selectUser.toString(),new Object[] {Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, new SelectUser());				
			}
			// 4. Spring Container 닫기
			gjt.closeAc();

			return list;
		}
		
		//user_id에 해당하는 상세정보조회
		public UserVO getUserInfo(String user_id) throws SQLException{
			UserVO uv=null;
			
			//1. Spring Container 얻기
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate 얻기
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. 쿼리문 실행
			String selectUserInfo=" select rownum as rnum, u.*, g.grade_name from users u, user_grade g where u.grade_no = g.grade_no and user_id=? ";
			uv=jt.queryForObject(selectUserInfo, new Object[] { String.valueOf(user_id) }, new SelectUser());
					
			//4. Spring Container 닫기
			gjt.closeAc();

			return uv;
		}
		
		//회원정보 수정
		public void updateUser(String user_name, String grade_no, String user_tel, String user_addr, String user_email, String user_id) throws SQLException {
			// 스프링컨테이너 얻기
			GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
			// JdbcTemplate 얻기
			JdbcTemplate jt = gjt.getJdbcTemplate();
			// 쿼리 실행
			String updateUser = " update users set user_name=?, grade_no=?, user_tel=?, user_addr=?, user_email=? where user_id=?";
			jt.update(updateUser, user_name, grade_no, user_tel, user_addr, user_email, user_id);
			// 스프링컨테이너 닫기
			gjt.closeAc();
		}
		
		//회원탈퇴
		public void secessionUser(String user_id) throws SQLException {
			// 스프링컨테이너 얻기
			GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
			// JdbcTemplate 얻기
			JdbcTemplate jt = gjt.getJdbcTemplate();
			// 쿼리 실행
			String secessionUser = " update users set user_pw=null, user_name=null, user_tel=null, user_email=null, del_fl='y', sec_date=sysdate where user_id=?";
			jt.update(secessionUser, user_id);
			// 스프링컨테이너 닫기
			gjt.closeAc();
		}
		
		//회원검색 조건에 맞는 레코드 수 얻기
		public String countSearchUser(String division, String searchValue, String user_category) throws SQLException {
			String cnt = null;
			
			//1. Spring Container 얻기
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate 얻기
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. 쿼리문 실행
			StringBuilder countPro = new StringBuilder();
			countPro.append(" select count(user_id) from users ");
				if(division.equals("1")) {
					countPro.append(" where user_id ");
				} else {
					countPro.append(" where user_name ");	
				}
						
				countPro.append(" like '%' || ? || '%' ");
							
				if(!user_category.equals("a")) {
					countPro.append(" and del_fl=? ");
							
					cnt=jt.queryForObject(countPro.toString(), new Object[] {String.valueOf(searchValue),String.valueOf(user_category)},String.class);
				} else {	
					cnt=jt.queryForObject(countPro.toString(), new Object[] {String.valueOf(searchValue)},String.class);
				}
			//4. Spring Container 닫기
			gjt.closeAc();
			
			return cnt;
		}
		
		//회원검색 조건에 맞는 리스트 얻기
		public List<UserVO> searchUser(String division, String searchValue, String user_category, int start, int rowsPerPage) throws SQLException {
			List<UserVO> list = null;
			// 1. Spring Container 얻기
			GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
			// 2. JdbcTemplate 얻기
			JdbcTemplate jt = gjt.getJdbcTemplate();
			// 3. 쿼리문 실행
			StringBuilder selectUser = new StringBuilder();
			selectUser.append(" select * ") 
					 .append(" from (select rownum as rnum, u.*, g.grade_name ")
			         		.append(" from ( select * ")
			         				.append(" from users ");
						if(division.equals("1")) {
							selectUser.append("where user_id");		 
						} else {
							selectUser.append("where user_name");
						}
							selectUser.append(" like '%' || ? || '%' ");
						if(!user_category.equals("a")) {
							selectUser.append(" and del_fl=? ");
						}
							selectUser.append(" order by reg_date desc) u, user_grade g ")
									 .append(" where u.grade_no = g.grade_no) ")
								 	 .append(" where rnum > ? and rnum <= ?+? ")	
								 	 .append(" order by rnum ");
			if (user_category.equals("a")) {
				// 코드가 0이면 전체분류의 상품을 조회
				list = jt.query(selectUser.toString(),new Object[] {String.valueOf(searchValue), Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, new SelectUser());
			} else {
				// 카테고리별 상품정보를 조회
				list = jt.query(selectUser.toString(), new Object[] {String.valueOf(searchValue), String.valueOf(user_category),Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) },new SelectUser());
			} // end else

			// 4. Spring Container 닫기
			gjt.closeAc();

			return list;
		}
		
		//order===================================================================================================
		//주문 RowMapper
//		new RowMapper<OrderVO>() {
//			public OrderVO mapRow(ResultSet rs, int rowNum) throws SQLException {
//				OrderVO ov = new OrderVO();
//				ov.setNo(rs.getString("rnum"));
//				ov.setOrd_cd(rs.getString("ord_cd"));
//				ov.setOrd_stat_cd(rs.getInt("ord_stat_cd"));
//				ov.setOrd_stat_name(rs.getString("ord_stat_name"));
//				ov.setUser_id(rs.getString("user_id"));
//				ov.setOrd_price(rs.getInt("ord_price"));
//				ov.setOrd_date(rs.getString("ord_date"));
//				ov.setDv_name(rs.getString("dv_name"));
//				ov.setDv_tel(rs.getString("dv_tel"));
//				ov.setDv_addr(rs.getString("dv_addr"));
//				ov.setDv_memo(rs.getString("dv_memo"));
//				return ov;
//			}
//		}
		
		//주문 대시보드 주문완료 배송중 개수 카운트
		public String countOrderDashData(String flag) throws SQLException {
			String cnt = null;
			
			//1. Spring Container 얻기
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate 얻기
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. 쿼리문 실행
			StringBuilder countOrder = new StringBuilder();
			countOrder.append(" select count(ord_cd) from orders where ord_stat_cd=? ");
		
			cnt=jt.queryForObject(countOrder.toString(), new Object[] {String.valueOf(flag)},String.class);
		
			//4. Spring Container 닫기
			gjt.closeAc();
			
			return cnt;
		}
		
		//주문대시보드 리스트 얻기
		public List<OrderVO> orderDashSearch(String flag, int start, int rowsPerPage) throws SQLException {
			List<OrderVO> list = null;
			// 1. Spring Container 얻기
			GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
			// 2. JdbcTemplate 얻기
			JdbcTemplate jt = gjt.getJdbcTemplate();
			// 3. 쿼리문 실행
			StringBuilder selectOrder = new StringBuilder();
			
			selectOrder.append(" select * ");
			selectOrder.append(" from	(select rownum as rnum, o.*, s.ord_stat_name ");
			selectOrder.append("   	 	 from (select * from orders ");
			selectOrder.append(" 				where ord_stat_cd=? ");
			selectOrder.append(" 				order by ord_date desc) o, order_stat s ");  
			selectOrder.append(" 		 where o.ord_stat_cd = s.ord_stat_cd) ");  
			selectOrder.append(" where  rnum > ? and rnum <= ?+? ");  
			selectOrder.append(" order by rnum ");  
			
			list = jt.query(selectOrder.toString(),new Object[] {String.valueOf(flag), Long.valueOf(start), Long.valueOf(rowsPerPage), Long.valueOf(start) }, 
					new RowMapper<OrderVO>() {
						public OrderVO mapRow(ResultSet rs, int rowNum) throws SQLException {
							OrderVO oVO = new OrderVO();
							oVO.setNo(rs.getString("rnum"));
							oVO.setOrd_cd(rs.getString("ord_cd"));
							oVO.setOrd_date(rs.getString("ord_date"));
							oVO.setOrd_stat_name(rs.getString("ord_stat_name"));
							return oVO;
						}
					});
			// 4. Spring Container 닫기
			gjt.closeAc();

			return list;
		}
		
		//주문상세 데이터 얻기
		public OrderVO getOrderInfo(String ord_cd) throws SQLException {
			OrderVO ov = null;
			
			//1. Spring Container 얻기
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate 얻기
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. 쿼리문 실행
			StringBuilder selectOrderInfo = new StringBuilder();
			selectOrderInfo.append(" select o.ord_cd, o.ord_date, o.ord_stat_cd, o.ord_price, d.dv_name, d.dv_tel, d.dv_addr, d.dv_memo ");
			selectOrderInfo.append(" from orders o, delivery d");
			selectOrderInfo.append(" where o.ord_cd = d.ord_cd and o.ord_cd = ? ");
			ov=jt.queryForObject(selectOrderInfo.toString(), new Object[] { String.valueOf(ord_cd) }, 
					new RowMapper<OrderVO>() {
						public OrderVO mapRow(ResultSet rs, int rowNum) throws SQLException {
							OrderVO ov = new OrderVO();
							ov.setOrd_cd(rs.getString("ord_cd"));
							ov.setOrd_date(rs.getString("ord_date"));
							ov.setDv_name(rs.getString("dv_name"));
							ov.setDv_tel(rs.getString("dv_tel"));
							ov.setDv_addr(rs.getString("dv_addr"));
							ov.setDv_memo(rs.getString("dv_memo"));
							ov.setOrd_stat_cd(rs.getInt("ord_stat_cd"));
							ov.setOrd_price(rs.getInt("ord_price"));
							return ov;
						}
					});	
			//4. Spring Container 닫기
			gjt.closeAc();
			
			return ov;
		}
		
		public List<OrderDetailVO> getOrderDetailInfo(String ord_cd) throws SQLException {
			List<OrderDetailVO> list = null;

			//1. Spring Container 얻기
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate 얻기
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. 쿼리문 실행
			StringBuilder selectOrderInfo = new StringBuilder();
			selectOrderInfo.append(" select p.pro_name, d.ordd_qty, p.pro_price ");
			selectOrderInfo.append(" from order_detail d , product p ");
			selectOrderInfo.append(" where d.pro_cd = p.pro_cd and d.ord_cd=? ");
			list = jt.query(selectOrderInfo.toString(), new Object[] { String.valueOf(ord_cd) }, 
					new RowMapper<OrderDetailVO>() {
						public OrderDetailVO mapRow(ResultSet rs, int rowNum) throws SQLException {
							OrderDetailVO odVO = new OrderDetailVO();
							odVO.setPro_name(rs.getString("pro_name"));
							odVO.setOrdd_qty(rs.getInt("ordd_qty"));
							odVO.setPro_price(rs.getInt("pro_price"));
							return odVO;
						}
					});	
			//4. Spring Container 닫기
			gjt.closeAc();
			
			return list;
		}
		
		
		public void updateOrder(String ord_cd, String dv_addr, String ord_stat_cd) throws SQLException {
			// 스프링컨테이너 얻기
			GetJdbcTemplate gjt = GetJdbcTemplate.getInstance();
			// JdbcTemplate 얻기
			JdbcTemplate jt = gjt.getJdbcTemplate();
			// 쿼리 실행
			String updateOrder = " update orders set ord_stat_cd=? where ord_cd=?";
			jt.update(updateOrder, ord_stat_cd, ord_cd);
			
			updateOrder = " update delivery set dv_addr=? where ord_cd=?";
			jt.update(updateOrder, dv_addr, ord_cd);
			// 스프링컨테이너 닫기
			gjt.closeAc();
		}
		
		public String countSearchOrder(String division, String searchValue, int order_stat_cd, String order_date1, String order_date2) throws SQLException {
			String cnt = null;
			
			//1. Spring Container 얻기
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate 얻기
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. 쿼리문 실행
			StringBuilder countOrder = new StringBuilder();
			countOrder.append(" select count(ord_cd) from orders ");
				
			if(division.equals("1")) {
				countOrder.append(" where ord_cd ");
			} else {
				countOrder.append(" where user_id ");	
			}
			countOrder.append(" like '%' || ? || '%' ");
			countOrder.append(" and to_char(ord_date,'YYYYMMDD') between ? and ? ");

			if(order_stat_cd != 0) {
				countOrder.append(" and ord_stat_cd=? ");
				cnt=jt.queryForObject(countOrder.toString(), new Object[] {String.valueOf(searchValue),String.valueOf(order_date1),String.valueOf(order_date2),Long.valueOf(order_stat_cd)},String.class);
			} else {	
				cnt=jt.queryForObject(countOrder.toString(), new Object[] {String.valueOf(searchValue),String.valueOf(order_date1),String.valueOf(order_date2)},String.class);
			}
			//4. Spring Container 닫기
			gjt.closeAc();
			
			return cnt;
		}
		
		public List<OrderVO> searchOrder(String division, String searchValue, int order_stat_cd, String order_date1, String order_date2, int start, int rowsPerPage) throws SQLException {
			List<OrderVO> list = null;
			
			//1. Spring Container 얻기
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate 얻기
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. 쿼리문 실행
			//
			StringBuilder searchOrder = new StringBuilder();
			searchOrder.append(" select * ");
			searchOrder.append(" from(select rownum as rnum, os.* ");
			searchOrder.append(" 		from (select o.ord_cd, o.ord_date, s.ord_stat_name ");
			searchOrder.append(" 				from orders o, order_stat s ");
			searchOrder.append(" 				where o.ord_stat_cd = s.ord_stat_cd and to_char(o.ord_date,'YYYYMMDD') between ? and ?");
			if(order_stat_cd != 0) {
				searchOrder.append(" 				and o.ord_stat_cd = ? ");
			}
			if(division.equals("1")) {
			searchOrder.append(" 				and o.ord_cd ");
			} else {
			searchOrder.append(" 				and o.user_id ");
			}
			searchOrder.append(" 				like '%' || ? || '%' ");
			searchOrder.append(" 				order by ord_date desc) os) ");
			searchOrder.append(" 		where  rnum > ? and rnum <= ?+? ");
			searchOrder.append(" 		order by rnum ");
			
			if(order_stat_cd != 0) {
			list = jt.query(searchOrder.toString(), new Object[] { String.valueOf(order_date1),String.valueOf(order_date2),Long.valueOf(order_stat_cd),String.valueOf(searchValue),Long.valueOf(start),Long.valueOf(rowsPerPage),Long.valueOf(start) }, 
					new RowMapper<OrderVO>() {
						public OrderVO mapRow(ResultSet rs, int rowNum) throws SQLException {
							OrderVO oVO = new OrderVO();
							oVO.setNo(rs.getString("rnum"));
							oVO.setOrd_cd(rs.getString("ord_cd"));
							oVO.setOrd_date(rs.getString("ord_date"));
							oVO.setOrd_stat_name(rs.getString("ord_stat_name"));
							return oVO;
						}
					});	
			} else {
				list = jt.query(searchOrder.toString(), new Object[] { String.valueOf(order_date1),String.valueOf(order_date2),String.valueOf(searchValue),Long.valueOf(start),Long.valueOf(rowsPerPage),Long.valueOf(start) }, 
						new RowMapper<OrderVO>() {
							public OrderVO mapRow(ResultSet rs, int rowNum) throws SQLException {
								OrderVO oVO = new OrderVO();
								oVO.setNo(rs.getString("rnum"));
								oVO.setOrd_cd(rs.getString("ord_cd"));
								oVO.setOrd_date(rs.getString("ord_date"));
								oVO.setOrd_stat_name(rs.getString("ord_stat_name"));
								return oVO;
							}
						});	
			}
			//4. Spring Container 닫기
			gjt.closeAc();
			
			return list;
		}
		
		public int countHomeDashPrice(String date1, String date2) throws SQLException {
			int price = 0;
			
			//1. Spring Container 얻기
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate 얻기
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. 쿼리문 실행
			StringBuilder countOrder = new StringBuilder();
			countOrder.append(" select nvl(sum(ord_price),0) from orders where ord_stat_cd=? and to_char(ord_date,'YYYYMMDD') between ? and ? ");
		
			price=jt.queryForObject(countOrder.toString(), new Object[] {String.valueOf(3),String.valueOf(date1),String.valueOf(date2)},Integer.class);
		
			gjt.closeAc();
			return price;
		}
		
		public String countHomeDashOrder(String date1, String date2) throws SQLException {
			String cnt = null;
			
			//1. Spring Container 얻기
			GetJdbcTemplate gjt=GetJdbcTemplate.getInstance();
			//2. JdbcTemplate 얻기
			JdbcTemplate jt=gjt.getJdbcTemplate();
			//3. 쿼리문 실행
			StringBuilder countOrder = new StringBuilder();
			countOrder.append(" select nvl(count(ord_cd),0) from orders where ord_stat_cd=? and to_char(ord_date,'YYYYMMDD') between ? and ? ");
		
			cnt=jt.queryForObject(countOrder.toString(), new Object[] {String.valueOf(3),String.valueOf(date1),String.valueOf(date2)},String.class);
		
			//4. Spring Container 닫기
			gjt.closeAc();
			
			return cnt;
		}
}
