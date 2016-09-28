<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="member.model.vo.User, java.util.ArrayList, purchase.model.vo.Purchase, order.vo.Order"%>
<%
	User loginUser = (User) session.getAttribute("loginUser");
	ArrayList<Purchase> purchaseList = (ArrayList<Purchase>) request.getAttribute("purchaseList");
%>
<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>MyPage:Purchase</title>


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

		/* 결제 관련 메서드 시작---------------------------------- */
		//주문 취소
		$('.cancle_btn')
				.on(
						'click',
						function() {
							var divContent = (this).parentElement.parentElement;
							var purchaseNo = divContent.children[0].value;
							//alert(purchaseNo);

							//post 방식
							var chk = window
									.confirm("주문을 취소할 경우 데이터가 모두 사라집니다.\n정말로 취소하시겠습니까?");
							if (chk) {
								var form = document.createElement("form");
								form.method = 'post';
								form.action = '/arm/PurchaseDelete';

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'purchaseNo';
								input.value = purchaseNo;
								$(form).append(input);

								$('#body').append(form);
								form.submit();
							}
						});

		$('.pay_btn').on('click', function() {
			var divContent = (this).parentElement.parentElement;
			var purchaseNo = divContent.children[0].value;
			//alert(purchaseNo);

			//post 방식
			var chk = window.confirm("결제 페이지로 이동하시겠습니까?");
			if (chk) {
				var form = document.createElement("form");
				form.method = 'post';
				form.action = '/arm/PurchaseToPay';

				var input = document.createElement("input");
				input.type = "hidden";
				input.name = 'purchaseNo';
				input.value = purchaseNo;
				$(form).append(input);

				$('#body').append(form);
				form.submit();
			}
		});
		/* 결제 관련 메서드 끝----------------------------------- */
		/* 슬라이드  시작----------------------------------------*/
		$(".slide-viewer").each(function() {
			var $this = $(this);
			var $group = $this.find('.slide-group');
			var $slides = $this.find('.slide');
			var buttonArray = [];
			var currentIndex = 0;
			var timeout;
			
			var setTime = 10000;
			var btnName = 1;
			
			function advance(){
				clearTimeout(timeout);
				timeout = setTimeout(function(){
					if(currentIndex < ($slides.length-1)){
						move(currentIndex + 1);
					}else{
						move(0);
					}
				}, setTime);
			}
			
			//이동
			function move(newIndex){
				var animateLeft, slideLeft;
				
				advance();
				
				//현재 슬라이드가 보여지고 있거나, 애니메이션이 진행중이면 아무것도 X
				if (currentIndex === newIndex || $group.is(':animated')) {
					return;
				}

				buttonArray[currentIndex].removeClass('active');
				buttonArray[newIndex].addClass('active');

				//목록 좌우 재배치
				if (newIndex > currentIndex) {
					slideLeft = '100%';
					animateLeft = '-100%';
				} else {
					slideLeft = '-100%';
					animateLeft = '100%';
				}
				$slides.eq(newIndex).css({
					left : slideLeft,
					display : 'block'
				});

				$group.animate({
					left : animateLeft
				}, function() {
					$slides.eq(currentIndex).css({
						display : 'none'
					});
					$slides.eq(newIndex).css({
						left : 0
					});
					$group.css({
						left : 0
					});
					currentIndex = newIndex;
				});
			}//end of move()
			
			//버튼 생성
			$.each($slides, function(index){
				var btn = '<button type="button" class="slide-btn">'+btnName+'</button>';
				var $button = $(btn);
				btnName += 1;
				
				if(index === currentIndex){
					$button.addClass('active');
				}
				$button.on('click', function(){
					move(index);
				}).appendTo('.slide-buttons');
				buttonArray.push($button);
			});
			
			advance();
		});//end of $(".slide").each(function() 
		/* 슬라이드  끝-----------------------------------------*/
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

/*---------------------------내용 부분------------------------------------ */
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

#bl_btn {
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
	padding-top: 2%;
	min-height: 600px;
	/*background : #ffffcc;*/
}
/* 슬라이드 처리 부분--------------------------*/
.slide-viewer {
	postion: relative;
	margin-top: 2%;
	margin-bottom: 15%;
}

.slide-group {
	width: 100%;
	position: relative;
}

.slide {
	width: 100%;
	display: none;
	position: absolute;
}

.slide:first-child {
	display: block;
}

