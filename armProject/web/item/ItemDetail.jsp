<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "member.model.vo.User" %>
<%
User loginUser = (User)session.getAttribute("loginUser");
%>
<!doctype html>
<html lang="ko">
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>팔로 Follow Me</title>

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
	$(function(){

		//스크롤시 카테고리고정
		var menupos = $("#fix_menu").offset().top;
		$(window).scroll(function(){
			if($(window).scrollTop() >= menupos){
				$("#fix_menu").css("position","fixed").css("top","0");
				$("#fix_menu").width($("#wrapper").width());
				$("body").css("position","relative").css("top","70px");
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
		
		//퀵바 장바구니, 최근 본 목록 슬라이드 처리
		$("#recent").click(function(){
			$("#recent_list").slideDown("fast");
			$("#cart_list").slideUp("fast");
		});
		$("#cart").click(function(){
			$("#recent_list").slideUp("fast");
			$("#cart_list").slideDown("fast");
		});

		
		/*탭 기능용 소스*/
		$(".tab_content").hide();
		$(".tab_content:first").show();

		$("ul.tabs li").click(function () {
			$("ul.tabs li").removeClass("active").css("color", "#333");
			$(this).addClass("active").css("color", "darkred");
			$(".tab_content").hide()
			var activeTab = $(this).attr("rel");
			$("#" + activeTab).fadeIn()
		});

		/*별점용*/
		$(".star_point a").click(function() {
			$(this).nextAll(this).removeClass("on");
			$(this).addClass("on").prevAll("a").addClass("on");
			
			return false;			
		});

		/*별점에 따른 코멘트 출력용 ---매번 클릭 시마다 멘트 바뀌도록 수정해야*/
		$(".star_point a").click(function(){
			$(".comment").text();
			var star_num = $(".star_point .on").length;
			var star_comment = "";

			if(star_num == 1){
				star_comment = "ㅁ_ㅁ";
			}else if(star_num == 2){
				star_comment = "ㅋ?";
			}else if(star_num == 3){
				star_comment = "빼앰";
			}else if(star_num == 4){
				star_comment = "빼애앰";
			}else if(star_num == 5){
				star_comment = "와우내빼애앰";
			}
			$(".comment").text(star_comment);
		});

		/*버튼 클릭 시 선택 옵션 삭제*/
		$(document).on('click', '.remove_order', function (){
			$(this).parent().parent().remove();
		});


		/*옵션 선택시 테이블에 행 추가 버전2*/ 
		$('select.p_opt_2').change(function(){
			var opt1 = $('.p_opt_1 option:selected').text();
			var opt2 = $('.p_opt_2 option:selected').text();
			var new_td = opt1 + " " + opt2;

			if(opt1 != null && opt2 != null){
				var html = "<tr><td>" + new_td + 
				"</td><td><input type='number' class='Qty' name='Qty' min='1' width='10' value='1'>" 
				+ "</td><td><button class='remove_order'><img src ='/arm/img/delete.png'></button>" + "</td></tr>";

				$('.p_selection').append(html);
				$('.p_selection button').attr('class', 'remove_order');

			}else{
				alert("옵션을 모두 선택하세요");
			}
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

	/*------------------- 배너-----------*/
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
		width : 120px;
		height : auto;
		border : 1px solid yellow;
		background : #feffd0;
		background : white;
		z-index : 9999;
		position : fixed;
		right : -122px;
		top : 170px;
	}
	#qBtn {
		position:fixed;
		right : -14px;
		bottom : 310px;
		z-index : 9999;
		display : block;
		border : 1px solid #ffcc00;
		transform : rotate(270deg);
		background : yellow;
		font-size : 12pt;
	}
	#quick_bar a {
		padding: 16px;
		display: block;
		transition: all 0.3s ease;
		font-size: 15px;
		position : relative;
	}
	#quick_bar #cart_list{
		display : none;
	}
	#quick_bar #cart_list table{
		margin : 3px auto;
	}
	#quick_bar #recent_list table {
		margin : 3px auto;
	}
	#quick_bar .btn {
		width : 100%;
	}
	#quick_bar .btn:focus,
	#quick_bar .btn:hover,
	#quick_bar .btn:active:focus,
	#quick_bar .btn.active:focus,
	#quick_bar .btn.focus,
	#quick_bar .btn:active.focus,
	#quick_bar .btn.active.focus {
		background : white;
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
		background : red;
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
		top : -15px;
	}
	.navi li:hover ul li{
		height : auto;
		line-height : 30px;
		padding : 0;
		position : relative;
		top : 0px;
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
	
	/* 상단 메뉴 아래 현재 카테고리 위치 표기*/
	#fix_menu #category_detail {
		width : auto;
		padding : 1px;
		background : orange;
		BORDER-BOTTOM : 1px solid yellow;
		text-align : left;
		margin-bottom : 5px;
		
	}
	#fix_menu #sort a{
		text-decoration : none;
		color : black;
		font-size : 10pt;
	}
	#fix_menu #sort a:hover{
		text-decoration : none;
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


	/*상품 정보 출력 화면용------------------------------------------------*/
	.product {
		text-align: center;
		margin : 0px auto;
		top : 150px;
		min-width : 102px;
	}

	.pImage, .pTable {
		border : 1px solid red;	
		float : left;
		/*height : 600px*/;
		width : 50%;	
		/*margin-bottom : 50px;*/
		min-width : 102px;
		padding : 1%;
	}

	.pImage img {
		min-width : 102px;
		width : 100%;
		/*height : 600px*/;
	}

	.product .Qty {
		width : 50px;
	}

	.product input[type="text"]{
		border : 0px;
		text-align: right;
	}
	.p_selection{
		width : 95%;
	}
	.p_selection button{
		background : none;
		border : none;
	}
	.p_selection button img{
		height : 15px;
		width : 15px;
	}

	/* 미디어쿼리 */
	@media all and (max-width: 1000px){
		.pImage, .pTable {
			border : 1px solid red;	
			float : left;
			/*height : 300px;*/
			width : 50%;	
			margin-bottom : 20px;
			min-width : 102px;
		}
		.pImage img {
			min-width : 102px;
			width : 100%;
		}
	}

	@media all and (max-width: 750px){
		.pImage, .pTable {
			border : 1px solid red;	
			float : left;
			/*height : 300px;*/
			width : 100%;	
			margin-bottom : 20px;
			
		}

		.pImage img {
			min-width : 102px;
			width : 100%;
		}
	}
	
	@media all and (max-width: 300px){
		.pImage, .pTable {
			width :100%;	
			margin-bottom : 20px;
			min-width : 102px;
		}
	}
	
	/*상세 탭메뉴용 스타일*/
	#tab_wrapper {
		margin: 0 auto;
		max-width : 1000px;
		height : auto;
	}

	.tabArea {
		top: 70px;
		text-align: center;
		margin : 0 auto;
		width : 100%;
	}

	ul.tabs {
		margin: 0;
		padding: 0;
		float: left;
		list-style: none;
		height: 40px;
		border-bottom: 1px solid #eee;
		border-left: 1px solid #eee;
		font-family:"dotum";
		font-size:12px;
		min-width : 102px;
	}

	ul.tabs li {
		float: left;
		text-align:center;
		cursor: pointer;
		width: 200px;
		height: 40px;
		line-height: 40px;
		border: 1px solid #eee;
		border-left: none;
		font-weight: bold;
		background: #fafafa;
		overflow: hidden;
	}

	ul.tabs li.active {
		background: #ff9933;
		border-bottom: 1px solid #FFFFFF;
	}

	.tab_container {
		border: 1px solid #eee;
		border-top: none;
		clear: both;
		float: left;
		width : 100%;
		background: #FFFFFF;
	}

	.tab_content {
		padding: 10px;
		font-size: 20px;
		display: none;
	}

	.tab_container .tab_content ul {
		width:100%;
		margin:0px;
		padding:0px;
	}

	.tab_container .tab_content ul li {
		padding: 5px;
		list-style: none;
	}


	/*미디어쿼리*/
	@media all and (max-width: 750px){
		ul.tabs li {
			float: left;
			text-align:center;
			cursor: pointer;
			width: 85px;
			height: 30px;
			line-height: 30px;
			border: 1px solid #eee;
			border-left: none;
			background: #fafafa;
			overflow: hidden;
		}

		ul.tabs li a {
			font-size : 9px;
			padding : 0px;
			margin : 0px;
		}
	}


	@media all and (max-width: 300px){

		ul.tabs {
			margin: 0;
			padding: 0;
			float: left;
			list-style: none;
			height: 30px;
			border-bottom: 1px solid #eee;
			border-left: 1px solid #eee;
			font-family:"dotum";
			font-size: 10px;
		}

		ul.tabs li {
			float: left;
			text-align:center;
			cursor: pointer;
			width: 55px;
			height: 30px;
			line-height: 30px;
			border: 1px solid #eee;
			border-left: none;
			background: #fafafa;
			overflow: hidden;
		}

			ul.tabs li a {
			font-size : 8px;
			padding : 0px;
			margin: 0px;
		}
	}


	/*문의, 후기 공통 적용*/
	.inquiry_input, .review_input, .p_Q, .p_A, .p_review {
		border : 1px solid red;
		padding : 2%;
		width: 90%;
		height: 100%;
	}

	.inquiry_input table, .review_input table, .loaded_qna table, .p_reivew table {
		width : 100%;
		height : 80%;
		border : 1px solid red;
	}
	
	.tab_content input[type=submit] {
		width : 80%;
		height : 80%;
	}

	.tab_content textarea {
    display: block;
    width: 100%;
    -webkit-box-sizing: border-box;
       -moz-box-sizing: border-box;
            box-sizing: border-box;
	}

	.tab_content input[type=text] {
		border : none;
	}

	.tab_content #td1 {
		width : 90%;
	}

    /*테이블 반응형으로*/
	@media all and ( max-width : 640px ) {
		#qna_table,
		#qna_table thead
		#qna_table tbody,
		#qna_table tr,
		#qna_table th,
		#qna_table td {
			display : block;
		}

		#qna_table tr {
			border-bottom: 1px solid #ddd;
		}

		#qna_table th,
		#qna_table td {
			border-top: none;
			border-bottom: none;
		}
	}


	
	/*상품 문의 부분*/
	.p_A {
		position : relative;
		left : 100px;
	}
	
	.loaded_qna #loaded_td1 {
		width : 5%;	
	}

	.loaded_qna #loaded_td2 {
		width : 15%;	
	}


	/*상품 후기 부분*/
	.star_point {
		font-size: 0;
		letter-spacing: -4px;
	}

	.star_point a {
		font-size : 20px;
		letter-spacing: 0;
		display : inline-block;
		margin-left: 5px;
		color : #ccc;
		text-decoration : none;
	}

	.star_point a : first-child {
		margin-left : 0;
	}

	.star_point a.on {
		color : #ffcc00; 
	}
	
	.p_review #review_td1 {
		width : 5%;
	}

	.p_review #review_td2 {
		width : 25%;
	}

	 /*테이블 반응형으로*/
	@media all and ( max-width : 640px ) {
		#r_table,
		#r_table thead
		#r_table tbody,
		#r_table tr,
		#r_table th,
		#r_table td {
			display : block;
		}

		#r_table tr {
			border-bottom: 1px solid #ddd;
		}

		#r_table th,
		#r_table td {
			border-top: none;
			border-bottom: none;
		}
	}
	table tr td{/*확인용*/
		border : 1px solid orange;
	}


  </style>
  
 </head>
 <body>
