<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="member.model.vo.User, purchase.model.vo.Purchase, order.vo.Order, admin.member.model.vo.Member"%>
<%
	User loginUser = (User) session.getAttribute("loginUser");
	Purchase purchase = (Purchase) request.getAttribute("purchase");
	Member member = (Member) request.getAttribute("member");
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

<!-- 아임포트 결제 API -->
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.1.1.js"></script>

<script type="text/javascript">
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
};

	$(function() {
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
		//결제 관련 메서드
		//주문 취소
		$('.cancle_btn').on('click', function() {
			//1.post 방식
			var chk = window.confirm("주문을 취소할 경우 데이터가 모두 사라집니다.\n정말로 취소하시겠습니까?");
			if (chk) {
				var form = document.createElement("form");
				form.method = 'post';
				form.action = '/arm/PurchaseDelete';
				
				var input = document.createElement("input");
				input.type = "hidden";
				input.name = 'purchaseNo';
				input.value = $(".pNo").val();
				$(form).append(input);
				
				$('#body').append(form);
				form.submit();
			}
		});

		//결제하기
		$('.pay_btn').on('click', function() {			
			var IMP = window.IMP;
			IMP.init('imp05535836'); // 'iamport' 대신 부여받은 "가맹점 식별코드"
			var msg = '';
			IMP.request_pay({
				pg : 'html5_inicis', // version 1.1.0부터 지원.
				/*
				'kakao':카카오페이,
				'inicis':이니시스, 'html5_inicis':이니시스(웹표준결제),
				'nice':나이스,
				'jtnet':jtnet,
				'uplus':LG유플러스,
				'danal':다날
				*/
				pay_method : $("#pay_method option:selected").val(), // 'card':신용카드, 'trans':실시간계좌이체, 'vbank':가상계좌, 'phone':휴대폰소액결제
				merchant_uid : 'merchant_'
				+ new Date().getTime(),
				name : '주문번호 : ' + $(".pNo").val(),
				amount : $(".pPrice").val(),
				buyer_email : $(".mEmail").val(),
				buyer_name : $(".mName").val(),
				buyer_tel : $(".mTel").val(),
				buyer_addr : $(".mAddr").val(),
				buyer_postcode : $(".mPost").val()
				}, function(rsp) {
					if (rsp.success) {
						msg = '결제가 완료되었습니다.';
						msg += '고유ID : ' + rsp.imp_uid;
						msg += '상점 거래ID : ' + rsp.merchant_uid;
						msg += '결제 금액 : ' + rsp.paid_amount;
						msg += '카드 승인번호 : ' + rsp.apply_num;

						var form = document.createElement("form");
						form.method = 'post';
						form.action = '/arm/PurchaseUpdate';
						
						var input = document.createElement("input");
						input.type = "hidden";
						input.name = 'purchaseNo';
						input.value = $(".pNo").val();
						$(form).append(input);
						
						$('#body').append(form);
						form.submit();
					} else {
						msg = '결제에 실패하였습니다.';
						msg += '에러내용 : ' + rsp.error_msg;
					}
			});

			window.alert(msg);
		});
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
	background-color: #fed605; /*메인 메뉴 색깔 fc3*/
	padding-right: 2%;
	max-width: 100%;
}

#topMenu ul {
	list-style-type: none;
	padding: 0px;
	margin: 0;
}

#topMenu ul li {
	background-color: #fed605;
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

#pur_step {
	font-size: 1.7em;
	color: #bebebe;
	padding-bottom: 5%;
}

#pur_step .active {
	color: black;
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

.menuLink:hover {
		color: red;
		cursor: pointer;
	}
/*------------------- 최상단 메뉴 끝 -----------*/
#banner {
	margin: 10px auto;
}
/*상단 배너 크기*/
#banner a img {
	max-width: 100%;
	max-height: 70px;
	border: 0;
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
		padding : 0;
		margin : 2px auto;
		test-align : center;
		border : 1px solid orange;
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
#wrapper {
	margin: 0 auto;
	max-width: 1000px;
	height: auto;
}

#cs_menu {
	width: 100%;
	height: 40px;
	background: #fed605;
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
	font-size: 18px;
	font-weight: 900;
	color: black;
	text-decoration: none;
	padding: 5px;
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
	padding-top: 2%;
	min-height: 600px;
	/*background : #ffffcc;*/
}

