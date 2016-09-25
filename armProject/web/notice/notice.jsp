<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, admin.notice.model.vo.Notice, member.model.vo.User" %>
<%
User loginUser = (User)session.getAttribute("loginUser");
ArrayList<Notice> list = (ArrayList<Notice>)request.getAttribute("list");
%>    
<!doctype html>
<html lang="ko">
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Notice</title>

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
  //고객센터 메뉴 클릭시 보이는 div 처리 (두가지방법)
		function showNotice(){
			$("#notice").show();
			$("#faq").hide();
			$("#direct_q").hide();
		};
		function showFaq(){
			$("#notice").css("display","none");
			$("#faq").css("display","block");
			$("#direct_q").css("display","none");
		};

		function showDq(){
			$("#notice").css("display","none");
			$("#faq").css("display","none");
			$("#direct_q").css("display","block");
		};
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
			$(this).css("color","red"),css("cursor","pointer");
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
		
		//공지글,faq 제목 클릭시 내용 슬라이드
		$(".notice .question").click(function(){
			$(this).next().slideToggle();
		});
		$(".faq .question").click(function(){
			$(this).next().slideToggle();
		});

		$("#no_btn").click(function(){
			$("#no_btn").css("background", "red").css("color","white");
			$("#q_btn").css("background", "").css("color","");
			$("#dq_btn").css("background", "").css("color","");
		});
		$("#q_btn").click(function(){
			$("#no_btn").css("background", "").css("color","");
			$("#q_btn").css("background", "red").css("color","white");
			$("#dq_btn").css("background", "").css("color","");
		});
		$("#dq_btn").click(function(){
			$("#no_btn").css("background", "").css("color","");
			$("#q_btn").css("background", "").css("color","");
			$("#dq_btn").css("background", "red").css("color","white");
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

	.menuLink:hover{
		color : red;
		cursor : pointer;
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

	/*----광고----------------------------------*/

	.adv-img {
		width: 100%; /* 이미지 크기 반응형으로 작성 */
	}

	#ad {
		margin: 5px auto;
		width: 100%;
		max-width: 700px;
	}

	.carousel-indicators {
	  bottom: 2px;
	}
	.carousel-indicators li {
	  width: 11px;
	  height: 11px;
	  border: 2px solid rgba(255, 255, 255, 0.3);
	}
	.carousel-indicators .active {
	  width: 14px;
	  height: 14px;
	  border: 0px;
	  background-color: rgba(255, 255, 255, 0.7);
	}

	/* None:hidden, Hover:visible */
	.carousel .carousel-control{
		visibility: hidden;
	}
	.carousel-indicators{
		visibility: hidden;
	}
	.carousel:hover .carousel-control{
		visibility: visible;
	}
	.carousel:hover .carousel-indicators{
		visibility: visible;
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
/*---------------------------내용 부분------------------------------------ */
	#wrapper{
		margin: 0 auto;
		max-width : 1000px;
		height : auto;
	}
	#cs_menu{
		width:100%;
		height : 50px;
		background : yellow;
		margin : 5px auto;
	}

	/*고객센터 메뉴*/
	.cs_navi{
		list-style-type : none;
		padding : 0;
		margin : 0;
	}
	.cs_navi li {
		float : left;
		width : 33.33%;
		padding : 0;
		position : relative;
		line-height : 30px;
	}
	.cs_navi li a{
		font-size : 20px;
		font-weight:900;
		color : black;
		text-decoration:none;
		padding : 10px;
		display : block;
		
	}
	.cs_navi li a:hover{
		color : white;
		background : rgba(255,0,0,0.8);
		cursor : pointer;
	}
	@media all and (max-width: 1000px){
		.cs_navi li a{
			font-size : 17px;
		}
	}

	@media all and (max-width: 750px){
		.cs_navi li a{
			font-size : 13px;
			padding : 10px 0;
		}	
	}

	@media all and (max-width: 300px){
		.cs_navi li a{
			font-size : 11px;
			padding : 10px 0;
		}	
	}
	
	#contents{
		width :100%;
		min-height : 600px;
		background : #ccff99;
		margin : 5px auto;
		padding : 5px;
	}
	/* 공지사항,이벤트 스타일*/
	.notice {
		margin:0 auto;
		BORDER-TOP: 2px solid black;
		BORDER-BOTTOM: 2px solid black;
		background : white;

		width : 80%;
		min-width : 280px;
	}
	@media all and (max-width: 750px){
		.notice {
			font-size : 8pt;
		}
	}

	.notice tr th, .notice tr td{
		BORDER-BOTTOM: 1px solid #d9d9d9;
		padding : 10px;
	}
	.notice tr th {
		text-align : center;
	}
	.notice tr td:nth-child(3n+1), .notice tr th:nth-child(3n+1){
		background: #ebebeb;
	}

	.notice .question:hover {
		cursor : pointer;
		background : #ebebeb;
	}
	.notice .answer{
		display : none;
	}
	
		/* FAQ(자주묻는질문) 스타일 */
	#faq {
		display : none;
	}
	.faq {
		margin:0 auto;
		BORDER-TOP: 2px solid black;
		BORDER-BOTTOM: 2px solid black;
		background : white;

		width : 80%;
	}
	
	.faq tr th, .faq tr td{
		BORDER-BOTTOM: 1px solid #d9d9d9;
		padding : 10px;
	}
	.faq tr th {
		text-align : center;
	}
	.faq tr td:nth-child(2n+1), .faq tr th:nth-child(2n+1){
		background: #ebebeb;
	}
	.faq .question:hover {
		cursor : pointer;
		background : #ebebeb;
	}
	.faq .answer{
		display : none;
	}
	/*1:1문의 스타일*/
	#direct_q {
		display : none;
	}
	.direct_q {
		margin:0 auto;
		BORDER-TOP: 2px solid black;
		BORDER-BOTTOM: 2px solid black;
		background : white;
		width : 80%;
	}
	.direct_q tr th{
		BORDER-BOTTOM: 1px solid #d9d9d9;
		padding : 10px;
		width : 20%;
	}
	/* 미디어쿼리 이용하여 글자크기 조정 */
	@media all and (max-width: 750px){
		.direct_q tr th{
			font-size : 10pt;
		}
	}

	@media all and (max-width: 300px){
		.direct_q tr th{
			font-size : 3pt;
		}
	
	}
	 .direct_q tr td{
		BORDER-BOTTOM: 1px solid #d9d9d9;
		padding : 10px;
		text-align : left;
	}
	.direct_q tr td:nth-child(2n+1), .direct_q tr th:nth-child(2n+1){
		background: #ebebeb;
	}
	.direct_q select {
		width : 30%;
	}
	input[name*="title"]{
		width : 98%;
	}
	textarea{
		width : 98%;
		height : 200px;
	}
	#direct_q #dqBtn {
		background : red;
		border :1px solid red;
		color : white;
		font-size : 12pt;
	}
	@media all and (max-width: 1000px){
		#wrapper{
			font-size :
		}
	}

	 @media all and (max-width: 750px){}

	@media all and (max-width: 300px){
		#wrapper h1{
			font-size : 20pt
		}
	}

	
