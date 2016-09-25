<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% String msg = (String)request.getAttribute("msg"); %>
<!doctype html>
<html lang="ko">
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Login</title>

    <!-- Bootstrap -->
    <link href="/arm/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="/arm/bootstrap/js/bootstrap.min.js"></script>
  
  <script type="text/javascript" src = "js/jquery-3.1.0.min.js"></script>
  <script type="text/javascript">
//--------------------------------------------------------------최근본 목록-----이슬작성-------
	function viewRecentItem(){
		//sessionStorage.clear();
		var slen = sessionStorage.length;
		var rItems = "";
		if(slen==0){
			$("#recent_list").html("<div class='ritem'>최근 본 상품이 없습니다.</div>");
		}else{
			if(slen <= 4){
				for(var i = slen-1; i > 0; i--){
					var key = sessionStorage.key(i);
					var item = sessionStorage[key];
					var values = item.split(",");
					var rItem = "<div class='ritem'><a href='/arm/ItemDetailViewServlet?itemNo="+values[0]+"'><img src='"+values[1]+"'></a></div>";
					rItems += rItem;
				}
			} else {//최대 4개만 보여준다
				for(var i = slen-1; i > slen-5; i--){
					var key = sessionStorage.key(i);
					var item = sessionStorage[key];
					var values = item.split(",");
					var rItem = "<div class='ritem'><a href='/arm/ItemDetailViewServlet?itemNo="+values[0]+"'><img src='"+values[1]+"'></a></div>";
					rItems += rItem;
				}
				for(var i = slen-5; i > 0; i--){
					var key = sessionStorage.key(i);
					sessionStorage.removeItem(key);
					//4개이상은 지우기 위홤
				}
			}
			$("#recent_list").html(rItems);
		}
	}
//------------------------------------------------------------------------끗---------
	function nologinCart(){
	    alert("로그인이 필요합니다");
	}
	$(function(){
		//최근목록보기
		viewRecentItem();
		
		//퀵바 위치 조절
		var winH = $(window).height();
		var qH = $("#quick_bar").height();
		var qbH = $("#qBtn").height();
		var qTop = (winH-qH)/2;
		var qbTop = (winH-qbH)/2;
		$("#quick_bar").css("top", qTop);
		$("#qBtn").css("top", qbTop);
		
		$(document).on("hover",".menuLink", function(){
			$(this).css("color","red").css("cursor","pointer");
		});
//-- ----------------------------------------------------------이슬작성-끗---------------- -->
		$(document).on("hover",".menuLink", function(){
			$(this).css("color","red").css("cursor","pointer");
		});
		//스크롤시 카테고리고정
		var menupos = $("#fix_menu").offset().top;
		$(window).scroll(function(){
			if($(window).scrollTop() >= menupos){
				$("#fix_menu").css("position","fixed").css("top","0");
				$("#fix_menu").width($("#wrapper").width());
				//스크롤시 fix_menu에 가려지는 부분 응급처리
				$("body").css("position","relative").css("top","65px");
			}else{
				$("#fix_menu").css("position", "relative").css("top","");
				$("body").css("position","relative").css("top","0");
			}
		});
		//브라우저 크기변화시 카테고리 크기
		$(window).resize(function(){
			$("#fix_menu").width($("#wrapper").width());
		});

		//검색창 슬라이드토글
		var sonoff = 0;
		$("#sch").click(function(){
			$("#searchbox").slideToggle("fast");
			if(sonoff == 0){
				$("#sch").css("background", "red").css("color", "white");
				sonoff = 1;
			}else if (sonoff ==1){
				$("#sch").css("background", "").css("color", "");
				sonoff = 0;
			}
		});
		

		//퀵바 토글 - 퀵바 고정위치를 클릭시마다 바뀌게 하면서 trasition효과
		var onoff = 0;
		$("#qBtn").click(function(){
			if(onoff == 1){
				$("#quick_bar").css("right","-122px").css("transition","all 0.5s");
				$("#qBtn").css("right","-14px").css("transition","all 0.5s");
				onoff = 0;
			}else if(onoff == 0){
				$("#quick_bar").css("right","0").css("transition","all 0.5s");
				$("#qBtn").css("right","106px").css("transition","all 0.5s");
				onoff = 1;
			};
		});
	});
  </script>
  <style type="text/css">
	body {
		min-width : 240px;
   }
	div { 
	text-align : center;
	vertical-align:middle;
	}

	/* 기본메뉴(최상단) */
	nav#topMenu {
            height: 30px;
			width: 100%; 
			background-color: yellow;  /*메인 메뉴 색깔 fc3*/
			padding-right : 2%;
			max-width: 100%;
    }
    #topMenu ul {
        list-style-type: none;
        padding: 0px;
		margin : 0;
		
    }
    #topMenu ul li {           
        background-color: yellow;  
        float: right;
        line-height: 30px;
		padding : 0 5px;
        text-align: center;
    }
    .menuLink {
        color : black;
		text-decoration: none;
    }
	.topMenuLi a{
		BORDER-LEFT : 1px solid black;
		padding-left : 10px;
    }
	@media all and (max-width: 1000px){
		
	}
	@media all and (max-width: 750px){
		.topMenuLi a{
			font-size : 9pt;
			line-height : 25px;
		}
	}
	@media all and (max-width: 300px){
		.topMenuLi a{
			font-size : 3pt;
			line-height : 25px;
		}
	}

    .topMenuLi:hover .menuLink {
        color: red;
    }
	/*------------------- 최상단 메뉴 끝 -----------*/

	#banner {
		margin : 10px auto;
	}
	/*상단 배너 크기*/
	#banner a img {
	 max-width:100%;
	 max-height:100px;
	 border:0;
	}
	/*-------------- 퀵바 ----------------------*/
	#quick_bar {
		width: 120px;
		border: 1px solid yellow;
		background: #feffd0;
		background: white;
		z-index: 9999;
		position: fixed;
		right: -122px;
	}
	
	#qBtn {
		position: fixed;
		right: -14px;
		z-index: 9999;
		display: block;
		border: 1px solid #ffcc00;
		transform: rotate(270deg);
		background: yellow;
		font-size: 12pt;
	}
	
	#quick_bar a {
		padding: 16px;
		display: block;
		transition: all 0.3s ease;
		font-size: 15px;
		position: relative;
	}
	
	#quick_bar #cart_list {
		display: none;
	}
	
	#quick_bar #cart_list table {
		margin: 3px auto;
	} 	
