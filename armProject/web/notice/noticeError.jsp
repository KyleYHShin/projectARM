<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	String code = (String)request.getAttribute("code");
    %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="UTF-8">
<title>notice error</title>
</head>
<body>
	<h1>공지글 관련 에러</h1>
	<%
		String message = null;
	switch(code){
	case "nlist": message = "공지글 전체보기가 실패하였습니다"; break;
	case "ninsert" : message = "공지글 입력에 실패하였습니다"; break;
	case "nomulti" : message = "파일에러"; break;
	default : message = "공지서비스에서 에러가 발생하였습니다"; break;
	}
	%>
	<h2>에러 : <%= message %></h2>
</body>
</html>