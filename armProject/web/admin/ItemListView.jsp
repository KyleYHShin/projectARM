<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList, admin.item.model.vo.Item, admin.item.model.vo.Category, admin.item.model.vo.Vender" %>
<%
ArrayList<Item> list = (ArrayList<Item>)request.getAttribute("list");
ArrayList<Category> category = (ArrayList<Category>)request.getAttribute("category");
ArrayList<Vender> vender = (ArrayList<Vender>)request.getAttribute("vender");
Item item = (Item)request.getAttribute("item");
String msg = (String)request.getAttribute("msg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Item list</title>
<script type="text/javascript" src = "js/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
	function addDiv(){
		$("#item_add").slideToggle("fast");
	}
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
	#sort {
		text-align : right;
		padding-right : 50px;
	}
	#item_add{
		display : none;
	}
	table {
		BORDER-TOP : 2px solid black;
		BORDER-BOTTOM : 2px solid black;
		text-align : center;
		width : 1200px;
	}
	#iaddTb tr{
		height : 50px;
	}
	table th, td{
		padding : 5px;
		BORDER-BOTTOM : 1px solid #e0e0e0;
	}
	table th:nth-child(12n+1), td:nth-child(12n+1){
		background : #ececec;
	}
	table td:nth-child(2){
		text-align : left;
		padding-left : 20px;
	}
	table td:nth-child(8){
		text-align : left;
		padding-left : 20px;
	}
	a{
		text-decoration :none;
		color : black;
	}
	a:hover {
		background : rgba(0,20,150, 0.3);
		text-decoration :underline;
	}
	h1{background-color:yellow;
	}
	input[type=number]{
		width:70px;
	}
	input[type=file]{
		width:100%;
	}