/* 	#quick_bar #recent_list table {
		margin: 3px auto;
	} */
	/*퀵바 내 칸당 크기 조절-----------------------------------0925*/
	#quick_bar #recent_list .ritem{
		width : 90px;
		height : 90px;
		border : 1px solid black;
		padding : 0;
		margin : 1px auto;
	}
	#quick_bar #recent_list .ritem img{
		width : 100%;
		height : 100%;
		margin : 0 auto;
		padding : 0;
	}
	#quick_bar #recent_list .ritem a{
		margin : 0;
		padding : 0;
	}
	/*=============------------------------------------*/
	#quick_bar .btn {
		width: 100%;
	}
	
	#quick_bar .btn:focus, #quick_bar .btn:hover, #quick_bar .btn:active:focus,
		#quick_bar .btn.active:focus, #quick_bar .btn.focus, #quick_bar .btn:active.focus,
		#quick_bar .btn.active.focus {
		background: white;
	}
	/* 카테고리 ~ item창까지------------------------*/
	#wrapper{
		margin: 0 auto;
		padding : 0;
		max-width : 1000px;
	}
	#fix_menu {
		width : 100%;		
		z-index : 9990;
	}
	#fix_menu #category	{
		width : 100%;
		height : 50px;
		background : #ffff00;
	}
	/* 메뉴구현 */
	.navi {
	list-style-type : none;
	padding : 0;
	margin : 0;
	}

	.navi li {
		float : left;
		position : relative;
		padding : 0;
		line-height : 40px;
		width : 20%;
		background : rgba(255,255,0, 0.5);
	}

	.navi li a {
		display : block;
		font-weight:900;
		font-size : 20px;
		padding : 5px 25px;
		color : black;
		text-decoration : none;
	}
	/* 미디어쿼리 */
	@media all and (max-width: 1000px){
		.navi li a {
			font-size : 20px;
			padding : 5px 20px;
		}
	}

	@media all and (max-width: 750px){
		.navi li a {
			font-size : 15px;
			padding : 5px 0px;
		}
	}

	@media all and (max-width: 300px){
		.navi li a {
			font-size : 15px;
			padding : 1px 0px;
		}
		.navi li {
		line-height : 50px;
		}
	}

	.navi li a:hover {
		color : #fff;
		background : red;
	}

	.navi li ul {
		opacity : 0;
		position : absolute;
		left : 0;
		width : 100%;
		min-width : 102px;
		/*background : red;*/
		list-style-type : none;
		padding : 0;
		margin : 0;

		border : 1px solid red;
	}
	.navi li:hover ul {
		opacity : 1;
	}
	.navi li ul li {
		float : none;
		height : 0;
		line-height : 0;
		background : none;
		width : 100%;
		position : relative;
		top : -10px;
	}
	.navi li:hover ul li{
		height : auto;
		line-height : 30px;
		padding : 0;
		position : relative;
		top : 0;
	}
	.navi li ul li a {
		background : white;
		
		font-weight : 900;
		font-size : 15px;
		color : #ff0000;
		min-width : 100px;
	}
	.navi li { 
		/*나타날때*/
		transition : all 0.1s;
		-webkit-transition : all 0.1s;
	}
	.navi li a {
		transition : all 0.2s;
		-webkit-transition : all 0.2s;
	}
	.navi li ul {
		/*사라질 때*/
		transition : all 0.1s;
		-webkit-transition : all 0.1s;
	}
	.navi li ul li {
		transition : all 0.2s;
		-webkit-transition : all 0.2s;
	}
	/* 검색 ---------------------------------------------*/
	#fix_menu #searchbox {
		border: 1px solid red;
		background : white;
		text-align : center;
		vertical-align : middle;
		padding : 5px;
		display : none;
		/*처음 시작시 안보이게*/
	}
	#fix_menu #searchbox #search {
		border : 0;
		BORDER-BOTTOM:1px solid #ffe217;
		BORDER-BOTTOM:1px solid red;
		text-align : center;
		width : 300px;
		height : 20px;
	}
	 @media all and (max-width: 750px){
		#fix_menu #searchbox #search {
			width : 230px;
		}
	 }
	@media all and (max-width: 300px){
		#fix_menu #searchbox #search {
			width : 180px;
		}
	}
	#fix_menu #sch:hover {
		cursor : pointer;
	}
	

	/* 정렬---------------------------------------------------*/
	#fix_menu #sort {
		width : auto;
		padding : 1px;
		background : white;
		BORDER-BOTTOM : 1px solid yellow;
		text-align : right;
		margin-bottom : 5px;
		
	}
	#fix_menu #sort a{
		text-decoration : none;
		color : black;
		font-size : 10pt;
	}
	#fix_menu #sort a:hover{
		text-decoration : underline;
	}
	/* 로그인 */
	div#loginDiv{
		text-align : left;
		width : 200pt;
		margin : 0 auto;
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

	/* 푸터 */
	footer {
		BORDER-TOP : 1px solid gray;
		BORDER-BOTTOM : 1px solid gray;
		padding-top : 10px;
		padding-bottom :10px;

		width : 100%;
		height : 150px;

		display : table;
		/* 세로 가운데 정렬을 위한. */
	}
	footer #fwrap{
		display : table-cell;
		vertical-align : middle;
		text-align : center;
	}
	.fd {
		display : inline-block;
		text-align : left;
		padding : 0 20px;
	}

	@media all and (max-width: 300px){
		.fd h1{
			font-size : 20pt;
		}
	}

	#fmenu {
		list-style-type : none;
	}
	.footMenu a {
		text-decoration : none;
		color : black;
	}
	.footMenu a:hover {
		text-decoration : underline;
	}

  </style>
  
 </head>
 <body>
