<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	$(function(){
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
		
		//퀵바 장바구니, 최근 본 목록 슬라이드 처리
		$("#recent").click(function(){
			$("#recent_list").slideDown("fast");
			$("#cart_list").slideUp("fast");
		});
		$("#cart").click(function(){
			$("#recent_list").slideUp("fast");
			$("#cart_list").slideDown("fast");
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
	/*.topMenuLi:hover .menuLink {
        color: red;
        cursor : pointer;
    } 계속 해서 오류 안나면 지움*/ 
    .menuLink:hover {
        color: red;
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
	/* 그라데이션 지우기 */
	.carousel-control.left {
	  background-image: none;
	 }
	.carousel-control.right {
	  background-image:none;
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
	/* 상품목록------------------------------------- */
	  /*데스크탑*/
	.contents{
		margin: 0 auto;
		display: table;
		width: 100%;
		max-width: 1000px;
		padding:1%;

		text-align : center;
	}
	.item_box{
		/*float: left;*/
		max-width:23%;
		margin:0.5%;
		padding:0.5%;
		background: white;
		display : inline-block;
	}
	.item_box img{
		width:100%;
	}	
	.item_name, .item_price{
		font-size: 0.8em;
		text-align: center;
	}
/*태블릿 용*/
  @media all and (max-width: 1000px){
	 .contents{
		padding : 0.5%;
		padding-left : 3.3%
		padding-right : 0;
	}
	.item_box{
		 max-width:31%;
		 background: #ccffcc;
	}
	.item_name, .item_price{
		font-size: 0.9em;
	}
	gggg
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
		background: #ffccff;
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
		 background: #99ffff;
	 }
	.item_name, .item_price{
		font-size: 0.7em;
	}
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
			<li class="topMenuLi"><a class="menuLink" href="/arm/notice/notice.jsp">고객센터</a></li>
			<li class="topMenuLi"><a class="menuLink" href="/arm/mypage/MyinfoCart.jsp">장바구니</a></li>
            <li class="topMenuLi"><a class="menuLink" href="">회원가입</a></li>
            <li class="topMenuLi"><a class="menuLink" href="/arm/member/Login.jsp">로그인</a></li>
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
	<a href="/arm/Main.jsp"><img src="/arm/img/banner.png" alt = "시작페이지로"></a>
 </div>

 <div id = "ad">
		<!-- 작성 필요 -->
		<div id="advTimebar"></div>
		<div id="mainAdv" class="carousel slide" data-ride="carousel"
			data-interval="3500">
			<ol class="carousel-indicators">
				<li data-target="#mainAdv" data-slide-to="0" class="active"></li>
				<li data-target="#mainAdv" data-slide-to="1" class=""></li>
				<li data-target="#mainAdv" data-slide-to="2" class=""></li>
			</ol>
			<!-- role 이 애니메이션 효과 -->
			<div class="carousel-inner" role="listbox">
				<div class="item active">
					<img class="adv-img" src="images/1.png">
				</div>
				<div class="item">
					<img class="adv-img" src="images/2.jpg">
				</div>
				<div class="item">
					<img class="adv-img" src="images/3.png">
				</div>
			</div>

			<a class="left carousel-control" href="#mainAdv" data-slide="prev">
				<span class="icon-prev"></span>
			</a> <a class="right carousel-control" href="#mainAdv" data-slide="next">
				<span class="icon-next"></span>
			</a>
		</div>
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
	<form>
	<input type="text" id = "search" name = "search" placeholder = "검색하세요!">&nbsp;&nbsp;
	<input type="image" id = "schBtn" src = "/arm/img/search2_small.png" width ="25px" height = "25px";>
	</form>
	</div><!-- 검색 -->

	<div id = "sort">
	<a href="#">인기도순</a>&nbsp;&nbsp;
	<a href="#">가격높은순</a>&nbsp;&nbsp;
	<a href="#">가격낮은순</a>&nbsp;&nbsp;
	</div><!-- sort -->
	
	</div><!-- fix_menu(카테고리+검색+정렬) -->
	
	
     <div class="contents">
            <section class="item_box">
			<!-- 클릭시 상세 페이지로 이동하도록. -->
                <a href = "/arm/item/ItemDetail.jsp"><table>
                    <tr> <td class="item_img"><img src="items/01.jpg"><td></tr>
                    <tr> <td class="item_name">아이템 이름1<td></tr>
                    <tr> <td class="item_price">Price1<td></tr>
                </table></a>
            </section>
            <section class="item_box"">
                <table>
                    <tr> <td><img src="items/02.jpg"><td></tr>
                    <tr> <td class="item_name">아이템 이름2<td></tr>
                    <tr> <td class="item_price">Price2<td></tr>
                </table>
            </section>
            <section class="item_box"">
                <table>
                    <tr> <td><img src="items/03.jpg"><td></tr>
                    <tr> <td class="item_name">아이템 이름3<td></tr>
                    <tr> <td class="item_price">Price3<td></tr>
                </table>
            </section>
        </section>
        <section class="item_box"">
            <table>
                <tr> <td><img src="items/04.jpg"><td></tr>
                <tr> <td class="item_name">아이템 이름4<td></tr>
                <tr> <td class="item_price">Price4<td></tr>
            </table>
        </section>
        <section class="item_box"">
            <table>
                <tr> <td><img src="items/05.jpg"><td></tr>
                <tr> <td class="item_name">아이템 이름5<td></tr>
                <tr> <td class="item_price">Price5<td></tr>
            </table>
        </section>
        <section class="item_box"">
            <table>
                <tr> <td><img src="items/06.jpg"><td></tr>
                <tr> <td class="item_name">아이템 이름6<td></tr>
                <tr> <td class="item_price">Price6<td></tr>
            </table>
        </section>
        <section class="item_box"">
            <table>
                <tr> <td><img src="items/07.jpg"><td></tr>
                <tr> <td class="item_name">아이템 이름7<td></tr>
                <tr> <td class="item_price">Price7<td></tr>
            </table>
        </section>
        <section class="item_box"">
            <table>
                <tr> <td><img src="items/08.jpg"><td></tr>
                <tr> <td class="item_name">아이템 이름8<td></tr>
                <tr> <td class="item_price">Price8<td></tr>
            </table>
        </section>
    </div><!-- contents -->


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
    