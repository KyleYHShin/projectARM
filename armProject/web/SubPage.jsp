<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "java.util.ArrayList, item.model.vo.Item, member.model.vo.User"%>
<% 
	User loginUser = (User)session.getAttribute("loginUser");
	String admin = (String)session.getAttribute("admin");
	
	ArrayList<Item> list = (ArrayList<Item>)request.getAttribute("list");
	String msg = (String)request.getAttribute("msg");
	
	String status = (String)request.getAttribute("status");
	String keyword = (String)request.getAttribute("keyword");
	
	int totalCount = (int)request.getAttribute("totalCount");
	int pageNo = (int)request.getAttribute("page");
	int sortNo = (int)request.getAttribute("sortNo");
 %>
<!doctype html>
<html lang="ko">
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>Main</title>

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
//------------------------------------------------------------------------------------------이슬 끗
	//전체 줄 수(reqeust로 전달받음)
	var totalCount = <%= totalCount %>;
	//페이지 수 : 한 페이지에 12줄 출력경우
	var totalPage = Math.ceil(totalCount/30);
	var PageNum;
	//현재 페이지(request로 전달받음)
	var page;

	//페이지 넘버링 출력
	$(function drawPage(goTo){
		if(goTo *= null){
			page = goTo;
		}else{
			page = <%= pageNo %>;
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
		
		$("#pageNo").empty();
		$("#pageNo").append(prevStep);
		for(var i=prev; i<=next; i++){
			
			PageNum = "<a href='/arm/ipage?status=<%= status %>&sortno=<%= sortNo %>&keyword=<%= keyword %>&page="+i+"'>"+i+"</a>";
			$("#pageNo").append(PageNum);
		}
		$("#pageNo").append(nextStep);
	});
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
		//최근목록보기
		viewRecentItem();
		
		//페이지표시
		$("#pageNo>a").each(function(){
			if($(this).text() == "<%= pageNo %>"){
				$(this).css("background", "red").css("color","white");
			}
		});
		//정렬표시
		<% if(sortNo == 1){ %>
			$("#sort1").css("color","red");
		<% }else if(sortNo == 2){ %>
			$("#sort2").css("color","red");
		<% }else if(sortNo == 3){ %>
			$("#sort3").css("color","red");
		<% }else if(sortNo == 4){ %>
			$("#sort4").css("color","red");
		<% } %>


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
		
		//카테고리 색상 바꾸기 및 검색시 키워드 띄우기
		<% if(status.equals("search")){ %>
			$("#sch").css("background", "red").css("color","white");
			$("#searchbox").css("display","block");
			$("#search").attr("value","<%= keyword %>");
		<%}else if(!status.equals("main") && !status.equals("err")){
			int categoryNo = Integer.parseInt(status);
			if(categoryNo == 100){%>
			 $("#cat_100").css("background", "red").css("color","white");
			<%}else if(categoryNo == 200){%>
			 $("#cat_200").css("background", "red").css("color","white");
			<%}else if(categoryNo == 300){%>
			 $("#cat_300").css("background", "red").css("color","white");
			<%}else if(categoryNo == 400){%>
			 $("#cat_400").css("background", "red").css("color","white");
			<%}
		}%>
		
//-- ----------------------------------------------------------이슬작성-끗---------------- -->
		$(document).on("hover",".menuLink", function(){
			$(this).css("color","red"),css("cursor","pointer");
		});
		//------------------------------------------------------------------------------------------이슬 끗
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
	 max-height:70px;
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
		height : 40px;/*수정*/
		background : #fed605;
	}
	/* 메뉴구현 */
	.navi {
		list-style-type: none;
		padding: 0;
		margin: 0;
	}
	
	.navi li {
		float: left;
		position: relative;
		padding: 0;
		line-height: 30px;/*메뉴 높이*/
		width: 20%;
		/* background: rgba(255, 255, 0, 0.5); */
	}
	
	.navi li a {
		display: block;
		font-weight: 900;
		font-size: 16px;/*메뉴글자크기*/
		padding: 5px 25px;
		color: black;
		text-decoration: none;
	}
	/* 미디어쿼리 */
	@media all and (max-width: 1000px) {
		.navi li a {
			font-size: 16px;
			padding: 5px 20px;
		}
	}
	
	@media all and (max-width: 750px) {
		.navi li a {
			font-size: 15px;
			padding: 5px 0px;
		}
	}
	
	@media all and (max-width: 300px) {
		.navi li a {
			font-size: 15px;
			padding: 1px 0px;
		}
		.navi li {
			line-height: 40px;
		}
	}
	
	.navi li a:hover {
		color: #fff;
		background: red;
	}
	
	.navi li ul {
		opacity: 0;
		position: absolute;
		left: 0;
		width: 100%;
		min-width: 102px;
		/*background : red;*/
		list-style-type: none;
		padding: 0;
		margin: 0;
		border: 1px solid red;
	}
	
	.navi li:hover ul {
		opacity: 1;
	}
	
	.navi li ul li {
		float: none;
		height: 0;
		line-height: 0;
		background: none;
		width: 100%;
		position: relative;
		top: -10px;
	}
	
	.navi li:hover ul li {
		height: auto;
		line-height: 30px;
		padding: 0;
		position: relative;
		top: 0;
	}
	
	.navi li ul li a {
		background: white;
		font-weight: 900;
		font-size: 15px;
		color: #ff0000;
		min-width: 100px;
	}
	
	.navi li {
		/*나타날때*/
		transition: all 0.1s;
		-webkit-transition: all 0.1s;
	}
	
	.navi li a {
		transition: all 0.2s;
		-webkit-transition: all 0.2s;
	}
	
	.navi li ul {
		/*사라질 때*/
		transition: all 0.1s;
		-webkit-transition: all 0.1s;
	}
	
	.navi li ul li {
		transition: all 0.2s;
		-webkit-transition: all 0.2s;
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
		BORDER-BOTTOM : 1px solid #fed605;
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
	/* 상품목록------------------------------------- */
	  /*데스크탑*/
	.contents{
		margin: 0 auto;
		display: table;
		width: 100%;
		max-width: 1000px;
		min-height : 500px;
		padding:1%;

		text-align : center;
	}
	.item_box{
		/*float: left;*/
		max-width:19%;/*변경*/
		margin:0.5%;
		padding:0.5%;
		display : inline-block;
	}
	
	.item_box img {
		width: 100%;
	}
	.item_box a{
		color : black;
		text-decoration : none;
	}
	.item_box a:hover .item_name {
		text-decoration : underline;
		color : red;
	}
	.item_price {
		font-weight : 700;
		color : red;
	}
	.item_name, .item_price {
		font-size: 0.8em;
		text-align: center;
	}
/*태블릿 용*/
  @media all and (max-width: 1000px){
	 .contents{
		padding : 0.5%;
		padding-left : 3.3%;
		padding-right : 0;
	}
	.item_box{
		 max-width:31%;
	}
	.item_name, .item_price{
		font-size: 0.9em;
	}
	
  }
  /*휴대폰*/
  @media all and (max-width: 750px){
	.contents{
		padding:1%;
		padding-left : 2.2%
	}
	.item_box{
		max-width: 47%;
		margin:0.8%;
		padding:0.5%;
	}
	.item_name, .item_price{
		font-size: 1em;
	}
  }  
  /*기타 기기(스마트워치 등)*/
  @media all and (max-width: 300px){
	 .item_box{
		 max-width: 100%;
		 margin:0;
		 padding:0;
	 }
	.item_name, .item_price{
		font-size: 0.7em;
	}
  }
  /*---------------------------------------------------------------------------------이슬*/
  
  		#pageNo{
			margin : 10px auto;
			display : table;
			border-spacing : 2px;
		}
		#pageNo a{
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
		#pageNo a:hover{
			color : white;
			background : red;
		}
  /*---------------------------------------------------------------------------------이슬끗*/
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

  </style>
  
 </head>
 <body>
