<%@page import="kr.co.shopping_mall.dao.ProductDAO"%>
<%@page import="kr.co.shopping_mall.model.ProductVO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String pro_cd=request.getParameter("pro_cd");
int cnt=Integer.parseInt(request.getParameter("cnt"));

ArrayList<ProductVO> cart=null;

Object obj=session.getAttribute("cart");

if(obj==null){
	cart=new ArrayList<ProductVO>();
}else{
	cart=(ArrayList<ProductVO>)obj;
}//end else
	
int pos= -1; //등록된 제품이 없다
//장바구니 세션에 동일한 제품이 있을 경우 : cnt 증가
for(int i=0; i < cart.size(); i++){
	ProductVO pv=cart.get(i);
	if(pv.getPro_cd().equals(pro_cd)){
		pos=1;
		pv.setCnt(pv.getCnt()+cnt);
		break;
	}//end if
}//end for

//장바구니 세션에 동일한 제품이 없을 경우 : ProductVO 객체 생성하여 배열에 등록
if(pos==-1){
	ProductVO pv=new ProductVO();
	//pro_cd를 통해 필요한 상품 데이터 조회
	ProductDAO pd=new ProductDAO();
	ProductVO selectPv=pd.selectPro(pro_cd);
	
	pv.setPro_cd(pro_cd); //상품코드
	//이미지, 상품명, 수량, 가격
	pv.setPro_img(selectPv.getPro_img());
	pv.setPro_name(selectPv.getPro_name());
	pv.setCnt(cnt);
	pv.setPro_price(selectPv.getPro_price());
	//배열에 등록
	cart.add(pv);
}//end if

//cart 세션 객체 생성
session.setAttribute("cart", cart);
%>

<script>
alert("장바구에 담았습니다."); 
location.href="http://localhost/shopping_mall_prj/views/board/prod_detail.jsp?pro_cd=<%=pro_cd%>";
</script>