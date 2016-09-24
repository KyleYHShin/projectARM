<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, admin.subitem.model.vo.SubItem, admin.item.model.vo.Item" %>
<%
ArrayList<SubItem> list = (ArrayList<SubItem>)request.getAttribute("list");
Item item = (Item)request.getAttribute("item");
SubItem subItem = (SubItem)request.getAttribute("subitem");
String msg = (String)request.getAttribute("msg");
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
	table#subList {
	BORDER-TOP : 2px solid black;
	BORDER-BOTTOM : 2px solid black;
	width : 800px;
	text-align : center;
	}
	table#sub_add,
	table#sub_update {
	height : 40px;
	BORDER-TOP : 1px solid black;
	BORDER-BOTTOM : 1px solid black;
	width : 800px;
	text-align : center;
	}
	table#subList th,
	table#subList td,
	table#sub_update td,
	table#sub_update th{
		padding : 5px;
		BORDER-BOTTOM : 1px solid #e0e0e0;
	}
	table#subList th:nth-child(1),
	table#subList td:nth-child(1),
	table#sub_update td:nth-child(1),
	table#sub_update th:nth-child(1){
		background : #ececec;
	}
	table td:nth-child(2){
		text-align : left;
		padding-left : 20px;
	}
	#itemno{
		display:none;
	}
	a{
		text-decoration :none;
		color : black;
	}
	a:hover {
		background : rgba(0,20,150, 0.3);
	}
	h1{
	background-color:yellow;
	}
	input[readonly]{
		background : none;
		border:0;
		width : 20px;
	}
</style>
</head>


<body>
<center>
<h1 background ="yellow">[<%= item.getItemName() %>] 제품 목록 조회</h1>
<form action="/arm/asinsert" method="post">
<table id = "sub_add" cellspacing="0">
	<tr>
		<td><input type="text" name="sname" placeholder="옵션명"></td>
		<td><input type="number" name="sprice" placeholder="가격"></td>
		<td><input type="number" name="sqty" placeholder="재고수량"></td>
		<td><input type="text" id = "itemno" name="itemno" value="<%= item.getItemNo() %>"><input type = "submit" value = "추가"></td>
	</tr>
</table>
</form>
<br>
<% if(subItem != null){ %>
<form action="/arm/asupdate" method="post">
<table id = "sub_update" cellspacing="0">
	<tr>
		<th>ID</th><th>옵션명</th><th>옵션가</th><th>재고수량</th><th></th>
	</tr>
	<tr>
		<td><input type="text" name="subno" value="<%= subItem.getItemSubNo() %>" readonly></td>
		<td><input type="text" name="sname" placeholder="옵션명" value="<%= subItem.getItemSubName() %>"></td>
		<td><input type="number" name="sprice" placeholder="가격" value="<%= subItem.getItemSubPrice() %>"></td>
		<td><input type="number" name="sqty" placeholder="재고수량" value="<%= subItem.getQuantity() %>"></td>
		<td><input type="text" id = "itemno" name="itemno" value="<%= item.getItemNo() %>">
		<input type = "submit" value = "확인"></td>
	</tr>
</table>
</form>
<br>
<% } %>

<table id = "subList" cellspacing = "0">
		<tr>
			<th>ID</th><th>옵션명</th><th>옵션가</th><th>재고수량</th><th></th>
		</tr>
		<%
		if(list!= null){
			for(SubItem si:list){		
		%>
			<tr>
				<td><%= si.getItemSubNo() %></td>
				<td><%= si.getItemSubName() %></td>
				<td><%= si.getItemSubPrice() %></td>
				<td><%= si.getQuantity() %></td>
				<td width="40px"><input type="text" id = "itemno" name="itemno" value="<%= item.getItemNo() %>">
				<a href="asupview?itemno=<%= item.getItemNo() %>&subno=<%= si.getItemSubNo() %>">수정</a>
				<a href="asdelete?itemno=<%= item.getItemNo() %>&subno=<%= si.getItemSubNo() %>">삭제</a>
			</tr>
		<% } 
		}else{ %>
			<tr><td colspan = "4"><%= msg %></td></tr>
		<% } %>
</table>
<p/>
<a href="/arm/ailist">상품 목록 보기</a>&nbsp;&nbsp;&nbsp;
<a href="/arm/admin/AdminMain.jsp">메인페이지로</a>
</center>
</body>
</html>