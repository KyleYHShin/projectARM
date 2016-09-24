<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, admin.subitem.model.vo.SubItem" %>
    
<%
	ArrayList<SubItem> list = (ArrayList<SubItem>)request.getAttribute("list");
%>
<!DOCTYPE html >
<html>
<head>
<meta charset="UTF-8">
<title>SubItem list</title>
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
<center>
<h1 background ="yellow">제품 목록 조회</h1>

<table cellspacing = "0">
		<tr>
			<th>제품ID</th><th>제품명</th><th>제품가격</th><th>재고수량</th>
		</tr>
		
<%
			for(SubItem si:list){		
		%>
			<tr>
				<td><%= si.getItemSubNo() %></td>
				<td width= "50%">
				<%= si.getItemSubName() %></td>
				<td><%= si.getItemSubPrice() %></td>
				<td><%= si.getQuantity() %></td>
			</tr>
		<% } %>
</table>
<p/>
<a href="ItemListView.jsp">상품 목록 보기</a>
<a href="AdminMain.jsp">메인페이지로</a>
</center>
</body>
</html>