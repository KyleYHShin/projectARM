<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList, admin.notice.model.vo.*, member.model.vo.*" %>
<%
User loginUser = (User)session.getAttribute("loginUser");
ArrayList<Notice> list = (ArrayList<Notice>)request.getAttribute("list");
String admin = (String)session.getAttribute("admin");
ArrayList<Faqnotice> flist = (ArrayList<Faqnotice>)request.getAttribute("flist");
int pageNo = (int)request.getAttribute("page");
String status = (String)request.getAttribute("status");

String msg = (String)request.getAttribute("msg");

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
			var rItems = "";
			if(sessionStorage.length==0){
				$("#recent_list").html("<div class='ritem' style='color : gray;'><br>최근 본 상품이 없습니다.</div>");
			}else{
				if(sessionStorage.length <= 4){
					//중복 값 지우기 위함.
					for(var i = sessionStorage.length-1; i >= 0; i--){
						var key = sessionStorage.key(i);
						var item = sessionStorage[key];
						for(var j = i-1 ; j >=0; j--){
							var key2 = sessionStorage.key(j);
							var item2 = sessionStorage[key2];
							if(item == item2){
								sessionStorage.removeItem(key2);
							}
						}
					}
					for(var i = sessionStorage.length-1; i >= 0; i--){
						var key = sessionStorage.key(i);
						var item = sessionStorage[key];
						var values = item.split(",");
						var rItem = "<div class='ritem'><a href='/arm/ItemDetailViewServlet?itemNo="+values[0]+"'><img src='"+values[1]+"'></a></div>";
						rItems += rItem;
					}
				} else {//최대 4개만 보여준다
					//중복 값 지우기 위함.
					for(var i = sessionStorage.length-1; i > sessionStorage.length-5; i--){
						var key = sessionStorage.key(i);
						var item = sessionStorage[key];
						for(var j = i-1 ; j > sessionStorage.length-5; j--){
							var key2 = sessionStorage.key(j);
							var item2 = sessionStorage[key2];
							if(item == item2){
								sessionStorage.removeItem(key2);
							}
						}
					}
					for(var i = sessionStorage.length-1; i > sessionStorage.length-5; i--){
						var key = sessionStorage.key(i);
						var item = sessionStorage[key];
						var values = item.split(",");
						var rItem = "<div class='ritem'><a href='/arm/ItemDetailViewServlet?itemNo="+values[0]+"'><img src='"+values[1]+"'></a></div>";
						rItems += rItem;
					}
					if(sessionStorage.length > 10){
						for(var i = sessionStorage.length-10; i >= 0; i--){
							var key = sessionStorage.key(i);
							sessionStorage.removeItem(key);
							//10개이상은 지우기 위홤 >> 5개는 여분
						}
					}
				}
				$("#recent_list").html(rItems);
			}
		}
//------------------------------------------------------------------------끗---------
 	function nologinCart(){
		alert("로그인이 필요합니다");
	}
