<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList, java.util.HashMap, admin.qna.model.vo.Answer, admin.qna.model.vo.Question" %>
<%
 ArrayList<Question> questionList = (ArrayList<Question>)request.getAttribute("questionList");
 HashMap<Integer, String> itemList = (HashMap<Integer, String> )request.getAttribute("itemList");
 HashMap<Integer, String> subItemList = (HashMap<Integer, String> )request.getAttribute("subItemList");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Item list</title>
<script type="text/javascript" src = "js/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
/*-------------------------------------------textarea 입력 글자수 제한------*/
$(document).ready(function(){
   $("textarea").keyup(function(){
      var input = $(this).val().length;
      var max = 600;
      if (input > max){
         alert("입력 가능한 글자수를 초과하였습니다.");
         this.value = this.value.substring(0, max);
         this.focus();
      }
         
   });
});
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
		
		 $('.content').hide();
		$('tr').click(function(){	
			
			$(this).next('.content').toggle();
		});
		
	})
</script>
<style type="text/css">

	table {
		BORDER-TOP : 2px solid black;
		BORDER-BOTTOM : 2px solid black;
		text-align : center;
		width : 1200px;
	}

	table th, td{
		padding : 5px;
		BORDER-BOTTOM : 1px solid #e0e0e0;
	}
	table th:nth-child(1), td:nth-child(1){
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
	
	/*input[type=number]{
		width:70px;
	}
	input[type=file]{
		width:100%;
	}*/
	
	input[type=text] {
		border: none;
	}
	
     textarea {
		display: block;
		width: 100%;
		-webkit-box-sizing: border-box;
		-moz-box-sizing: border-box;
		box-sizing: border-box;
	}
	
</style>
</head>
<body>
<center><h1>Q&A List</h1><br>

<table cellspacing = "0">
		<tr>
			<th width="10%">문의번호</th><th width="50%">문의내역</th><th>문의등록일</th><th>답변여부</th>
		</tr>
		<% 
		  if( questionList != null){
			  for(int i = 0; i < questionList.size(); i++) {
				  int item_no = questionList.get(i).getItemNo();
				  int item_sub_no = questionList.get(i).getItemSubNo();
				  String answered = "";
				  Answer answer = questionList.get(i).getAnswer();
				  
				  if (answer != null) {
					 answered = "Yes";
				 }else{
					 answered = "No";
			 	 }	
		%>
		<form method="get" action="/arm/AnswerUpdateServlet">
		<tr>
			<td id="<%= questionList.get(i).getqNo() %>">
				<p name="qNo"><%= questionList.get(i).getqNo() %></p>
			</td>
			<td><span style="font-size:9pt">상품명 : <%= itemList.get(item_no) %>
			<% if(subItemList.get(item_sub_no)!=null){ %>
			/ 옵션명 : <%= subItemList.get(item_sub_no) %>
			<% } %>
			</span><br><%= questionList.get(i).getqContent() %>
			</td>
			<td><%= questionList.get(i).getqDate() %></td>	
			<td><%= answered %></td>
		</tr>
			<% if (answered.equals("Yes")){ %>
		
		<tr class="content">
			<td id="<%= questionList.get(i).getqNo() %>"></td>
			<td colspan="2">
				<input type="hidden" name="qNo" value="<%= questionList.get(i).getqNo() %>">
				<input type="hidden" name="aNo" value="<%= questionList.get(i).getAnswer().getaNo()%>">
				<textarea name="loaded_aContent" required><%= questionList.get(i).getAnswer().getaContent() %></textarea>
			</td>
			<td>
				<input type="submit" value="수정" style="font-size: 12px; width: 40px; height: 30px;">
				<button style="font-size: 12px; width: 40px; height: 30px;"	type="submit" formaction="/arm/AnswerDeleteServlet">삭제</button>
			</td>
		</tr>		
		</form>	
		<% }else{ %>
			<form>
			<tr class="content">
				<td id="<%= questionList.get(i).getqNo() %>"></td>
				<td colspan="2">
					<input type="hidden" name="qNo" value="<%= questionList.get(i).getqNo() %>">
					<textarea name="new_aContent" required></textarea>
				</td>
				<td>
					<button style="font-size: 12px; width: 40px; height: 30px;"	type="submit" formaction="/arm/AnswerInsertServlet">입력</button>
				</td>
			</tr>
			</form>
			<% }
			} //end of for %>
	  
		<%  } else { //end of if (questionList != null) %>
			<tr><td colspan="4">작성된 문의가 없습니다....</td></tr>
		<% } %>
</table>
	
<p/><a href = "/arm/mainlist">메인페이지로</a> &nbsp; &nbsp;

</center>
	
</body>
</html>