.slide-btn {
	margin: 5px;
	background-color: green /* #44c767 */;
	-moz-border-radius: 28px;
	-webkit-border-radius: 28px;
	border-radius: 28px;
	border: 1px solid #18ab29;
	display: inline-block;
	cursor: pointer;
	color: #ffffff;
	font-size: 17px;
	padding: 1px 9px;
	text-decoration: none;
	text-shadow: 0px 1px 0px #2f6627;
	outline: none; /* 클릭후 버튼 잔상 제거 */
}

.slide-btn:hover {
	background-color: white;
	border: 1px solid #18ab29;
	color: black;
}

.slide-btn:active {
	background-color: red /* #44c767 */;
	border: 1px solid red /* #18ab29 */;
}

@media all and (max-width: 300px) {
	.slide-viewer {
		margin-bottom: 30%;
	}
}
/* 슬라이드 처리 부분 끝--------------------------*/

/* 영수증부분----------------------- */
.bill {
	margin: 0 auto;
	max-width: 400px;
	border: 1px solid #5263bd;
	margin-bottom: 10%;
}

.bill {
	margin: 0 auto;
	max-width: 400px;
	border: 1px solid #5263bd;
	margin-bottom: 10%;
}

@media all and (max-width: 750px) {
	.bill {
		width: 90%;
	}
}

th {
	padding-left: 3%;
	padding-right: 3%;
	border: 1px solid #5263bd;
	background: #f0f1f9;
	text-align: center;
	font: bold 0.9em gulim;
	color: #5263bd;
}

td {
	padding-top: 0.5%;
	padding-bottom: 0.5%;
	border: 1px solid #5263bd;
	font-size: 1.1em;
	color: #1b1b1b;
}

.bill_head {
	width: 100%;
}

.bill_head th {
	padding: 3%;
	font-size: 2em;
}

/* 주문자 정보 */
.bill_first {
	width: 100%;
}

.bill_first th {
	width: 20%;
	min-width: 80px;
}
/* 품목 */
.bill_second {
	width: 100%;
	border: 1px solid #5263bd;
}

.bill_second th {
	padding: 2%;
}

.bill_second th:first-child {
	width: 57%;
}

.bill_second th:nth-child(2) {
	width: 8%;
}

.bill_second th:nth-child(3) {
	width: 20%;
}

.bill_second td {
	padding-left: 2%;
	padding-right: 2%;
}

.bill_second td:last-child {
	text-align: right;
}
/* 배송비+주문금액 */
.bill_third {
	width: 100%;
	border: 1px solid #5263bd;
	text-align: right;
}

.bill_third tr:first-child td {
	padding-right: 2%;
	padding-top: 2%;
	border: 0px;
	font: bold 1.1em gulim;
	color: #5f6fc2;
}

.bill_third tr:first-child td span {
	font-size: 1.2em;
	color: #1b1b1b;
}

.bill_third tr:last-child td {
	padding: 2%;
	border: 0px;
	font: bold 1.2em gulim;
	color: #5f6fc2;
}

.bill_third tr:last-child td span {
	font-size: 1.3em;
	color: #1b1b1b;
}
/* 거래상태 */
.bill_fourth {
	width: 100%;
	border: 1px solid #5263bd;
	border-collapse: collapse;
	background: #f0f1f9;
}

.bill_fourth tr:first-child td {
	padding-left: 2%;
	padding-top: 2%;
	border: 0px;
	text-align: left;
	font: bold 1em gulim;
	color: #5f6fc2;
}

.bill_fourth tr:last-child td {
	padding-right: 2%;
	padding-bottom: 2%;
	border: 0px;
	text-align: right;
	font-size: 1.3em;
	font-weight: bold;
}

.bill_pay {
	width: 100%;
	border: 1px solid #5263bd;
}

.bill_pay th {
	width: 20%;
	min-width: 80px;
}

.cancle_paid_btn {
	margin-top: 5px;
	float: left;
	border: 1px solid green;
	background: green;
	color: white;
	font-size: 1.4em;
}

.cancle_btn {
	margin-top: 3%;
	float: left;
	border: 1px solid green;
	background: green;
	color: white;
	font-size: 1.4em;
}

.pay_btn {
	margin-top: 3%;
	float: right;
	border: 1px solid red;
	background: red;
	color: white;
	font-size: 1.4em;
	float: right;
}

/*-------영수증 끝*/
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