//------------------------------------------페이징----
//전체 줄 수(reqeust로 전달받음)
		var totalCount =10;<%-- <%= totalCount %> --%>
		//페이지 수 : 한 페이지에 30줄 출력경우
		var totalPage = Math.ceil(totalCount/7);
		var PageNum;
		//현재 페이지(request로 전달받음)
		var page;
	
		//페이지 넘버링 출력
		$(function drawPage(goTo){
			if(goTo *= null){
				page = goTo;
			}else{
				page =<%= pageNo %>
			}
			//페이지 그룹 넘버링 : 한번에 보여줄 페이지 넘버의 갯수
			var pageGroup = Math.ceil(page/10);
			var next = pageGroup*10;
			var prev = next-9;
			
			var goNext = next+1;
			if(prev-1<=0){
				var goPrev = 1;
			}else{
				var goPrev = prev-1;
			}
			
			if(next>totalPage){
				var goNext = totalPage;
				next = totalPage;
			}else{
				var goNext = next+1;
			}
			
			var prevStep = "<a href='javascript:drawPage("+goPrev+");'>"+"<<"+"</a>";
			var nextStep = "<a href='javascript:drawPage("+goNext+");'>"+">>"+"</a>";
			
			$("#npageNo").empty();
			$("#npageNo").append(prevStep);
			for(var i=prev; i<=next; i++){
				
				PageNum = "<a href='/arm/nlist?status=notice&page="+i+"'>"+i+"</a>";
				$("#npageNo").append(PageNum);
			}
			$("#npageNo").append(nextStep);
		});
		
		var ftotalCount =6;<%-- <%= totalCount %> --%>
		//페이지 수 : 한 페이지에 30줄 출력경우
		var ftotalPage = Math.ceil(ftotalCount/7);
		var fPageNum;
		//현재 페이지(request로 전달받음)
		var fpage;
	
		//페이지 넘버링 출력
		$(function fdrawPage(goTo){
			if(goTo *= null){
				fpage = goTo;
			}else{
				fpage =<%= pageNo %>
			}
			//페이지 그룹 넘버링 : 한번에 보여줄 페이지 넘버의 갯수
			var pageGroup = Math.ceil(fpage/10);
			var next = pageGroup*10;
			var prev = next-9;
			
			var goNext = next+1;
			if(prev-1<=0){
				var goPrev = 1;
			}else{
				var goPrev = prev-1;
			}
			
			if(next>ftotalPage){
				var goNext = ftotalPage;
				next = ftotalPage;
			}else{
				var goNext = next+1;
			}
			
			var prevStep = "<a href='javascript:fdrawPage("+goPrev+");'>"+"<<"+"</a>";
			var nextStep = "<a href='javascript:fdrawPage("+goNext+");'>"+">>"+"</a>";
			
			
			$("#fpageNo").empty();
			$("#fpageNo").append(prevStep);
			for(var i=prev; i<=next; i++){
				
				fPageNum = "<a href='/arm/nlist?status=faq&page="+i+"'>"+i+"</a>";
				$("#fpageNo").append(fPageNum);
			}
			$("#fpageNo").append(nextStep);
		});
//--------------------------------------------------
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
		function goCart(){
			<% if(loginUser != null) {%>
			location.href="/arm/CartView";
			<% } else{ %>
			nologinCart();
			<% }%>
		}
		function goMyinfo(){
			<% if(loginUser != null) {%>
			location.href="/arm/myinfo?userid=<%= loginUser.getUserId() %>";
			<% } else{ %>
			nologinCart();
			<% }%>
		}
 	$(function(){
 		//페이징처리에 따른 메뉴css
  		<% if(status == null || status.equals("notice")){ %>
  		$("#notice").show();
		$("#faq").hide();
		$("#direct_q").hide();
		$("#no_btn").css("background", "red").css("color","white");
		$("#q_btn").css("background", "").css("color","");
		$("#dq_btn").css("background", "").css("color","");
		<% } else if(status.equals("faq")){ %>
		$("#notice").css("display","none");
		$("#faq").css("display","block");
		$("#direct_q").css("display","none");
		$("#no_btn").css("background", "").css("color","black");
		$("#q_btn").css("background", "red").css("color","white");
		$("#dq_btn").css("background", "").css("color","");
		<% } %>	
	
  		<% if(msg != null){ %>
			alert("<%= msg %>");
		<% } %>
		
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
		$("#qBtn").click(function() {
			if (onoff == 1) {
				$("#quick_bar").css("right", "-122px").css("transition", "all 0.5s");
				$("#qBtn").css("right", "0px").css("transition", "all 0.5s");
				onoff = 0;
			} else if (onoff == 0) {
				$("#quick_bar").css("right", "0").css("transition", "all 0.5s");
				$("#qBtn").css("right", "118px").css("transition", "all 0.5s");
				onoff = 1;
			}
		});
		
		//공지글,faq 제목 클릭시 내용 슬라이드
		$(".notice .question").click(function(){
			$(this).next().slideToggle();
		});
		$(".faq .question").click(function(){
			$(this).next().slideToggle();
		});

		//$("#no_btn").css("background", "red").css("color","white");
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
			background-color: #fed605;  /*메인 메뉴 색깔 fc3*/
			padding-right : 2%;
			max-width: 100%;
    }
    #topMenu ul {
        list-style-type: none;
        padding: 0px;
		margin : 0;
		
    }
    #topMenu ul li {           
        background-color: #fed605;  
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
	 max-height:70px;/*변경*/
	 border:0;
	}

	
	/*-------------- 퀵바 ----------------------*/
	#quick_bar {
		width: 120px;
		border: 1px solid orange;
		border-radius:5px;
		background: #feffd0;
		background: white;
		z-index: 9999;
		position: fixed;
		right: -122px;
	}
	
	#qBtn {
		position: fixed;
		right: 0px;
		z-index: 9999;
		display: block;
		border: 1px solid #ffcc00;
		transform: rotate(270deg);
		background: #fed605;
		font-size: 12pt;
		border-radius : 3px;
	}
	
	#quick_bar a {
		padding: 16px;
		display: block;
		transition: all 0.3s ease;
		font-size: 15px;
		position: relative;
	}

	/*퀵바 내 칸당 크기 조절-----------------------------------0925*/
	#quick_bar #recent_list .ritem{
		width : 90px;
		height : 90px;
		border : 1px solid orange;
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
		border : 0;
		BORDER-BOTTOM : 1px solid orange;
		border-radius : 0;
		background: none;
	}
	
	#quick_bar .btn:focus, #quick_bar .btn:hover, #quick_bar .btn:active:focus,
		#quick_bar .btn.active:focus, #quick_bar .btn.focus, #quick_bar .btn:active.focus,
		#quick_bar .btn.active.focus {
		background: none;
	}