</style>
</head>
<body>
<center><h1>상품 목록</h1><br>
	<form action = "/arm/aisearch" method="post">
	<select name = "no">
		<option value = "0"> -- 선택 -- </option>
		<option value = "1">ID</option>
		<option value = "2">상품명</option>
		<option value = "3">태그</option>
	</select>
	<input type="text" name = "keyword" size = "30">
	<input type = "submit" value="검색">&nbsp;&nbsp;<input type="button" onclick="addDiv()" id ="addbtn" value="추가">
	</form><br>
	<div id = "item_add">
	<form action="/arm/aiinsert" method="post" enctype="multipart/form-data">
	<table id = "iaddTb" cellspacing = "0">
		<tr>
			<th width="200px">상품 명</th><th>카테고리</th><th>기본가</th><th>판매처</th>
			<th>태그</th><th>썸네일</th><th>메인 이미지</th><th>상품 설명 이미지</th><th></th>
		</tr>
		<tr>
			<td><input tyep="text" name="itemname"></td>
			<td>
			<select name="categoryno">
			<% for(Category c : category){ %>
				<option value="<%= c.getItemCategoryNo() %>"><%= c.getItemCategoryName() %>
			<% } %>
			 </select>
			</td>
			<td><input type="number" name="itemprice" value=10000></td>
			<td>
			<select name="venid">
			<% for(Vender v : vender){ %>
				<option value="<%= v.getVenId() %>"><%= v.getVenName() %>
			<% } %>
			 </select>
			</td>
			<td><input type="text" name="itemtag" placeholder="공백없이 쉼표(,)로 구분"></td>
			<td><input type="file" name ="imgmini"></td>
			<td><input type="file" name ="img"></td>
			<td><input type="file" name ="imgdetail"></td>
			<td><input type="submit" value="확인"></td>
		</tr>
	</table>
	</form>
	</div>
	<% if (item != null){ %>
	<br>
	<div id = "item_update">
	<form action="aiupdate" method="post" enctype="multipart/form-data">
	<table id = "iupdateTb" cellspacing = "0">
		<tr>
			<th>No.</th><th width="200px">상품 명</th><th>카테고리</th><th>기본가</th><th>판매처</th>
			<th>태그</th><th>썸네일</th><th>메인 이미지</th><th>상품 설명 이미지</th><th></th>
		</tr>
		<tr>
			<td><input type="text" name ="itemno" value="<%= item.getItemNo() %>" readonly style="width:20px; background:none; border:0; text-align:center;"></td>
			<td><input type="text" name="itemname" value = "<%= item.getItemName() %>"></td>
			<td>
			<select name="categoryno">
			<% for(Category c : category){
				if(c.getItemCategoryNo() == item.getItemCatNo()){ %>
				<option value="<%= c.getItemCategoryNo() %>" selected><%= c.getItemCategoryName() %>
				<% }else{ %>
				<option value="<%= c.getItemCategoryNo() %>"><%= c.getItemCategoryName() %>
				<% } %>
			<% } %>
			 </select>
			</td>
			<td><input type="number" name="itemprice" value = "<%= item.getItemPrice() %>"></td>
			<td>
			<select name="venid">
			<% for(Vender v : vender){ 
				if(v.getVenId() == item.getItemVender()){ %>
				<option value="<%= v.getVenId() %>" selected><%= v.getVenName() %>
				<% }else{ %>
				<option value="<%= v.getVenId() %>"><%= v.getVenName() %>
				<% } %>
			<% } %>
			 </select>
			</td>
			<td><input type="text" name="itemtag" value = "<%= item.getItemTag() %>"></td>
			<td><input type="file" name ="imgmini" value = "<%= item.getItemImgMini() %>"></td>
			<td><input type="file" name ="img" value = "<%= item.getItemImg() %>"></td>
			<td><input type="file" name ="imgdetail" value = "<%= item.getItemImgDetail() %>"></td>
			<td><input type="submit" value="확인"></td>
		</tr>
	</table>
	</form>
	</div>
	<% } %>
	<div id="sort">
		<a href="ItemSortListView?&sortNo=1">등록일내림차순</a>&nbsp;&nbsp;
		<a href="ItemSortListView?&sortNo=2">등록일오름차순</a>&nbsp;&nbsp;
		<a href="ItemSortListView?&sortNo=3">상품명내림차순</a>&nbsp;&nbsp;
		<a href="ItemSortListView?&sortNo=4">상품명오름차순</a>&nbsp;&nbsp;
	</div>
	<!-- sort -->
	<table id ="itemList" cellspacing = "0">
		<tr>
			<th>No.</th><th width="200px">상품 명</th><th>카테고리</th><th>기본가</th><th>조회수</th><th>등록일</th><th>판매처</th>
			<th>태그</th><th>썸네일</th><th>메인 이미지</th><th>상품 설명 이미지</th><th></th>
		</tr>
		
		<%
		if(list != null){
			for(Item i:list){
		%>
			<tr>
				<td><%= i.getItemNo() %></td>
				<td><a href="aslist?itemNo=<%= i.getItemNo() %>">
				<%= i.getItemName() %></a></td>
				<td><%= i.getItemCatNo() %></td>
				<td><%= i.getItemPrice() %></td>
				<td><%= i.getItemCount() %></td>
				<td><%= i.getItemUpdate() %></td>
				<td><%= i.getItemVender() %></td>
				<td><%= i.getItemTag() %></td>
				<td><%= i.getItemImgMini().substring(1,5)+"..."+i.getItemImgMini().substring(i.getItemImgMini().indexOf("item/")+4) %></td>
				<td><%= i.getItemImg().substring(1,5)+"..."+i.getItemImg().substring(i.getItemImg().indexOf("item/")+4) %></td>
				<td><%= i.getItemImgDetail().substring(1,5)+"..."+i.getItemImgDetail().substring(i.getItemImgDetail().indexOf("item/")+4) %></td>
				<td width="50px"><a href="/arm/aiupview?itemno=<%= i.getItemNo() %>">수정</a>
				<a href="/arm/aidelete?itemno=<%= i.getItemNo() %>">삭제</a></td>
			</tr>
		<% }
		}else{ %>
			<tr><td colspan="12"><%= msg %></td></tr>
		<% } %>
	</table>
<p/><a href = "/arm/mainlist">메인페이지로</a> &nbsp; &nbsp;
<a href = "/arm/ailist">전체 목록 보기</a>

</center>
	
</body>
</html>