footer #fwrap {
	display: table-cell;
	vertical-align: middle;
	text-align: center;
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
	<!-- ---------------------------내용 부분------------------------------------ -->
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


		<div id="contents">
			<!-- ---------------------------영수증부분------------------------------------ -->
			<div class="slide-buttons"></div>
			<div class="slide-viewer">
				<div class="slide-group">
					<!-- bill의 개수에 따라 처리 -->
					<%
						if (purchaseList != null) {
							int i = 1;
							for (Purchase p : purchaseList) {
					%>
					<div class="slide">
						<div class="bill">
							<input type="hidden" value="<%=p.getPurchaseNo()%>">
							<table class="bill_head">
								<tr>
									<th>주 문 내 역</th>
								</tr>
							</table>

							<table class="bill_first">
								<tr>
									<th>주문번호</th>
									<td><%=p.getPurchaseNo()%></td>
								</tr>

								<tr>
									<th>주문일시</th>
									<td><%=p.getPurchaseDate()%></td>
								</tr>

								<tr>
									<th>주문자</th>
									<td>[<%=p.getGradeName()%>]&nbsp;<%=p.getUserId()%></td>
								</tr>
							</table>


							<table class="bill_second">
								<tr>
									<th>품목</th>
									<th>수량</th>
									<th>합계(원)</th>
									<th>후기</th>
								</tr>
								<%
									for (Order o : p.getOrderList()) {
								%>
								<tr>
									<td><%=o.getItem_name()%> - <%=o.getItem_sub_name()%></td>
									<td><%=o.getOrder_qty()%></td>
									<td><%=(int) (o.getOrder_price() * (1 - loginUser.getDiscount()))%></td>
									<%
										//결제 정보가 있고
													if (p.getPaid() == 'Y') {
														//작성된 리뷰가 있는 경우
														if (o.getOrder_review_no() > 0) {
									%>
									<td style="text-align: center"><a href=""
										style="color: #1b1b1b;">수정</a></td>
									<%
										//작성된 리뷰가 없는 경우
														} else {
									%>
									<td style="text-align: center;"><a href=""
										style="color: red; font-weight: bold;">작성</a></td>
									<%
										}
														//결제 정보가 없는 경우
													} else {
									%>
									<td style="text-align: center;"><a href=""
										style="color: red; font-weight: bold;"></a></td>
									<%
										}
									%>
								</tr>
								<%
									} //end of for (Order o : purchase.getOrderList())
								%>
							</table>

							<table class="bill_head">
								<tr>
									<th>배송 정보</th>
								</tr>
							</table>

							<table class="bill_pay">
								<tr>
									<th>수취인</th>
									<td><%=p.getName()%></td>
								</tr>

								<tr>
									<th>휴대전화</th>
									<td><%=p.getPhone()%></td>
								</tr>

								<tr>
									<th>이메일</th>
									<td><%=p.getEmail()%></td>
								</tr>
								<tr>
									<th>우편번호</th>
									<td><%=p.getZipcode()%></td>
								</tr>
								<%
									String[] addr = p.getAddress().split(",");
								%>
								<tr>
									<th>주 &nbsp; 소</th>
									<td><%=addr[0]%></td>
								</tr>
								<tr>
									<th>상세주소</th>
									<td><%=addr[1]%></td>
								</tr>
							</table>

							<table class="bill_third">
								<tr>
									<td>배송비&nbsp; <span><%=p.getDelivery()%>원</span>
									</td>
								</tr>
								<tr>
									<td>총 주문금액&nbsp; <span><%=p.getDelivery() + p.getTotalItemPrice()%>원</span>
									</td>
								</tr>
							</table>

							<table class="bill_fourth">
								<tr>
									<td>거래상태</td>
								</tr>
								<tr>
									<%
										if (p.getPaid() == 'Y') {
									%>
									<td>결제완료</td>
									<%
										} else {
									%>
									<td>주문완료(미결제)</td>
									<%
										}
									%>
								</tr>
							</table>
							<%
								if (p.getPaid() == 'N') {
							%>
							<div id="buttons">
								<input type="button" class="cancle_btn" value="주문취소"> <input
									type="button" class="pay_btn" value="결제하기">
							</div>
							<%
								}
							%>
						</div>
						<!-- class="bill" -->
					</div>
					<!-- class="slide" -->
					<%
					i++;
						} // end of for (Purchase p : purchaseList)
						} //if(purchaseList != null)
						else {
					%>
					<span id="noList">구매 정보가 없습니다.</span>
					<%
						}
					%>

				</div>
				<!-- class="slide-group" -->
			</div>
			<!-- class="slide-viewer" -->
			<!-----------------------------------------------------bill 끝-->
		</div>
		<!-- id="contents" -->
	</div>
	<!--wrapper:menu+contents 끝-->

	<!-- ---------------------------내용 부분 끝---------------------------------- -->
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
