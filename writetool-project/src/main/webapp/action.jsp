<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="com.oreilly.servlet.MultipartRequest" %> <!-- request 대신 -->
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %> <!-- 파일이름 중복을 피할 수 있도록 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	// 웹 프로젝트 위치에 넣어도 된다 (이클립스에서 사진 추가되는 것을 실시간으로 확인 가능)
	// MultipartRequest mr = new MultipartRequest(request, "C:/Users/fjdks/Desktop/erp/WebContent/image", 1024*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	MultipartRequest mr = new MultipartRequest(request, request.getRealPath("/image"), 1024*1024*1024, "utf-8", new DefaultFileRenamePolicy());
	System.out.println("저장되는 경로(실제 서버) : "+request.getRealPath("/image"));
	
	String fileName = mr.getFilesystemName("image");
	System.out.println("사진 이름 : "+fileName);
%>
</body>
</html>