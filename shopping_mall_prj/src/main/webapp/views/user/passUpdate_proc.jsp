<%@page import="kr.co.shopping_mall.model.UserInfoVO"%>
<%@page import="kr.co.shopping_mall.dao.UserDAO"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% 
String user_id=(String)session.getAttribute("user_id");
request.setCharacterEncoding("UTF-8");

String cur_pw=request.getParameter("cur_pass");
String update_pw=request.getParameter("new_pass");

UserDAO ud=new UserDAO();
UserInfoVO uv=ud.selectInfo(user_id);

//입력된 현재비밀번호 확인
String inputCurPass=DataEncrypt.messageDigest("MD5", cur_pw);
String curPass=uv.getUser_pw();

if(!inputCurPass.equals(curPass)){%>
	<script>
		alert("현재 비밀번호가 일치하지 않습니다.");
		location.href="http://211.63.89.152/views/user/passUpdateForm.jsp";
	</script>
<%}

if(inputCurPass.equals(curPass)){
	//새로 입력된 비밀번호 암호화
	String user_pw=DataEncrypt.messageDigest("MD5", update_pw);
	int cnt=ud.updatePass(user_id, user_pw); %>
	<script>
		alert("비밀번호 변경이 완료되었습니다.");
		location.href="http://211.63.89.152/views/user/passUpdateCompl.jsp";
	</script>
<%}
%>	

