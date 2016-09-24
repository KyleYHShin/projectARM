<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="member.model.vo.User, java.util.ArrayList, cart.model.vo.Cart"%>
<%
	User loginUser = (User) session.getAttribute("loginUser");
	ArrayList<Cart> cartList = (ArrayList<Cart>) request.getAttribute("cartList");
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MyPage:Cart</title>

<link href="/arm/bootstrap/css/bootstrap.min.css" rel="stylesheet">

<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
<script src="/arm/bootstrap/js/bootstrap.min.js"></script>

<script type="text/javascript" src="/arm/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
	$(function() {
		//퀵바 토글 - 퀵바 고정위치를 클릭시마다 바뀌게 하면서 trasition효과
		var onoff = 0;
		$("#qBtn").click(
				function() {
					if (onoff == 1) {
						$("#quick_bar").css("right", "-122px").css(
								"transition", "all 0.5s");
						$("#qBtn").css("right", "-14px").css("transition",
								"all 0.5s");
						onoff = 0;
					} else if (onoff == 0) {
						$("#quick_bar").css("right", "0").css("transition",
								"all 0.5s");
						$("#qBtn").css("right", "106px").css("transition",
								"all 0.5s");
						onoff = 1;
					}
					;
				});

		//퀵바 장바구니, 최근 본 목록 슬라이드 처리
		$("#recent").click(function() {
			$("#recent_list").slideDown("fast");
			$("#cart_list").slideUp("fast");
		});
		$("#cart").click(function() {
			$("#recent_list").slideUp("fast");
			$("#cart_list").slideDown("fast");
		});

		//전체선택
		var selected = false;
		$("#btn_select_all").click(function() {
			/* window.alert('동작'); */
			var checkboxes = document.getElementsByName('ck_item_select');
			var total = checkboxes.length;
			
			if (!select) {
				window.alert('select = 0');
				for (var i = 0; i < total; i++) {
					checkboxes[i].checked = true;
					selected = true;
				}
			} else {
				window.alert('select = 1');
				for (var i = 0; i < total; i++) {
					checkboxes[i].checked = false;
					selected = false;
				}
			}
		});

		//선택 상품 삭제
	});
</script>
<style type="text/css">
body {
	min-width: 240px;
}

div {
	text-align: center;
	vertical-align: middle;
}

/* 기본메뉴(최상단) */
nav#topMenu {
	height: 30px;
	width: 100%;
	background-color: yellow; /*메인 메뉴 색깔 fc3*/
	padding-right: 2%;
	max-width: 100%;
}

#topMenu ul {
	list-style-type: none;
	padding: 0px;
	margin: 0;
}

#topMenu ul li {
	background-color: yellow;
	float: right;
	line-height: 30px;
	padding: 0 5px;
	text-align: center;
}

.menuLink {
	color: black;
	text-decoration: none;
}

.topMenuLi a {
	BORDER-LEFT: 1px solid black;
	padding-left: 10px;
}

@media all and (max-width: 1000px) {
}

@media all and (max-width: 750px) {
	.topMenuLi a {
		font-size: 9pt;
		line-height: 25px;
	}
}

@media all and (max-width: 300px) {
	.topMenuLi a {
		font-size: 3pt;
		line-height: 25px;
	}
}

.topMenuLi:hover .menuLink {
	color: red;
}
/*------------------- 최상단 메뉴 끝 -----------*/
#banner {
	margin: 10px auto;
}
/*상단 배너 크기*/
#banner a img {
	max-width: 100%;
	max-height: 100px;
	border: 0;
}

/*-------------- 퀵바 ----------------------*/
#quick_bar {
	width: 120px;
	height: auto;
	border: 1px solid yellow;
	background: #feffd0;
	background: white;
	z-index: 9999;
	position: fixed;
	right: -122px;
	top: 170px;
}

#qBtn {
	position: fixed;
	right: -14px;
	bottom: 310px;
	z-index: 9999;
	display: block;
	border: 1px solid orange;
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

#quick_bar #recent_list table {
	margin: 3px auto;
}

#quick_bar .btn {
	width: 100%;
}

#quick_bar .btn:focus, #quick_bar .btn:hover, #quick_bar .btn:active:focus,
	#quick_bar .btn.active:focus, #quick_bar .btn.focus, #quick_bar .btn:active.focus,
	#quick_bar .btn.active.focus {
	background: white;
}

#wrapper {
	margin: 0 auto;
	max-width: 1000px;
	height: auto;
}

#cs_menu {
	width: 100%;
	height: 50px;
	background: yellow;
	margin: 5px auto;
}

/*고객센터 메뉴*/
.cs_navi {
	list-style-type: none;
	padding: 0;
	margin: 0;
}

.cs_navi li {
	float: left;
	width: 25%;
	padding: 0;
	position: relative;
	line-height: 30px;
}

.cs_navi li a {
	font-size: 20px;
	font-weight: 900;
	color: black;
	text-decoration: none;
	padding: 10px;
	display: block;
}

