<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="member.model.vo.User, java.util.ArrayList, cart.model.vo.Cart, member.model.vo.Member, java.sql.Date"%>
<%
	User loginUser = (User) session.getAttribute("loginUser");
	ArrayList<Cart> cartList = (ArrayList<Cart>) request.getAttribute("cartList");
	Member member = (Member) request.getAttribute("member");
	int delivery = 2500;
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

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>

<script type="text/javascript" src="/arm/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript">
	//주소api
	function getPostcode() {
		var themeObj = {
			bgColor : "#FFFD80", //바탕 배경색
			searchBgColor : "#FFFFFF", //검색창 배경색
			//contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
			//pageBgColor: "", //페이지 배경색
			textColor : "#333333", //기본 글자색
			//queryTextColor: "", //검색창 글자색
			//postcodeTextColor: "", //우편번호 글자색
			emphTextColor : "#019102", //강조 글자색
			outlineColor : "#FD840E" //테두리
		};
		new daum.Postcode(
				{
					//테마
					theme : themeObj,
					oncomplete : function(data) {
						// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
						// 각 주소의 노출 규칙에 따라 주소를 조합한다.
						// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
						var fullAddr = ''; // 최종 주소 변수
						var extraAddr = ''; // 조합형 주소 변수
						// 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
						if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
							fullAddr = data.roadAddress;
						} else { // 사용자가 지번 주소를 선택했을 경우(J)
							fullAddr = data.jibunAddress;
						}
						// 사용자가 선택한 주소가 도로명 타입일때 조합한다.
						if (data.userSelectedType === 'R') {
							//법정동명이 있을 경우 추가한다.
							if (data.bname !== '') {
								extraAddr += data.bname;
							}
							// 건물명이 있을 경우 추가한다.
							if (data.buildingName !== '') {
								extraAddr += (extraAddr !== '' ? ', '
										+ data.buildingName : data.buildingName);
							}
							// 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
							fullAddr += (extraAddr !== '' ? ' (' + extraAddr
									+ ')' : '');
						}
						document.getElementById('purZipcode').value = data.zonecode; //5자리 새우편번호 사용
						document.getElementById('purAddr1').value = fullAddr;
						// 커서를 상세주소 필드로 이동한다.
						document.getElementById('purAddr2').focus();
					}
				}).open();
	}
	
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
		//주문하기 관련 메서드		
		$('.cancle_btn').on('click', function() {
			//1.post 방식
			var form = document.createElement("form");
			form.method = 'post';
			form.action = '/arm/CartView';

			$('#body').append(form);
			form.submit();
		});

		//폰번호 체크 : 수와 -만 입력가능
		function chkPhone(str) {
			var check = /^.*(?=.{11,16})(?=.*[0-9])(?=.*[-]).*$/;
			if (!check.test(str)) {
				return false;
			}
			return true;
		}
		//이메일 체크 : 영문자, 숫자, @, .
		function chkEmail(str) {
			var check = /^.*(?=.*[0-9])(?=.*[a-zA-Z])(?=.*[_@.]).*$/;
			if (!check.test(str)) {
				return false;
			}
			return true;
		}
		//체크함수
		function checkAll() {
			if ($('#purName').val().length < 3) {
				alert("수취인을 확인해 주세요.(2~15자)");
				$('#purName').focus();
				return false;
			}
			if (!chkPhone($.trim($('#purPhone').val()))) {
				alert("전화번호를 확인해 주세요.(숫자와 '-'포함 11~15자)");
				$('#purPhone').focus();
				return false;
			}
			if (!chkEmail($.trim($('#purEmail').val()))) {
				alert("이메일을 확인해 주세요.");
				$('#purEmail').focus();
				return false;
			}
			if ($('#purEmail').val().indexOf('@') == -1
					|| $('#purEmail').val().indexOf('.') == -1) {
				alert("이메일을 확인해 주세요.");
				$('#purEmail').focus();
				return false;
			}
			if ($('#purZipcode').val().length < 5) {
				alert("우편번호를 입력해 주세요.");
				return false;
			}
			if ($('#purAddr2').val().length < 5) {
				alert("상세주소를 입력해 주세요.");
				$('#purAddr2').focus();
				return false;
			}
			return true;
		}
		;
		//주문
		$('.complete_btn')
				.on(
						'click',
						function() {
							if (checkAll()) {
								var cartNos = document
										.getElementsByClassName('cartNo');
								var itemSubNos = document
										.getElementsByClassName('itemSubNo');
								var itemQtys = document
										.getElementsByClassName('itemQty');
								var itemTotalPrices = document
										.getElementsByClassName('itemTotalPrice');

								var cartNo = cartNos[0].value;
								var itemSubNo = itemSubNos[0].value;
								var itemQty = itemQtys[0].value;
								var itemTotalPrice = itemTotalPrices[0].value;

								if (cartNos.length > 1) {
									for (var i = 1; i < cartNos.length; i++) {
										cartNo += "," + cartNos[i].value;
										itemSubNo += "," + itemSubNos[i].value;
										itemQty += "," + itemQtys[i].value;
										itemTotalPrice += ","
												+ itemTotalPrices[i].value;
									}
								}
								//alert(cartNo + "\n" +itemSubNo+"\n"+itemQty+"\n"+itemTotalPrice);

								//post 방식
								var form = document.createElement("form");
								form.method = 'post';
								form.action = "/arm/PurchaseInsert";

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'cartNo';
								input.value = cartNo;
								$(form).append(input);

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'itemSubNo';
								input.value = itemSubNo;
								$(form).append(input);

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'itemQty';
								input.value = itemQty;
								$(form).append(input);

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'itemTotalPrice';
								input.value = itemTotalPrice;
								$(form).append(input);

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'delivery';
								input.value =
<%=delivery%>
	;
								$(form).append(input);

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'purName';
								input.value = $('#purName').val();
								$(form).append(input);

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'purPhone';
								input.value = $('#purPhone').val();
								$(form).append(input);

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'purEmail';
								input.value = $('#purEmail').val();
								$(form).append(input);

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'purZipcode';
								input.value = $('#purZipcode').val();
								$(form).append(input);

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'purAddr1';
								input.value = $('#purAddr1').val();
								$(form).append(input);

								var input = document.createElement("input");
								input.type = "hidden";
								input.name = 'purAddr2';
								input.value = $('#purAddr2').val();
								$(form).append(input);

								$('#body').append(form);
								form.submit();
							}
						});
		//주문하기 관련 메서드 끝---------------------------------------------------------------
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