<!--  최상단 기본메뉴 -->
 <div id = "top_menu">
   <nav id="topMenu" >
        <ul>
				<li class="topMenuLi"><a class="menuLink" href="nlist">고객센터</a></li>
	            <li class="topMenuLi"><a class="menuLink" onClick="nologinCart()">장바구니</a></li>
	            <li class="topMenuLi"><a class="menuLink" href="/arm/member/MemberJoin.jsp">회원가입</a></li>
	            <li class="topMenuLi"><a class="menuLink" href="/arm/member/Login.jsp">로그인</a></li>
        </ul>
	</nav>
 
 </div>
	<!-- 퀵바 -->
	<button id="qBtn" class="hidden-xs">Quick</button>
	<div id="quick_bar" class="hidden-xs">
		<button class="btn btn-default">
			<span class="glyphicon glyphicon-user"></span> MY PAGE
		</button>
		<!-- 그냥 장바구니 페이지로 이동하도록. -->
		<button id="cart" class="btn btn-default">
			<span class="glyphicon glyphicon-shopping-cart"></span> 장바구니 &nbsp;
		</button><br>
		<button id="recent" class="btn btn-default">최근 본 상품</button>
		<div id="recent_list">
			<!-- 동적으로 추가됨 -->
		</div>
	</div>
