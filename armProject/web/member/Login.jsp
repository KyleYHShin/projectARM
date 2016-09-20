<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
 <head>
  <meta charset="UTF-8">
  <title>로그인</title>
  <style type="text/css">

	div#loginDiv{
		text-align : left;
		width : 200pt;
	}
	label#ckauto {
		font-size : 11pt;
	}
	span {
		font-size : 9pt;
	}

	#login_btn {
		background : red;
		border : 1px solid red;
		color : white;
	}
	
	#sch_id {
		background : white;
		border : 1px solid green;
		color : black;
	}
	#sch_pwd {
		background : white;
		border : 1px solid green;
		color : black;
	}
	#join_btn{
		background :white;
		border : 1px solid green;
		color : black;
	}
	#loginTb td{
		padding : 10px;
	}
  </style>
 </head>
 <body>
	<center>
	 
    <h1>로 그 인</h1>
	<div id = "loginDiv" class="form">
    <form>
	<table id = "loginTb" border = "0">
	<tr><td>
      <input type="text" style="width:200pt; height:30pt" placeholder="아 이 디"/>
	  </td></tr>
	<tr><td>
      <input type="password" style="width:200pt; height:30pt" placeholder="비 밀 번 호"/><br>
	  <label id = "ckauto"><input type="checkbox" align="left"> 자동 로그인</label><br>
	  <span>개인 PC가 아닐 경우 주의하세요!</span><br>
	  </td></tr>
	    <tr><td>
		</td></tr>
	<tr><td>
      <input id = "login_btn" type="submit" style="WIDTH: 200pt; HEIGHT: 30pt" value="Log in"><br></td></tr>
	    <tr><td>
		</td></tr>
	 <tr><td><input id = "sch_id" type="button" style="width: 100pt; height:20pt" value="ID 찾기"><input id = "sch_pwd" type="button" style="width: 100pt; height:20pt" value="비밀번호 찾기"><br>
	
	  <input id = "join_btn" type="button" style="width: 200pt; height:30pt" value="회원가입">
	   </td></tr>

	 </table>
    </form>
	
	</div>
	<br><br><br><br>
	<form>
	<a href="http://www.naver.com"><img src="images/button.jpg" width="300" height="300" border="0" alt="">
	<a href="http://www.naver.com"><img src="images/button.jpg" width="300" height="300" border="0" alt="">
	<a href="http://www.naver.com"><img src="images/button.jpg" width="300" height="300" border="0" alt="">
	<a href="http://www.naver.com"><img src="images/button.jpg" width="300" height="300" border="0" alt="">
	</form>
	</center>

 </body>
</html>
    