.cs_navi li a:hover {
	color: white;
	background: rgba(255, 0, 0, 0.8);
	cursor: pointer;
}

#c_btn {
	color: white;
	background: red;
}

@media all and (max-width: 1000px) {
	.cs_navi li a {
		font-size: 17px;
	}
}

@media all and (max-width: 750px) {
	.cs_navi li a {
		font-size: 13px;
		padding: 10px 0;
	}
}

@media all and (max-width: 300px) {
	.cs_navi li a {
		font-size: 11px;
		padding: 10px 0;
	}
}

#contents {
	width: 100%;
	margin: 0 auto;
	margin-bottom: 10%;
	padding-top: 2%;
	min-height: 600px;
	padding-top: 2%;
	/*background : #ffffcc;*/
}

/*-------장바구니-----------*/
#pur_step {
	font-size: 1.7em;
	color: #bebebe;
	padding-bottom: 5%;
}

#pur_step .active {
	color: black;
}

.item_img {
	max-width: 100px;
	max-height: auto;
	padding: 3px;
}

#cart_table {
	width: 100%;
}

#cart_table #cart_top {
	margin: 0 auto;
	width: 95%;
}

#cart_table #cart_top #btn_select_all {
	float: left;
	border: 1px solid green;
	background: green;
	color: white;
}

#cart_table #cart {
	width: 95%;
	margin-top: 3px;
	BORDER-TOP: 2px solid black;
	BORDER-BOTTOM: 2px solid black;
	text-align: center;
	BORDER-TOP: 2px solid black;
}

#cart_table #cart tr {
	BORDER-BOTTOM: 1px solid gray;
}

#cart_table #cart th {
	background: #ffff99;
	text-align: center;
}

#pay {
	margin: 0 auto;
	margin-top: 3px;
	width: 95%;
	BORDER-BOTTOM: 2px solid black;
}

#pay button#ck_remove_btn, button#continue_btn {
	border: 1px solid green;
	background: green;
	color: white;
	float: left;
}

button#continue_btn {
	margin-top: 5px;
	font-size: 1.4em;
}

#pay button#purchase_btn {
	margin-top: 5px;
	border: 1px solid red;
	background: red;
	color: white;
	float: right;
	font-size: 1.5em;
	width: 150px;
}

#pay p span { /*결제가격 부분(빨간글씨)*/
	color: red;
	font-size: 1.4em;
	font-weight: 900;
}
/*-------장바구니끝-----------*/

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

footer #fwrap {
	display: table-cell;
	vertical-align: middle;
	text-align: center;
	display: table-cell;
}

.fd {
	display: inline-block;
	text-align: left;
	padding: 0 20px;
}

@media all and (max-width: 300px) {
	.fd h1 {
		font-size: 20pt;
	}
}

#fmenu {
	list-style-type: none;
}

.footMenu a {
	text-decoration: none;
	color: black;
}

.footMenu a:hover {
	text-decoration: underline;
}
</style>