/* 영수증부분----------------------- */
.bill {
	margin: 0 auto;
	max-width: 400px;
	border: 1px solid #5263bd;
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
					href="/arm/myinfo?userid=<%= loginUser.getUserId() %>">MyPage</a></li>
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
	<div id="banner">
		<!-- 배너클릭시 시작페이지로! -->
		<a href="/arm/mainlist"><img src="/arm/img/banner.png"
			alt="시작페이지로"></a>
	</div>
	<!-- ---------------------------내용 부분------------------------------------ -->
	<div id="wrapper">
		<div id="cs_menu">
			<ul class="cs_navi">
				<!-- ---------------------------수정------------------------------------ -->
				<li><a href="/arm/myinfo?userid=<%= loginUser.getUserId() %>" id = "u_btn">회원정보</a></li>
				<li><a href="/arm/CartView" id="c_btn">장바구니</a></li>
				<li><a href="/arm/PurchaseView" id="bl_btn">구매 내역</a></li>
				<li><a href="/arm/iqlist?userid=<%= loginUser.getUserId() %>" id = "qa_btn">문의 내역</a></li>
				<!-- ---------------------------수정 끝------------------------------------ -->
			</ul>
		</div>
		<!-- cs_menu -->


		<div id="contents">
			<div id="pur_step">
				<label class="step">1. 장바구니</label> &nbsp;> &nbsp; <label
					class="step">2. 주문확인</label> &nbsp;> &nbsp; <label
					class="step active">3. 주문완료 및 결제</label> 
			</div>
			<!-- ---------------------------영수증부분------------------------------------ -->
			<%
				if (purchase != null) {
			%>
			<div class="bill">
				<input type="hidden" value="<%=purchase.getPurchaseNo()%>">
				<table class="bill_head">
					<tr>
						<th>주 문 내 역</th>
					</tr>
				</table>

				<table class="bill_first">
					<tr>
						<th>주문번호</th>
						<td><%=purchase.getPurchaseNo()%></td>
					</tr>

					<tr>
						<th>주문일시</th>
						<td><%=purchase.getPurchaseDate()%></td>
					</tr>

					<tr>
						<th>주문자</th>
						<td>[<%=purchase.getGradeName()%>]&nbsp;<%=purchase.getUserId()%></td>
					</tr>
				</table>


				<table class="bill_second">
					<tr>
						<th>품목</th>
						<th>수량</th>
						<th>합계(원)</th>
						<!-- <th>후기</th> -->
					</tr>
					<%
						for (Order o : purchase.getOrderList()) {
					%>
					<tr>
						<td><%=o.getItem_name()%> - <%=o.getItem_sub_name()%></td>
						<td><%=o.getOrder_qty()%></td>
						<td><%=(int) (o.getOrder_price() * (1 - loginUser.getDiscount()))%></td>
						<%
							//결제 정보가 있고
									if (purchase.getPaid() == 'Y') {
										//작성된 리뷰가 있는 경우
										if (o.getOrder_review_no() > 0) {
						%>
						<td style="text-align: center"><a href=""
							style="color: #1b1b1b;">수정</a></td>
						<%
							} else {
											//작성된 리뷰가 없는 경우
						%>
						<td style="text-align: center;"><a href=""
							style="color: red; font-weight: bold;">작성</a></td>
						<%
							}
									} else {
										//결제 정보가 없는 경우
						%>
						<!-- <td style="text-align: center;"><a href=""
							style="color: red; font-weight: bold;"></a></td> -->
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
						<td><%=purchase.getName()%></td>
					</tr>

					<tr>
						<th>휴대전화</th>
						<td><%=purchase.getPhone()%></td>
					</tr>

					<tr>
						<th>이메일</th>
						<td><%=purchase.getEmail()%></td>
					</tr>
					<tr>
						<th>우편번호</th>
						<td><%=purchase.getZipcode()%></td>
					</tr>
					<%
						String[] addr = purchase.getAddress().split(",");
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
						<td>배송비&nbsp; <span><%=purchase.getDelivery()%>원</span>
						</td>
					</tr>
					<tr>
						<td>총 주문금액&nbsp; <span><%=purchase.getDelivery() + purchase.getTotalItemPrice()%>원</span>
						</td>
					</tr>
				</table>

				<table class="bill_fourth">
					<tr>
						<td>거래상태</td>
					</tr>
					<tr>
						<%
							if (purchase.getPaid() == 'Y') {
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
					if (purchase.getPaid() == 'N') {
				%>
				<table class="bill_pay">
					<tr>
						<th>결제방식</th>
						<td><select id="pay_method">
								<option value="card">카드결제</option>
								<option value="trans">실시간계좌이체</option>
								<option value="vbank">가상계좌</option>
								<option value="phone">휴대폰소액결제</option>
						</select></td>
					</tr>
				</table>
				<div id="buttons">
					<input type="button" class="cancle_btn" value="주문취소"> <input
						type="button" class="pay_btn" value="결제하기">
				</div>
				<input type="hidden" class="pNo" value="<%= purchase.getPurchaseNo() %>">
				<input type="hidden" class="pPrice" value="<%=purchase.getTotalItemPrice() + purchase.getDelivery()%>">
				<input type="hidden" class="mEmail" value="<%=member.getEmail()%>">
				<input type="hidden" class="mName" value="<%=member.getUserName()%>">
				<input type="hidden" class="mTel" value="<%=member.getPhone()%>">
				<input type="hidden" class="mAddr" value="<%=member.getAddress()%>">
				<input type="hidden" class="mPost" value="<%=member.getZipCode()%>">
				<%
					}
				%>
			</div>
			<br> <br>
			<%
				} //end of if (purchase != null)
			%>
			<!-----------------------------------------------------bill 끝-->

			<br> <br> <br>
		</div>
		<!--contents끝-->
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
					<img src="img/tel.png" width="50" height="50" border="0" alt="">&nbsp;1600-7000
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
