<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.FileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" trimDirectiveWhitespaces="true" pageEncoding="UTF-8"%>

<%
// 1. upload 폴더 생성이 안되어 있으면 생성
String saveDirectory = pageContext.getServletContext().getRealPath("/common/uploadImg/pro_detail/");

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

		String filesystemName = mrequest.getFilesystemName("file");
		
		out.print("http://211.63.89.152/common/uploadImg/pro_detail/"+filesystemName);
%>