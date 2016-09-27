<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@page import="admin.notice.model.vo.Faqnotice" %>
  
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>
	<center>
	
	<h1>공지사항입력</h1>
		<form action ="/arm/finsert" method=post>
		<table border=0>
			 <tr>
				<td width=103 align="center">카테고리</td>
				<td>
					<select name = "fcate">
						<option value="1">제품</option>
						<option value="2">결제</option>
						<option value="3">베송</option>
						<option value="4">가입</option>
						<option value="5">기타</option>
					</select>
				</td></tr>
			<tr> 
				<td width="103" align="center">제목</td>
				<td><input type=text name=ftitle>
			</td></tr>
			<tr>
				<td colspan=2><textarea name=fcontent rows=10 cols=70></textarea>
			</td></tr>
			
			<tr>
					<td colspan=2 align=center><input type=submit value="저장">
						<input type=reset value="취소"></td>
				</tr>
		</table>
		</form>
	
	</center>
</body>
</html>