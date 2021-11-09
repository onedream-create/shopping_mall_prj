<%@page import="kr.co.shopping_mall.dao.AdminDAO"%>
<%@page import="kr.co.shopping_mall.model.ProductVO"%>
<%@page import="java.util.Date"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="org.apache.jasper.tagplugins.jstl.core.Param"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>

<%
	// 1. upload 폴더 생성이 안되어 있으면 생성
	String saveDirectory = pageContext.getServletContext().getRealPath("/common/uploadImg/pro_img/");

	File saveDir = new File(saveDirectory);
	if (!saveDir.exists())
		saveDir.mkdirs();

	// 2. 최대크기 설정
	int maxPostSize = 1024 * 1024 * 5; // 5MB  단위 byte

	//3. 인코딩 방식 설정
	String encoding = "UTF-8";

	//4. 파일정책, 파일이름 충동시 덮어씌어짐으로 파일이름 뒤에 인덱스를 붙인다.
    //a.txt => a1.txt 와 같은 형식으로 저장된다.
	FileRenamePolicy policy = new DefaultFileRenamePolicy();
	MultipartRequest mrequest 
	= new MultipartRequest(request //MultipartRequest를 만들기 위한 request
			, saveDirectory //저장 위치
			, maxPostSize //최대크기
			, encoding //인코딩 타입
			, policy); //파일 정책
	
	ProductVO pVO = new ProductVO();
	pVO.setPro_name(mrequest.getParameter("pro_name")); //상품명
	pVO.setPro_price(Integer.parseInt(mrequest.getParameter("pro_price"))); //상품가격
	pVO.setCategory_cd(Integer.parseInt(mrequest.getParameter("category_cd"))); //상품분류
	pVO.setPro_img(mrequest.getFilesystemName("pro_img")); //저장된 이름
	pVO.setPro_detail(mrequest.getParameter("pro_detail")); //상품설명
	
	//mrequest.getFile("pro_img"); //input type="file" 태그의 name속성값을 이용해 파일객체를 생성
	//mrequest.getFile("pro_img").uploadFile.length(); //파일크기
	//mrequest.getOriginalFileName("pro_img"); //기존 이름
	
	AdminDAO aDAO = new AdminDAO();
	aDAO.addProduct(pVO);
%>