<!-- 배너 -->
 <div id ="banner">
	<!-- 배너클릭시 시작페이지로! -->
	<a href="/arm/mainlist"><img src="/arm/img/banner.png" alt = "시작페이지로"></a>
 </div>
<!-- 카테고리 ~ item 목록 -->
 <div id="wrapper">

 	<div id = "fix_menu">
			<div id="category">
				<ul class="navi">
					<li><a href="/arm/catlist?categoryno=100">손</a>
					<!-- 100 -->
						<ul>
							<li><a href="/arm/catlist?categoryno=110">반지</a></li>
							<li><a href="/arm/catlist?categoryno=120">의료/건강</a></li>
						</ul></li>
					<!-- 손 -->

					<li><a href="/arm/catlist?categoryno=200">손목</a>
					<!-- 200 -->
						<ul>
							<li><a href="/arm/catlist?categoryno=210">팔찌/시계</a></li>
							<li><a href="/arm/catlist?categoryno=220">의료/건강</a></li>
						</ul></li>
					<!-- 손목 -->
					<li><a href="/arm/catlist?categoryno=300">팔목</a>
					<!-- 300 -->
						<ul>
							<li><a href="/arm/catlist?categoryno=310">팔찌/시계</a></li>
							<li><a href="/arm/catlist?categoryno=320">의료/건강</a></li>
						</ul></li>
					<!-- 팔목 -->
					<li><a href="/arm/catlist?categoryno=400">어깨</a>
					<!-- 400 -->
						<ul>
							<li><a href="/arm/catlist?categoryno=410">의류</a></li>
							<li><a href="/arm/catlist?categoryno=420">의료/건강</a></li>
						</ul></li>
					<!-- 어깨 -->

					<li><a id="sch">검색</a></li>
				</ul>
			</div><!-- 카테고리 -->
	<div id = "searchbox">
	<form>
	<input type="text" id = "search" name = "search" placeholder = "검색하세요!">&nbsp;&nbsp;<input type="image" id = "schBtn" src = "/arm/img/search2_small.png" width ="25px" height = "25px";>
	</form>
	</div><!-- 검색 -->

	<div id = "sort">
	<a href="#">인기도순</a>&nbsp;&nbsp;
	<a href="#">가격높은순</a>&nbsp;&nbsp;
	<a href="#">가격낮은순</a>&nbsp;&nbsp;
	</div><!-- sort -->
	
	</div><!-- fix_menu(카테고리+검색+정렬) -->

    <div class="contents">
    <h1>로 그 인</h1>
    <% if(msg != null){ %>
    <span style = "text-align:center; color : red; font-size:9pt;"><%= msg %></span>
    <% } %>
	<div id = "loginDiv" class="form">
    <form action = "/arm/login" method="post">
	<table id = "loginTb" border = "0">
	<tr><td>
      <input type="text" style="width:200pt; height:30pt" name = "userid" placeholder="아 이 디"/>
	  </td></tr>
	<tr><td>
      <input type="password" style="width:200pt; height:30pt" name = "userpwd" placeholder="비 밀 번 호"/><br>
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
	
	  <input id = "join_btn" type="button" style="width: 200pt; height:30pt" value="회원가입" onClick="self.location='MemberJoin.jsp';">
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

    </div><!-- contents-->


	</div><!-- fix+item_list -->
	
	<!-- top버튼 -->
	<div style="position:fixed; bottom:10px; right:10px; z-index : 9999;">
	 <a href="#top"><img src="/arm/img/top3.png" width="51" height="51" border="0" title="위로 이동"></a> <!-- 위에있는 이름 top에 있는 위치로 이동함 -->
	</div>

	<!-- 푸터 -->
	<footer>
	<div id = "fwrap">
	<div class = "fd hidden-xs"><!-- 스마트폰 크기에서는 안보이게 -->
		<ul id="fmenu">
				<li class="footMenu"><a href="#">GUIDE</a></li>
				<li class="footMenu"><a href="#">CUSTOMER SERVICE</a></li>
				<li class="footMenu"><a href="#">BANK INFO</a></li>
				<li class="footMenu"><a href="#">DELIVERY</a></li>
		</ul>
		</div>
		

		<div class = "fd">
		<h1><img src="images/전화기.png" width="50" height="40" border="0" alt="">&nbsp;1600-7000</h1>
		</div>

		<div class = "fd">
		팔로 Follow Me <br>
		copyright by take ARM<br>
		All right reserved<br>
		</div>
		
	</div>
	</footer>
 </body>
</html>
    