<%@page import="kr.co.sist.util.cipher.DataDecrypt"%>
<%@page import="kr.co.sist.util.cipher.DataEncrypt"%>
<%@page import="com.google.gson.Gson"%>
<%@page import="kr.co.shopping_mall.model.UserVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%

String division = request.getParameter("division");
String searchValue = request.getParameter("searchValue");
String user_category = request.getParameter("user_category");

DataEncrypt de = new DataEncrypt("AbcdEfgHiJkLmnOpQ");

if(division.equals("2")){
	searchValue = de.encryption(searchValue);
}

int index = Integer.valueOf(request.getParameter("index"));
int rowsPerPage = 8; //페이지당 보여줄갯수
//데이터시작점
int start = (index-1) * rowsPerPage;

AdminDAO aDAO = new AdminDAO();
List<UserVO> userList = aDAO.searchUser(division, searchValue, user_category, start, rowsPerPage);

DataDecrypt dd = new DataDecrypt("AbcdEfgHiJkLmnOpQ");

for (int i = 0; i < userList.size(); i++) {
		UserVO uVO = userList.get(i);
		try {	
			uVO.setUser_name(dd.decryption(uVO.getUser_name()));
			uVO.setUser_tel(dd.decryption(uVO.getUser_tel()));
			uVO.setUser_email(dd.decryption(uVO.getUser_email()));		
		} catch (NullPointerException e) {
			uVO.setUser_name("삭제됨");
			uVO.setUser_tel("삭제됨");
			uVO.setUser_email("삭제됨");
		}
		userList.set(i, uVO);
	}

Gson gson = new Gson();
String json = gson.toJson(userList);

out.println(json);	

%>