/* 수정부분 */
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
#wrapper {
	margin: 0 auto;
	max-width: 1000px;
	height: auto;
}

#cs_menu {
	width: 100%;
	height: 40px;
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

#contents {
	width: 100%;
	margin: 0 auto;
	margin-bottom: 10%;
	padding-top: 2%;
	min-height: 600px;
	padding-top: 2%;
	/*background : #ffffcc;*/
}

/*-------주문하기-----------*/
.purchase {
	margin: 0 auto;
	max-width: 400px;
	border: 1px solid #5263bd;
}

@media all and (max-width: 750px) {
	.purchase {
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

.pur_head {
	width: 100%;
}

.pur_head th {
	padding: 3%;
	font-size: 2em;
}

/* 품목 */
.pur_first {
	width: 100%;
	border: 1px solid #5263bd;
}

.pur_first th {
	padding: 2%;
}

.pur_first th:first-child {
	width: 65%;
}

.pur_first th:nth-child(2) {
	width: 13%;
}

.pur_first th:nth-child(3) {
	width: 22%;
}

.pur_first td {
	padding-left: 2%;
	padding-right: 2%;
}

.pur_first td:last-child {
	text-align: right;
}

/* 배송비+주문금액 */
.pur_second {
	width: 100%;
	border: 1px solid #5263bd;
	text-align: right;
}

.pur_second tr:first-child td {
	padding-right: 2%;
	padding-top: 2%;
	border: 0px;
	font: bold 1.1em gulim;
	color: #5f6fc2;
}

.pur_second tr:first-child td span {
	font-size: 1.2em;
	color: #1b1b1b;
}

.pur_second tr:last-child td {
	padding: 2%;
	border: 0px;
	font: bold 1.2em gulim;
	color: #5f6fc2;
}

.pur_second tr:last-child td span {
	font-size: 1.3em;
	color: #1b1b1b;
}

.pur_third {
	width: 100%;
	border: 1px solid #5263bd;
}

.cancle_btn {
	margin-top: 3%;
	float: left;
	border: 1px solid green;
	background: green;
	color: white;
	font-size: 1.4em;
}

.complete_btn {
	margin-top: 3%;
	float: right;
	border: 1px solid red;
	background: red;
	color: white;
	font-size: 1.4em;
}

/*-------주문하기 끝-----------*/
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

@media all and (max-width: 400px) {
	.cs_navi li a {
		font-size: 11px;
		padding: 10px 0;
	}
	#contents {
		min-width: 200px;
	}
}

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
				<li class="topMenuLi"><a class="menuLink" href="/arm/myinfo?userid=<%= loginUser.getUserId() %>">MyPage</a></li>
	            <li class="topMenuLi"><a class="menuLink" href="/arm/logout">로그아웃</a></li>
	            <li class="topMenuLi">환영합니다! <%=loginUser.getUserName() %>님</li>
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

		<!-- ---------------------------수정------------------------------------ -->
		<div id="contents">

			<!-- 장바구니 -->
			<div id="t_cart">
				<div id="pur_step">
					<label class="step">1. 장바구니</label> &nbsp;> &nbsp; <label
						class="step active">2. 주문확인</label> &nbsp;> &nbsp; <label
						class="step">3. 주문완료 및 결제</label>
				</div>

				<%
					if (cartList != null) {
				%>
				<div class="purchase">
					<table class="pur_head">
						<tr>
							<th>주 문 내 역</th>
						</tr>
					</table>
					<table class="pur_first">
						<tr>
							<th>품목</th>
							<th>수량</th>
							<th>합계(원)</th>
						</tr>
						<%
							int totalPrice = 0;
								for (Cart c : cartList) {
									totalPrice += c.getTotal_price();
						%>
						<tr>
							<input type="hidden" class="cartNo" name="cartNo"
								value="<%=c.getCart_no()%>">
							<input type="hidden" class="itemSubNo" name="itemSubNo"
								value="<%=c.getItem_sub_no()%>">
							<input type="hidden" class="itemQty" name="itemQty"
								value="<%=c.getQuantity()%>">
							<input type="hidden" class="itemTotalPrice" name="itemTotalPrice"
								value="<%=(int) (c.getTotal_price() * (1 - loginUser.getDiscount()))%>">
							<td><%=c.getItem_name()%> - <%=c.getItem_sub_name()%></td>
							<td><%=c.getQuantity()%></td>
							<td><%=(int) (c.getTotal_price() * (1 - loginUser.getDiscount()))%></td>
						</tr>
						<%
							}
						%>
					</table>
					<table class="pur_second">
						<tr>
							<td>배송비&nbsp; <span><%=delivery%>원</span>
							</td>
						</tr>
						<tr>
							<td>총 주문금액&nbsp; <span><%=(int) (totalPrice * (1 - loginUser.getDiscount())) + delivery%>원</span>
							</td>
						</tr>
					</table>
					<table class="pur_head">
						<tr>
							<th>수취인 정보</th>
						</tr>
					</table>
					<table class="pur_third">
						<tr>
							<th>수취인</th>
							<td><input type="text" name="purName" id="purName"
								value="<%=member.getUserName()%>" maxlength="15"
								placeholder="2 ~ 15글자 이상"></td>
						</tr>
						<tr>
							<th>연락처</th>
							<td><input type="tel" name="purPhone" id="purPhone"
								value="<%=member.getPhone()%>" maxlength="15"
								placeholder=" '-' 포함"></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td><input type="email" name="purEmail" id="purEmail"
								value="<%=member.getEmail()%>" maxlength="30"></td>
						</tr>
						<%
							if (member.getZipCode() != null) {
						%>
						<tr>
							<th>우편번호</th>
							<td><input type="text" name="purZipcode" id="purZipcode"
								value="<%=member.getZipCode()%>"><input type="button"
								onclick="getPostcode()" value="우편번호 찾기"></td>
						</tr>
						<%
							} else {
						%>
						<tr>
							<th>우편번호</th>
							<td><input type="text" name="purZipcode" id="purZipcode"
								value="" placeholder="우편번호" readonly><input
								type="button" onclick="getPostcode()" value="우편번호 찾기"></td>
						</tr>
						<%
							}
								if (member.getAddress() != null) {
									String[] address = member.getAddress().split(",");
						%>
						<tr>
							<th>주소</th>
							<td><input type="text" name="purAddr1" id="purAddr1"
								value="<%=address[0]%>" readonly></td>
						</tr>
						<tr>
							<th>상세주소</th>
							<td><input type="text" name="purAddr2" id="purAddr2"
								value="<%=address[1]%>"></td>
						</tr>
						<%
							} else {
						%>
						<tr>
							<th>주소</th>
							<td><input type="text" name="purAddr1" id="purAddr1"
								value="" placeholder="주소" readonly required></td>
						</tr>
						<tr>
							<th>상세주소</th>
							<td><input type="text" name="purAddr2" id="purAddr2"
								value="" placeholder="상세주소" required></td>
						</tr>
						<%
							}
						%>
					</table>
					<div class="buttons">
						<input type="button" class="cancle_btn" value="취소">
						<!-- <input type="button" class="complete_btn" value="주문 하기"> -->
						<input type="button" class="complete_btn" value="주문 하기">
					</div>
				</div>
				<%
					}
				%>
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