</head>
<body>
	<!-- 최상단 기본메뉴 -->
	<div id="top_menu">
		<nav id="topMenu">
			<ul>
				<!-- ---------------------------수정------------------------------------ -->
				<li class="topMenuLi"><a class="menuLink" href="nlist">고객센터</a></li>
				<%
					if (loginUser != null) {
				%>
				<li class="topMenuLi"><a class="menuLink" href="/arm/CartView">장바구니</a></li>
				<li class="topMenuLi"><a class="menuLink"
					href="/arm/mypage/MyinfoDetail.jsp">MyPage</a></li>
				<li class="topMenuLi"><a class="menuLink" href="logout">로그아웃</a></li>
				<li class="topMenuLi">환영합니다! <%=loginUser.getUserName()%>님
				</li>
				<%
					} else {
				%>
				<li class="topMenuLi"><a class="menuLink"
					onClick="nologinCart()">장바구니</a></li>
				<li class="topMenuLi"><a class="menuLink"
					href="/arm/member/MemberJoin.jsp">회원가입</a></li>
				<li class="topMenuLi"><a class="menuLink"
					href="/arm/member/Login.jsp">로그인</a></li>
				<%
					}
				%>
				<!-- ---------------------------수정 끝------------------------------------ -->
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
		</button>
		<br>
		<div id="cart_list">
			<table cellpadding="0" cellspacing="0" border="1px">
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
		<button id="recent" class="btn btn-default">최근 본 상품</button>
		<div id="recent_list">
			<table cellpadding="0" cellspacing="0" border="1px">
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
		<button>◀</button>
		1/5
		<button>▶</button>
	</div>
	<!-- 배너 -->
	<div id="banner">
		<!-- 배너클릭시 시작페이지로! -->
		<a href="/arm/Main.jsp"><img src="/arm/img/banner.png"
			alt="시작페이지로"></a>
	</div>
	<div id="wrapper">
		<div id="cs_menu">
			<ul class="cs_navi">
				<!-- ---------------------------수정------------------------------------ -->
				<li><a href="/arm/mypage/MyinfoDetail.jsp" id="u_btn">회원정보</a></li>
				<li><a href="/arm/CartView" id="c_btn">장바구니</a></li>
				<li><a href="/arm/PurchaseView" id="bl_btn">구매 내역</a></li>
				<li><a href="/arm/mypage/MyinfoQuestion.jsp" id="qa_btn">문의
						내역</a></li>
				<!-- ---------------------------수정 끝------------------------------------ -->
			</ul>
		</div>
		<!-- cs_menu -->

		<!-- ---------------------------수정------------------------------------ -->
		<div id="contents">

			<!-- 장바구니 -->
			<div id="t_cart">
				<div id="pur_step">
					<label class="step active">1. 장바구니</label> &nbsp;> &nbsp; <label
						class="step">2. 주문확인</label> &nbsp;> &nbsp; <label class="step">3.
						결&nbsp;&nbsp;&nbsp;&nbsp;제</label> &nbsp;> &nbsp; <label class="step">4.
						완&nbsp;&nbsp;&nbsp;&nbsp;료</label>
				</div>
				<div id="cart_table">
					<table id="cart_top">
						<tr>
							<td><button id="btn_select_all">전체 선택</button></td>
						</tr>
					</table>
					<table id="cart" align="center" cellspacing="0" cellpadding="10px">
						<tr>
							<th width="30px"></th>
							<th>상품 이미지</th>
							<th width="400px">상품설명</th>
							<th width="150px">수량</th>
							<th width="150px">상품가격</th>
							<th width="30px"></th>
						<tr>
							<%
								int deliCost = 0;
								int sumTotalPrice = 0;
								/* 테스트용 */String userId = "user01";

								if (cartList != null) {
									deliCost = 2500;
									for (Cart c : cartList) {
										sumTotalPrice += c.getTotal_price();
							%>
						
						<tr>
							<td><input type="checkbox" name="ck_item_select"></td>
							<td><img class="item_img" src="<%=c.getItem_img_mini()%>"></td>
							<td>상품명:<%=c.getItem_name()%><br>옵션명: <%=c.getItem_sub_name()%>
							</td>
							<td>
								<form
									action="/arm/CartUpdate?cartNo=<%=String.valueOf(c.getCart_no())%>"
									method="post">
									<input type="number" name="item_qty" class="item_qty" min="1"
										max="99" value="<%=c.getQuantity()%>"> <input
										type="submit" value="적용">
								</form>
							</td>
							<td><%=c.getTotal_price()%>원</td>
							<td>
								<form
									action="/arm/CartDelete?userId=user01&cartNo=<%=String.valueOf(c.getCart_no())%>"
									method="post">
									<input type="submit" value="x">
								</form>
							</td>
						</tr>
						<%
							}
							}
						%>
					</table>
				</div>

				<div id="pay">
					<button id="ck_remove_btn">선택 상품 삭제</button>
					<br>
					<p align="right" style="font-size: 1.3em;">
						총 상품가격
						<%=sumTotalPrice%>원<br> 배송비
						<%=deliCost%>
					</p>
					<hr style="border: solid 1px black;">
					<p align="right" style="font-size: 1.4em;">
						총 결제 가격 : <span><%=sumTotalPrice + deliCost%>원</span>
					</p>
					<button id="continue_btn">계속 쇼핑하기</button>
					<button id="purchase_btn">구매 하기</button>
				</div>
			</div>

			<!-- ---------------------------수정 끝---------------------------------- -->
		</div>
		<!--contents끝-->
	</div>
	<!--wrapper:menu+contents 끝-->
	<!-- top버튼 -->
	<div style="position: fixed; bottom: 10px; right: 10px; z-index: 9999;">
		<a href="#top"><img src="/arm/img/top3.png" width="51" height="51"
			border="0" title="위로 이동"></a>
		<!-- 위에있는 이름 top에 있는 위치로 이동함 -->
	</div>

	<!-- 푸터 -->
	<footer>
		<div id="fwrap">
			<div class="fd hidden-xs">
				<!-- 스마트폰 크기에서는 안보이게 -->
				<ul id="fmenu">
					<li class="footMenu"><a href="#">GUIDE</a></li>
					<li class="footMenu"><a href="#">CUSTOMER SERVICE</a></li>
					<li class="footMenu"><a href="#">BANK INFO</a></li>
					<li class="footMenu"><a href="#">DELIVERY</a></li>
				</ul>
			</div>


			<div class="fd">
				<h1>
					<img src="images/전화기.png" width="50" height="40" border="0" alt="">&nbsp;1600-7000
				</h1>
			</div>

			<div class="fd">
				팔로 Follow Me <br> copyright by take ARM<br> All right
				reserved<br>
			</div>

		</div>
	</footer>
</body>
</html>
