<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    String code = (String)request.getAttribute("code");
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>에러</title>
</head>
<body>
	<h1>에러가났습니다</h1>
<%
	String message = null;
	switch(code){
	case "mjoin" : message = "로그인쪽 에러"; break;
	case "myinfo" : message = "조회 에러"; break;
	case "mupdate" : message = "수정 에러"; break;
	default: message = "알 수 없는 에러가 발생"; break;
	}
	%>
	에러 : <%= message %><br>
	<a href = "layout_login.html">시작 페이지로 이동</a>
</body>
</html>