<!--  최상단 기본메뉴 -->
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
<!-- 카테고리 ~ item 목록 -->
 <div id="wrapper">

 	<div id = "fix_menu">
		<div id="category">
			<ul class="navi">
				<li><a href="/arm/catlist?categoryno=100" id = "cat_100">손</a></li>
				<!-- 손 -->
				<li><a href="/arm/catlist?categoryno=200" id = "cat_200">손목</a></li>
				<!-- 손목 -->
				<li><a href="/arm/catlist?categoryno=300" id = "cat_300">팔꿈치</a></li>
				<!-- 팔목 -->
				<li><a href="/arm/catlist?categoryno=400" id = "cat_400">어깨</a></li>
				<!-- 어깨 -->
				<li><a id="sch">검색</a></li>
			</ul>
		</div>
			
	<div id = "searchbox">
		<form action="/arm/isearch" method="post">
			<input type="text" id="search" name="keyword" placeholder="검색하세요!">&nbsp;&nbsp;
			<input type="image" id="schBtn" src="/arm/img/search2_small.png"
				width="25px" height="25px">
		</form>
	</div><!-- 검색 -->

	<div id = "sort">
		<a href="isort?status=<%=status%>&keyword=<%= keyword %>&sortno=1" id = "sort1">최신등록순</a>&nbsp;&nbsp; 
		<a href="isort?status=<%=status%>&keyword=<%= keyword %>&sortno=2" id = "sort2">높은조회순</a>&nbsp;&nbsp;
		<a href="isort?status=<%=status%>&keyword=<%= keyword %>&sortno=3" id = "sort3">높은가격순</a>&nbsp;&nbsp;
		<a href="isort?status=<%=status%>&keyword=<%= keyword %>&sortno=4" id = "sort4">낮은가격순</a>&nbsp;&nbsp;
	</div><!-- sort -->
	
	</div><!-- fix_menu(카테고리+검색+정렬) -->
	
	
     <div class="contents">
           <%
           if(list != null){
           for(Item i : list){ %>
            <section class="item_box">
			<!-- 클릭시 상세 페이지로 이동하도록. -->
                <a href = "/arm/ItemDetailViewServlet?itemNo=<%= i.getItemNo() %>"><table>
                    <tr> <td class="item_img"><img src=<%= i.getItemTH() %>><td></tr>
                    <tr> <td class="item_name"><%= i.getItemName() %><td></tr>
					<% if (loginUser != null) {%>
						<tr><td class="item_price" style = "color : black; font-weight : 600; text-decoration : line-through;">
						<%=i.getItemPrice()%>원<td></tr>
						<tr><td class="item_price" style = "color : red; font-weight : 800;">
						<%= Math.round(i.getItemPrice()*(1-loginUser.getDiscount())) %>원<td></tr>
						<% } else {%>
						<tr><td class="item_price"><%=i.getItemPrice()%>원<td></tr>
						<% } %>
                </table></a>
            </section>
            <% }
            }else{ %>
            
            <h3><%= msg %></h3>
            
            <% } %>
          <!-- 페이징처리할때 ------------------------------------------------------ -->
			<div id = "pageNo"></div>
		<!-- --------------------------------------------------------------요까지이슬----------------- -->
    </div><!-- contents-->


	</div><!-- fix+item_list -->
	
	<!-- top버튼 -->
	<div style="position:fixed; bottom:10px; right:10px; z-index : 9999;">
	 <a href="#top"><img src="/arm/img/top3.png" width="51" height="51" border="0" title="위로 이동"></a> <!-- 위에있는 이름 top에 있는 위치로 이동함 -->
	</div>

	<!-- 푸터 -->
	<footer>
	<div id = "fwrap">
	<div class = "fd">
		<h1><img src="/arm/img/tel.png" width="50" height="50" border="0" alt="">&nbsp;1600-7000</h1>
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
    