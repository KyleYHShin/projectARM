<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList, admin.member.model.vo.Member" %>
<%
	ArrayList<Member> list = (ArrayList<Member>)request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Item list</title>
<script type="text/javascript" src = "js/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		$("#title").show();
		$("#writer").hide();
		$("#noticDate").hide();
		
		$("input:radio").change(function(){
			if($("input:checked").attr("value")=="title"){
				$("#title").show();
				$("#writer").hide();
				$("#noticDate").hide();
			}else if($("input:checked").attr("value")=="id"){
				$("#title").hide();
				$("#writer").show();
				$("#noticDate").hide();
			}else if($("input:checked").attr("value")=="date"){
				$("#title").hide();
				$("#writer").hide();
				$("#noticDate").show();
			}
		});
	})
</script>
<style type="text/css">
	table {
	BORDER-TOP : 2px solid black;
	BORDER-BOTTOM : 2px solid black;
	width : 1200px;  
	text-align : center;
	}
	table th, td{
		padding : 5px;
		BORDER-BOTTOM : 1px solid #e0e0e0;
	}
	table th:nth-child(5n+1), td:nth-child(5n+1){
		background : #ececec;
	}
	table td:nth-child(5n+2){
	
		text-align : left;
		padding-left : 20px;
	}
	a{
		text-decoration :none;
		color : black;
	}
	a:hover {
		background : rgba(0,20,150, 0.3);
	}
	#ttop {
		width : 800px;
		text-align : right;
		margin :10px auto;
	}
	button {
		background : navy;
		color : white;
		border : 1px solid navy;
	}
	
		h1{background-color:yellow;
	}
</style>
</head>
<body>
<center><h1>회원 목록</h1><br>
	
	<form action = "MemberSearchServlet" method="post">
	회원 아이디로 검색
	<input type="text" name = "keyword" size = "30">
	<input type = "submit" value="검색">
	</form>
	<br>
	<br>
	<table width="600" cellspacing = "0">
		<tr>
			<th>아이디</th><th>비밀번호</th><th>이름</th><th>생년월일</th><th>성별</th><th>휴대폰 번호</th><th>이메일</th>
			<th>우편번호</th><th>주소</th><th>등급</th><th>가입일자</th><th>&nbsp;</th>
		</tr>
		
		<%
			for(Member m:list){		
		%>
			<tr>
				<td><%= m.getMemberId() %></td>
				<td><%= m.getMemberPwd() %></td>
				<td><%= m.getMemberName() %></td>
				<td><%= m.getMemberBirth() %></td>
				<td>
				<% 
					if(m.getMemberGender()=='M'){
				%>	남자
				<% }else if(m.getMemberGender() == 'F'){ %>
					여자
				<% } %>
				</td>
				<td><%= m.getMemberPhone() %></td>
				<td><%= m.getMemberEmail() %></td>
				<td><%= m.getMemberZipcode() %></td>
				<td><%= m.getMemberAddress() %></td>
				<td><%= m.getMemberGrade() %></td>
				<td><%= m.getMemberJoinDate() %></td>
				<td width="50px"><a href="/arm/MemeberDeleteServlet?id=<%= m.getMemberId() %>">삭제</a>
			</tr>
		<% } %>
	</table>
<p/><a href = "/arm/admin/AdminMain.jsp">관리자 메인페이지</a> &nbsp; &nbsp;
<a href = "/arm/MemberListView">회원 전체 보기</a>
</center>
	
</body>
</html>