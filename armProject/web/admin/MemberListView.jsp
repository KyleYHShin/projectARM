<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList, admin.member.model.vo.Member" %>
<%
	ArrayList<Member> list = (ArrayList<Member>)request.getAttribute("list");
	String msg = (String)request.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Item list</title>
<script type="text/javascript" src = "js/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
	$(function(){
		//에러메세지 출력
		<% if(msg != null){ %>
			alert("<%= msg %>");
		<% } %>
		
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
	table th:nth-child(1), td:nth-child(1){
		background : #ececec;
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
	
	<form action = "/arm/amsearch" method="post">
	회원 아이디로 검색
	<input type="text" name = "keyword" size = "30">
	<input type = "submit" value="검색">
	</form>
	<br>
	<br>
	<table width="600" cellspacing = "0">
		<tr>
			<th>아이디</th><th>이름</th><th>생년월일</th><th>성별</th><th>휴대폰 번호</th><th>이메일</th>
			<th>우편번호</th><th>주소</th><th>등급</th><th>가입일자</th><th>&nbsp;</th>
		</tr>
		
		<%
		if(list != null){
			for(Member m:list){		
		%>
			<tr>
				<td><%= m.getUserId() %></td>
				<td><%= m.getUserName() %></td>
				<td><%= m.getBirthDate() %></td>
				<td>
				<% 
					if(m.getGender()=='M'){
				%>	남자
				<% }else if(m.getGender() == 'F'){ %>
					여자
				<% } %>
				</td>
				<td><%= m.getPhone() %></td>
				<td><%= m.getEmail() %></td>
				<td><%= m.getZipCode() %></td>
				<td><%= m.getAddress() %></td>
				<td><%= m.getGrade() %></td>
				<td><%= m.getJoinDate() %></td>
				<td width="50px"><a href="/arm/amdelete?id=<%= m.getUserId() %>">삭제</a>
			</tr>
		<% } 
		} else {%>
			<tr><td colspan ="11"><%= msg %></td></tr>
		<% } %>
	</table>
<p/><a href = "/arm/mainlist">관리자 메인페이지</a> &nbsp; &nbsp;
<a href = "/arm/amlist">회원 전체 보기</a>
</center>
	
</body>
</html>