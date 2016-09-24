<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList, admin.item.model.vo.Item" %>
<%
	ArrayList<Item> list = (ArrayList<Item>)request.getAttribute("list");
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
<center><h1>상품 목록</h1><br>
	
	<form action = "ItemsSearch" method="post">
	<select name = "no">
		<option value = "0"> -- 선택 -- </option>
		<option value = "1">ID</option>
		<option value = "2">상품명</option>
		<option value = "3">태그</option>
	</select>
	<input type="text" name = "keyword" size = "30">
	<input type = "submit" value="검색">
	</form>

	<table cellspacing = "0">
		<tr>
			<th>No.</th><th>상품 명</th><th>상품 카테고리</th><th>상품 가격</th><th>상품 조회수</th><th>상품 등록일</th><th>상품 판매처</th>
			<th>상품 태그</th><th>썸네일 주소</th><th>메인 이미지 주소</th><th>상품 설명 이미지 주소</th>
		</tr>
		
		<%
			for(Item i:list){		
		%>
			<tr>
				<td><%= i.getItemNo() %></td>
				<td width= "50%"><a href="SubItemViewServlet?itemNo=<%= i.getItemNo() %>">
				<%= i.getItemName() %></a></td>
				<td><%= i.getItemCatNo() %></td>
				<td><%= i.getItemPrice() %></td>
				<td><%= i.getItemCount() %></td>
				<td><%= i.getItemUpdate() %></td>
				<td><%= i.getItemVender() %></td>
				<td><%= i.getItemTag() %></td>
				<td><%= i.getItemImgMini() %></td>
				<td><%= i.getItemImg() %></td>
				<td><%= i.getItemImgDetail() %></td>
			</tr>
		<% } %>
	</table>
<p/><a href = "AdminMain.jsp">메인페이지로</a> &nbsp; &nbsp;
<a href = "ItemListView.jsp">전체 목록 보기</a>
</center>
	
</body>
</html>