/*---------------------------내용 부분 끝--------------------------------- */
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
 <!-- 최상단 기본메뉴 -->
	<div id = "top_menu">
	   	<nav id="topMenu" >
	        <ul>
	         <li class="topMenuLi"><a class="menuLink" href="nlist">고객센터</a></li>       
	      <% if(loginUser != null){ %>
	         <li class="topMenuLi"><a class="menuLink" href="/arm/mypage/MyinfoCart.jsp">장바구니</a></li>
	         <li class="topMenuLi"><a class="menuLink" href="/arm/mypage/MyinfoCart.jsp">MyPage</a></li>
	         <li class="topMenuLi"><a class="menuLink" href="logout">로그아웃</a></li>
	         <li class="topMenuLi"><a class="menuLink" >환영합니다! <%=loginUser.getUserName() %>님</a></li>
	      <%}else{ %>
	         <li class="topMenuLi"><a class="menuLink" onClick="nologinCart()">장바구니</a></li>
	         <li class="topMenuLi"><a class="menuLink" href="/arm/member/MemberJoin.jsp">회원가입</a></li>
	         <li class="topMenuLi"><a class="menuLink" href="/arm/member/Login.jsp">로그인</a></li>
	      <%} %>   
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
<!-- ---------------------------내용 부분------------------------------------ -->
<div id="wrapper">
	<div id = "cs_menu">
		<ul class = "cs_navi">
			<li><a onclick="showNotice();" id = "no_btn">공지사항/이벤트</a></li>
			<li><a onclick="showFaq();" id = "q_btn">자주 묻는 질문</a></li>
			<li><a onclick="showDq();" id = "dq_btn">1:1 문의</a></li>
		</ul>
	</div><!-- cs_menu -->

	<div id = "contents">
		<div id = "notice">
		<h1>공지사항/이벤트</h1>
		<table class = "notice" cellspacing ="0">
		<tr>
			<th width = "10%">No.</th><th>공지사항/이벤트</th><th width = "15%">작성일</th>
		</tr>
		<%
			for(Notice n:list){
		%>
		<tr class = "question"><td><%=n.getNoticeNo() %></td><td><%=n.getNoticeTitle() %></td><td><%=String.valueOf(n.getNoticeDate())%></td></tr>
		<tr class = "answer"><td></td><td colspan ="2"><%=n.getContent() %><br>첨부파일</td></tr>
		<% } %>
		</table>
		</div>

		<div id = "faq">
		<h1>자주 묻는 질문</h1>
		<table class = "faq" cellspacing ="0">
		<tr>
			<th width = "10%">No.</th><th>FAQ</th>
		</tr>
		<tr class = "question"><td>2</td><td>[배송] 배송회사가 어딘가요?</td></tr>
		<tr class = "answer"><td></td><td>질문답변2222</td></tr>
		<tr class = "question"><td>1</td><td>[교환/환불] 교환은 언제까지 되나요?</td></tr>
		<tr class = "answer"><td></td><td>질문답변11111</td></tr>
		</table>
		</div>

		<div id = "direct_q">
	
		<h1>1:1문의</h1>
		<table class="direct_q" cellspacing ="0">
		<tr>
			<th>문의분류</th>
			<td>
				<select name="q_category" >
					<option value="delivery" selected> 배송
					<option value="product">상품
					<option value="order">주문
					<option value="payment">결제
					<option value="ch/rfd">교환/환불
					<option value="membership">회원
					<option value="etc">기타
				</select>
			</td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="title"></td>
		</tr>
		<tr>
			<th>연락처</th>
			<td><input type="text" name="phone1" size="3"> - <input type="text" name="phone2" size="3"> - <input type="text" name="phone3" size ="3"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><input type="email" name="email"></td>
		</tr>
		<tr>
			<th>문의내용</th>
			<td><textarea name="q_content"></textarea></td>
		</tr>
		</table><br>
			<input type="submit" id = "dqBtn" value = "문의하기">
		</div>
	</div><!-- contents --------------------------------->
	</div><!-- wrapper -->
<!-- ---------------------------내용 부분 끝---------------------------------- -->
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