<!--  최상단 기본메뉴 -->
 <div id = "top_menu">
	   	<nav id="topMenu" >
	        <ul>
	         <li class="topMenuLi"><a class="menuLink" href="nlist">고객센터</a></li>       
	      <% if(loginUser != null){ %>
	         <li class="topMenuLi"><a class="menuLink" href="/arm/mypage/MyinfoCart.jsp">장바구니</a></li>
	         <li class="topMenuLi"><a class="menuLink" href="/arm/mypage/MyinfoCart.jsp">MyPage</a></li>
	         <li class="topMenuLi"><a class="menuLink" href="logout">로그아웃</a></li>
	         <li class="topMenuLi">환영합니다! <%=loginUser.getUserName() %>님</li>
	      <%}else{ %>
	         <li class="topMenuLi"><a class="menuLink" onclick="nologinCart();">장바구니</a></li>
	         <li class="topMenuLi"><a class="menuLink" href="/arm/member/MemberJoin.jsp">회원가입</a></li>
	         <li class="topMenuLi"><a class="menuLink" href="/arm/member/Login.jsp">로그인</a></li>
	      <%} %>   
	        </ul>
	   </nav>
 	</div>
<!-- 퀵바 -->
 <button id = "qBtn" class = "hidden-xs">Quick</button>
 <div id = "quick_bar" class = "hidden-xs">
	<button class="btn btn-default"><span class="glyphicon glyphicon-user"></span> MY PAGE </button>
	<!-- 그냥 장바구니 페이지로 이동하도록. -->
	<button id = "cart" class="btn btn-default"><span class="glyphicon glyphicon-shopping-cart"></span> 장바구니 &nbsp;</button><br>
		<div id = "cart_list">
			<table cellpadding = "0" cellspacing = "0" border = "1px">
			<tr>
				<td><a href="#">이미지1</a></td>
			</tr>
			<tr>
				<td><a href="#">이미지2</a></td>
			</tr>
			<tr>
				<td><a href="#">이미지3</a></td>
			</tr>
			</table>
		</div>
	<button id = "recent" class="btn btn-default">최근 본 상품</button>
	<div id = "recent_list">
		<table cellpadding = "0" cellspacing = "0" border = "1px">
		<tr>
			<td><a href="#">이미지1</a></td>
		</tr>
		<tr>
			<td><a href="#">이미지2</a></td>
		</tr>
		<tr>
			<td><a href="#">이미지3</a></td>
		</tr>
		</table>
	</div>
	<button>◀</button> 1/5 <button>▶</button>
 </div>
