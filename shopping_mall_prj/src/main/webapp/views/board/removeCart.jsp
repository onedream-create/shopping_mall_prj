<%@page import="java.util.ArrayList"%>
<%@page import="kr.co.shopping_mall.model.ProductVO"%>
<%@page import="kr.co.shopping_mall.dao.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"
    info="해당 상품 삭제"%>
<%
request.setCharacterEncoding("UTF-8");
String pro_cd=request.getParameter("pro_cd"); //이건 왜 ?
//상품 id 넘어오지 않았을 때 강제로 cart_list.jjsp이동시키고 종료
if(pro_cd==null){
	response.sendRedirect("cart_list.jsp");
	return;
}
//상품 데이터 접근 클래스의 인스턴스 생성
ProductDAO pd=new ProductDAO();
//해당 pro_cd 값을 이용해서 상품 상세정보를 얻어오는 코드
ProductVO pv=pd.selectPro(pro_cd);
if(pv==null){%>
	<script>
	alert("장바구니에 삭제할 상품이 없습니다.")
	return;
	</script>
<% 
}
ArrayList<ProductVO> cart=(ArrayList<ProductVO>)session.getAttribute("cart");
ProductVO goodQnt = new ProductVO();
for(int i=0;i<cart.size();i++){
	goodQnt=cart.get(i);
	if(goodQnt.getPro_cd().equals(pro_cd)){
		cart.remove(goodQnt);
	}
}

response.sendRedirect("cart_list.jsp");
%>
