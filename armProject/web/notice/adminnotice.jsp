<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="admin.notice.model.vo.Notice" %>
    <%
    	Notice notice =(Notice) request.getAttribute("notice");
    %>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<center>
	
	<h1>공지사항입력</h1>
		<form action ="ninsert" method=post name=insert target="main">
		<table border=0>
			<tr>
				<td width=103 align="center">카테고리</td>
				<td>
					<select name = "cate">
						<option value="notice">공지사항</option>
						<option value="event">이벤트</option>
					</select>
				</td></tr>
			<tr>
				<td width="103" align="center">제목</td>
				<td><input type=text name=nTitle>
			</td></tr>
			<tr>
				<td colspan=2><textarea name=nContent rows=10 cols=70></textarea>
			</td></tr>
			<tr>
				<td >첨부파일<input type ="button" id="addFile" value="파일추가"></td>
				
				</tr>
			
		</table>
		</form>
	
	</center>
</body>
</html>