<!-- 배너 -->
 <div id ="banner">
	<!-- 배너클릭시 시작페이지로! -->
	<a href="/arm/mainlist"><img src="/arm/img/banner.png" alt = "시작페이지로"></a>
 </div>
<!-- 카테고리 ~ item 목록 -->
 <div id="wrapper">

 	<div id = "fix_menu">
	<div id ="category">
		<ul class = "navi">
			<li><a href ="">손</a>
				<ul>
					<li><a href ="">반지</a></li>
					<li><a href ="">의료/건강</a></li>
				</ul>
			</li><!-- 손 -->

			<li><a href ="">손목</a>
				<ul>
					<li><a href ="">팔찌/시계</a></li>
					<li><a href ="">의료/건강</a></li>
				</ul>
			</li><!-- 손목 -->
			<li><a href ="">팔목</a>
				<ul>
					<li><a href ="">팔찌/시계</a></li>
					<li><a href ="">의료/건강</a></li>
				</ul>
			</li><!-- 팔목 -->
			<li><a href ="">어깨</a>
				<ul>
					<li><a href ="">의류</a></li>
					<li><a href ="">의료/건강</a></li>
				</ul>
			</li><!-- 어깨 -->

			<li><a id = "sch">검색</a></li>
		</ul>
	</div><!-- 카테고리 -->
	<div id = "searchbox">
		<form action="/arm/isearch" method="post">
			<input type="text" id="search" name="keyword" placeholder="검색하세요!">&nbsp;&nbsp;
			<input type="image" id="schBtn" src="/arm/img/search2_small.png"
				width="25px" height="25px">
		</form>
	</div>

	<div id="category_detail">
		<a href="#">홈</a> &nbsp;> &nbsp;
		<a href="#">카테고리</a> &nbsp;> &nbsp;
		<a href="#">상세분류</a>
	</div>
	</div><!-- fix_menu(카테고리+검색+정렬) -->
	
	<!--상품 상세 설명 페이지 시작-->
	<div class="content">
		<div class="product">
			<form method="post" action="장바구니 jsp로 이동하게">
			<input type="hidden" name="pId" value="상품 아이디">
			<div class="pImage">
				<img src="images/good.gif">
			</div>
			<!--pImage-->

			<div class="pTable">
			
			<table>
			<tr height="50">
				<td width="200">상품명 : </td>
				<td id="pName" width="300">
					<input type="text" name="pName" value="상품명" readonly>
				</td>
			</tr>
			</table>
			<hr>
			<table>
			<tr height="40">
				<td width="200">가격 : </td>
				<td id="pPrice" width="300">
					<input type="text" name="pPrice" value="상품가격" readonly>
				</td>
			</tr>
			<tr>
				<td>배송비 : </td>
				<td id="shippingCost" align="right">2500</td>
			</tr>
			</table>
			<br>

			<table>
			<tr height="40">
				<td width="200">옵션1 : </td>
				<td id="opt1" width="300">
					<select name="p_opt_1" class="p_opt_1" style = "width : 95%;">
						<option value="" selected> -------
						<option value="p_opt_1-1"> 첫번째 옵션
						<option value="p_opt_1-2"> 두번째 옵션
						<option value="p_opt_1-3"> 세번째 옵션
						<option value="p_opt_1-4"> 네번째 옵션
					</select>
				</td>
			</tr>
			<tr height="40">
				<td>옵션2: </td>
				<td id="opt2">
					<select name="p_opt_2" class="p_opt_2" style = "width : 95%;">
						<option value="" selected> -------
						<option value="p_opt_2-1"> 2의 첫번째 옵션
						<option value="p_opt_2-2" > 2의 두번째 옵션
						<option value="p_opt_2-3" > 2의 세번째 옵션
					</select>
				</td>
			</tr>
			<tr height="60">
				<td colspan="2">
					<div style="width:100%; height:80px; overflow:auto">
					<table class="p_selection" align="center">
						<!--옵션 선택 시 동적으로 행 추가되는 부분-->
					</table>
					</div><!--주문목록 길어질 경우 스크롤 달아주려고 만든 div-->
			</tr>
			<tr height="60">
				<td>총금액: </td>
				<td align="center">
					<input type="text" name="">
				</td>
			</tr>
			<tr height="30">
				<td colspan="2" height="70" align="center" style = "padding-left : 5%; padding-right : 5%;">
					<input type="submit" value="장바구니"
					 style = "color : white; background : green; border : 1px solid green; width : 45%; height : 40px; font-size : 1.2em; float : left;">
					<input type="submit" value="바로 구매하기" onclick="form.action='주문화면 보여주는 jsp'"
					style = "color : white; background : red; border : 1px solid red; width : 45%; height : 40px; font-size : 1.2em; float : right;">
				</td>
			</tr>
			</table>
			</div>
			<!--pTable-->
			</form>
		</div>
		<!--product-->

 <!--탭영역 시작-->
 <div id="tab_wrapper">
 <div class="tabArea">
    <ul class="tabs">
        <li class="active" rel="tab1">상세보기</li>
        <li rel="tab2">주의사항</li>
        <li rel="tab3">상품문의</li>
		<li rel="tab4">후기/리뷰</li>
    </ul>
    <div class="tab_container">
        <div id="tab1" class="tab_content">
			<img src="items_detail/01.jpg">			
        </div>
        <!-- #tab1 -->
        <div id="tab2" class="tab_content">
			<img src="images/caution.jpg">
		</div>
        <!-- #tab2 -->
        <div id="tab3" class="tab_content">
			<div class="inquiry_input" align="left">
				<table>
					<tr>
						<td id="td1">
							<textarea name="p_inquiry" id="p_inquiry" placeholder="로그인한 사람만 문의내용ㄱㄱㄱ"></textarea>
						</td>
						<td>
							&nbsp;<input type="submit" value="확인" class="btn btn-success">
						</td>
					</tr>
				</table> 
			</div>
			<hr>
			<br>

			<div class="loaded_qna">
				<div class="p_Q">
					<table border="1px solid gray" id="qna_table">
						<tr>
							<td id="loaded_td1"><input type="text" name="qna_category" value="[질문]" readonly></td>
							<td id="loaded_td2"><input type="text" name="qna_ID" value="작성자 ID" readonly></td>
							<td><input type="text" name="q_date" value="작성일자" readonly></td>
						</tr>
						<tr>
							<td colspan="3"><textarea name="q_content" rows="" cols="">문의</textarea></td>
						</tr>
					</table>
				</div><!--p_Q-->
				<br>
				<div class="p_A">
					<table border="1px solid gray" id="qna_table">
						<tr>
							<td id="loaded_td1"><input type="text" name="qna_category" value="[답변]" readonly></td>
							<td id="loaded_td2"><input type="text" name="a_ID" value="답변자 ID" readonly></td>
							<td><input type="text" name="a_Date" value="답변일자" readonly></td>
						</tr>
						<tr>
							<td colspan="3"><textarea name="a_content" rows="" cols="">답변</textarea></td>
						</tr>
					</table>
				</div>
				<br>
			</div>
			<!--loaded_qna-->
		</div>
        <!-- #tab3 -->
		<div id="tab4" class="tab_content">
			<div class="review_input">
				<table>
					<tr>
						<td align="left">
							<p class="star_point">
							<a href="#" class="on">★</a>
							<a href="#" class="on">★</a>
							<a href="#" class="on">★</a>
							<a href="#">★</a>
							<a href="#">★</a>
							</p>

						</td>
						<td align="left">
							<p class="comment"></p>
						</td>
					</tr>
				</table>
				<table>
					<tr>
						<td>
							<textarea name="p_review_input" id="p_review_input" placeholder="후기후기해"></textarea>
						</td>
						<td>
							&nbsp;<input type="submit" value="확인" style = "background : Yellow; border : 1px solid yellow; border-radius:5px; ">
						</td>
					</tr>
				</table>
			</div>
			<!--review_input 끝-->
			<hr>
			<br>
			
			<div class="p_review">
				<table border="1px solid gray" id="r_table">
					<tr>
						<td id="review_td1"><input type="text" name="review_id" value="작성자 id" readonly></td>
						<td id="review_td2"><input type="text" name="review_star" value="★★★" readonly style = "color:#ffcc00;"></td>
						<td><input type="text" name="review_date" value="작성일자" readonly></td>
					</tr>
					<tr>
						<td colspan="3"><textarea name="review_content" rows="" cols="">후기 </textarea></td>
					</tr>
				</table>
				<br>
			</div><!--p_review-->
		</div>
    </div>
    <!-- .tab_container -->
   </div><!--tabArea-->
   </div><!-- 탭메뉴 영역 끝-->

	</div><!--content-->

	</div><!-- fix+item_list -->
	
	<!-- top버튼 -->
	<div style="position:fixed; bottom:10px; right:10px; z-index : 9999;">
	 <a href="#top"><img src="/arm/img/top3.png" width="51" height="51" border="0" title="위로 이동"></a> <!-- 위에있는 이름 top에 있는 위치로 이동함 -->
	</div><!--top버튼 끝-->

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