/*---------------------------내용 부분------------------------------------ */
	#wrapper{
		margin: 0 auto;
		max-width : 1000px;
		height : auto;
	}
	#cs_menu{
		width:100%;
		height : 40px;/*변경*/
		background : #fed605;
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
		font-size : 18px;
		font-weight:900;
		color : black;
		text-decoration:none;
		padding : 5px;/*변경*/
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
		margin : 5px auto;
		padding : 5px;
	}

	/* 공지사항,이벤트 스타일*/
	.answer {
		text-align : left;
	}
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
	.notice textarea{
		width : 98%;
		height : 200px;
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
	.direct_q input[name*="title"]{
		width : 98%;
	}
	.direct_q textarea{
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
/* 페이징부분------------------------------------------------------------------ */
	#npageNo, #fpageNo{
			margin : 10px auto;
			display : table;
			border-spacing : 2px;
	}
	#npageNo a,
	#fpageNo a{
		display : table-cell;
		vertical-align : middle;
		text-align : center;
		border : 1px solid red;
		color : red;
		background : white;
		text-decoration : none;
		width : 30px;
		height : 30px;
	}
	#npageNo a:hover,
	#fpageNo a:hover{
		color : white;
		background : red;
	}
/*---------------------------내용 부분 끝--------------------------------- */
	/* 푸터 */
	footer {
		BORDER-TOP: 1px solid gray;
		BORDER-BOTTOM: 1px solid gray;
		padding-top: 10px;
		padding-bottom: 10px;
		width: 100%;
		height: 150px;
		display: table;
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
		        <li class="topMenuLi"><a class="menuLink" href="/arm/nlist">고객센터</a></li>       
		      <% if(loginUser != null){ %>
		     	 <% if(admin != null) {%>
		        <li class="topMenuLi"><a class="menuLink" href="/arm/ailist">상품관리</a></li>
		       	<li class="topMenuLi"><a class="menuLink" href="/arm/amlist">회원관리</a></li>
		       	<li class="topMenuLi"><a class="menuLink" href="/arm/QnaListViewServlet">Q&A관리</a></li>
		     	 <% }else{%>
		        <li class="topMenuLi"><a class="menuLink" href="/arm/CartView">장바구니</a></li>
		        <li class="topMenuLi"><a class="menuLink" href="/arm/myinfo?userid=<%= loginUser.getUserId() %>">MyPage</a></li>
		        <% } %>
		        <li class="topMenuLi"><a class="menuLink" href="/arm/logout">로그아웃</a></li>
		        <li class="topMenuLi fd hidden-xs">환영합니다! <%=loginUser.getUserName() %>님</li>
		      <% }else{ %>
		        <li class="topMenuLi"><a class="menuLink" onclick="nologinCart();">장바구니</a></li>
		        <li class="topMenuLi"><a class="menuLink" href="/arm/member/MemberJoin.jsp">회원가입</a></li>
		        <li class="topMenuLi"><a class="menuLink" href="/arm/member/Login.jsp">로그인</a></li>
		      <% } %>
		    </ul>
	   </nav>
 	</div>
	<!-- 퀵바 -->
	<button id="qBtn" class="hidden-xs"><span class="glyphicon glyphicon-chevron-up"></span></button>
	<div id="quick_bar" class="hidden-xs">
		<button id="mypage" class="btn btn-default" onclick="goMyinfo();">
			<span class="glyphicon glyphicon-user"></span> MY PAGE
		</button>
		<!-- 그냥 장바구니 페이지로 이동하도록. -->
		<button id="cart" class="btn btn-default" onclick="goCart();">
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
	
	<!-- 관리자일 경우 -->
	<% if(admin != null){
		for(Notice n:list){
		%>
		<form action="/arm/nupdate" method="post" enctype="multipart/form-data">
		<tr class = "question"><td><input type = "text" name = "noticeno" value=<%=n.getNoticeNo() %> size="10" readonly></td>
			<td><select name = "cate">
					<% if(n.getCatNo() == 1){ %>
					<option value="1" selected>공지사항</option>
					<option value="2">이벤트</option>
					<% } else if(n.getCatNo() == 2){ %>
					<option value="1">공지사항</option>
					<option value="2" selected>이벤트</option>
					<% } %>
				</select>&nbsp;&nbsp;<input type="text" name="ntitle" value="<%=n.getNoticeTitle() %>" style="width:80%"></td>
			<td><%=String.valueOf(n.getNoticeDate())%></td>
		</tr>
		<tr class = "answer"><td></td><td colspan ="2"><textarea name="content" rows="5" cols="50"><%=n.getContent() %></textarea>
		<br><br><br><span style="float : left;">첨부파일 : <%
						if(n.getNoticeFile() == null){  //첨부파일이없는 경우
					%>첨부파일없음</span><br><input type="file" name="nfile">
					<%  }else{ //첨부파일이 있는 경우 %>
						<a href="/arm/filedown?ofile=<%= n.getNoticeFile() %>"><%= n.getNoticeFile() %></a></span><br>
						<input type="file" name="nfile">
					<%  } //첨부파일이있는경우 닫기%>
					<br><br><input type="submit" value="수정하기">&nbsp;&nbsp;
					<button style="font-size: 14px; width: 80px; height: 25px;"
						type="submit" formaction="ndel?noticeNo=<%= n.getNoticeNo() %>">삭제하기</button></td>
		</tr>
		</form>
				<% } %>
		<!-- 일반회원일 경우 -->
		<% }else{
				for(Notice n:list){	 %>
		<tr class = "question"><td><%=n.getNoticeNo() %></td><td><%if( n.getCatNo()==1 ){ %>[공지사항] <%}else{ %>[이벤트] <%} %><%=n.getNoticeTitle() %></td><td><%=String.valueOf(n.getNoticeDate())%></td></tr>
		<tr class = "answer"><td></td><td colspan ="2"><%=n.getContent() %>
		<br><br><br><span style="float : left;">첨부파일 :
			<%	if(n.getNoticeFile() == null){  //첨부파일이없는 경우
			%>첨부파일없음</span>
			<%  }else{ //첨부파일이 있는 경우 %>
				<a href="/arm/filedown?ofile=<%=n.getNoticeFile() %>"><%= n.getNoticeFile() %></a></span>
			<%  } %>
			</td>
		</tr>
			<% } 
			} %>
		</table>
		<!-- 관리자 공지사항입력 -->
		<% if(admin != null){ %>
		<br><button onclick="window.open('notice/adminnotice.jsp');">글쓰기</button>
		<% }%>
		<br><div id ="npageNo"></div>
		</div>

	<div id = "faq">
		<h1>자주 묻는 질문</h1>
		<table class = "faq" cellspacing ="0">
		<tr>
			<th width = "10%">No.</th><th>FAQ</th>
		</tr>
		<!-- 관리자일 경우 -->
		<% if(admin != null){
			for(Faqnotice f:flist){ %>
		<form action="/arm/faqupdate" method="post">
			<tr class = "question"><td><input type = "text" name = "faqno" value="<%=f.getFaqNo() %>" size="10" readonly></td>
				<td><select name = "fcate">
				<% switch(f.getFaqcatNo()){
					case 1 : %>
              			<option value="1" selected>제품</option>
              			<option value="2">결제</option>
              			<option value="3">배송</option>
						<option value="4">가입</option>
						<option value="5">기타</option>
					<%break;
					case 2: %>
						<option value="1" >제품</option>
              			<option value="2" selected>결제</option>
              			<option value="3">배송</option>
						<option value="4">가입</option>
						<option value="5">기타</option>
					<%break;
					case 3: %>
						<option value="1" >제품</option>
              			<option value="2" >결제</option>
              			<option value="3"selected>배송</option>
						<option value="4">가입</option>
						<option value="5">기타</option>
					<%break;
					case 4: %>
						<option value="1" >제품</option>
              			<option value="2" >결제</option>
              			<option value="3">배송</option>
						<option value="4" selected>가입</option>
						<option value="5">기타</option>
					<% break; 
					default : %>
						<option value="1" >제품</option>
              			<option value="2" >결제</option>
              			<option value="3">배송</option>
						<option value="4">가입</option>
						<option value="5" selected>기타</option>
					<% break;
					}%>
			</select>&nbsp;&nbsp;<input type="text" name="ftitle" value="<%=f.getFaqTitle() %>" style="width:80%"></td>
				
			</tr>
		
		<tr class = "answer"><td></td><td colspan ="2"><textarea name="fcontent" rows="5" cols="85"><%= f.getFaqContent() %></textarea>
		<br><br><input type="submit" value="수정하기">&nbsp;&nbsp;
					<button style="font-size: 14px; width: 80px; height: 25px;"
						type="submit" formaction="fdel?faqNo=<%= f.getFaqNo() %>">삭제하기</button></td>
		</tr>
		</form>	
		<% } %>
		<!-- 일반회원일 경우 -->
	<% }else{
		for(Faqnotice f:flist){ %>
		<tr class = "question"><td><%= f.getFaqNo() %></td><td>[<%=f.getFaqcatName() %>]&nbsp;&nbsp;<%=f.getFaqTitle() %></td></tr>
		<tr class = "answer"><td></td><td colspan ="2"><%=f.getFaqContent() %><br></td>
		</tr>
		<% } 
		} //end of if %>
		</table>
		<!-- 관리자 FAQ 입력 -->
		<% if(admin != null){ %>
		<button onclick="window.open('notice/adminFaq.jsp');">글쓰기</button>
		<%} %>
		<br><div id ="fpageNo"></div>
	</div>
		
	<div id = "direct_q">
	<h1>1:1문의</h1>
	<!-- 문의종류에 따라 이메일 선택 -->
	 <form action="/arm/mailsend" method="post">
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
		<td><input type="text" name="subject"></td>
	</tr>
	<tr>
		<th>연락처</th>
		<td><input type="text" name="phone1" size="3"> - <input type="text" name="phone2" size="3"> - <input type="text" name="phone3" size ="3"></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td>
		<input type="text" name="email">
		</td>
	</tr>
	<tr>
		<th>문의내용</th>
		<td><textarea name="content"></textarea></td>
	</tr>
	</table><br>
		<input type="submit" id = "dqBtn" value = "문의하기">
		</form>
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
	<h1><img src="img/tel.png" width="50" height="50" border="0" alt="">&nbsp;1600-7000</h1>
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
