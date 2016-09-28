<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page
	import="member.model.vo.User, java.util.ArrayList, cart.model.vo.Cart, org.json.simple.JSONArray"%>
<%
	User loginUser = (User) session.getAttribute("loginUser");
	ArrayList<Cart> cartList = (ArrayList<Cart>) request.getAttribute("cartList");
	JSONArray jsonList = (JSONArray) request.getAttribute("jsonList");
	String errorMsg = (String) request.getAttribute("errorMsg");
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
		//장바구니 관련 메서드---------------------------------------------------------------

		//합계 변경 함수
		function reWriteTable() {

			//ajax로 데이터 송신
			$
					.ajax({
						url : "CartReView",
						type : "POST",
						//수신 완료
						success : function(responseData) {
							//1.테이블 데이터 삭제
							$('#cart_table').empty();
							$('#pay').empty();

							//2.테이블 재작성
							var html = '<table id="cart_top"><tr><td><button id="btn_select_all">전체 선택</button></td></tr></table><table id="cart" align="center" cellspacing="0" cellpadding="10px"><tr><th width="30px"></th><th width="300px">상품 이미지</th><th width="400px">상품설명</th><th width="150px">수량</th><th width="150px">상품가격</th><th width="30px"></th><tr>';

							var json =
<%=jsonList%>
	;
							html += json;

							$('#cart_table').html(html);

							window.alert(json[0].itemName);
							/* for(var i=0; i<jsonObj.cartList.length; i++){
								var obj = jsonObj.cartList[i];
								window.alert(obj);		            	
							}
							var cartList = JSON.parse(responseData);
							for(var cart in cartList){
								window.alert("ㅁㄴㅇㄹ");		            	
							} */
							//3.이벤트 연결
						},
						fail : function() {
							window.alert('테이블 재작성 실패하였습니다.');
							location.reload();
						}
					});
		}

		//전체선택 버튼
		var selected = false;
		$("#btn_select_all").click(function() {
			var checkboxes = document.getElementsByName('ck_item_select');
			if (!selected) {
				for (var i = 0; i < checkboxes.length; i++) {
					checkboxes[i].checked = true;
				}
				selected = true;
			} else if (selected) {
				for (var i = 0; i < checkboxes.length; i++) {
					checkboxes[i].checked = false;
				}
				selected = false;
			}
		});

		//선택 상품 삭제
		$('#ck_remove_btn').on('click', function() {
			var checkedItem = document.getElementsByName('ck_item_select');
			var carts = document.getElementsByName('cart_no');
			var cartNo = new Array();

			for (var i = 0; i < checkedItem.length; i++) {
				if (checkedItem[i].checked) {
					cartNo.push(carts[i].value);
				}
			}

			//체크된 항목이 있으면
			if (cartNo.length > 0) {
				if (confirm("선택한 제품 모두 삭제하시겠습니까?)")) {
					//1.post 방식
					var form = document.createElement("form");
					form.method = 'post';
					form.action = "/arm/CartDeleteSelect";

					var input = document.createElement("input");
					input.type = "hidden";
					input.name = 'cartList';
					input.value = cartNo.toString();
					$(form).append(input);
					$('#body').append(form);

					form.submit();

					//2.ajax 방식
					/* $.ajax({
						url : "CartDeleteSelect",//현재 페이지 새로고침으로 구현중
						type : "POST",
						data : {
							cartList : cartNo.toString()
						},
						success : function() {
							//DB처리 완료시 
							//(미구현)테이블 재작성
							//(임시 처리)
							for (var i = checkedItem.length - 1; i >= 0; i--) {
								window.alert(i);
								if (checkedItem[i].checked) {
									window.alert(checkedItem[i].parent.parent);
								}
							}
						},
						fail : function() {
							window.alert('요청이 실패하였습니다. 다시 시도해주세요.');
						}
					}); */
				}
			} else {
				window.alert('선택한 제품이 없습니다.');
			}
		});

		//수량변경 시
		var qtyList = document.getElementsByName('cart_qty');
		for (var i = 0; i < qtyList.length; i++) {
			qtyList[i].onchange = function() {
				var rowTr = (this).parentElement.parentElement;
				var cartNo = rowTr.children[0].children[0].value;
				var cartQty = rowTr.children[3].children[0].value;

				//서블릿 실행
				//1.post 방식
				var form = document.createElement("form");
				form.method = 'post';
				form.action = "/arm/CartUpdate";

				var input1 = document.createElement("input");
				input1.type = "hidden";
				input1.name = 'cartNo';
				input1.value = cartNo;
				$(form).append(input1);

				var input2 = document.createElement("input");
				input2.type = "hidden";
				input2.name = 'cartQty';
				input2.value = cartQty;
				$(form).append(input2);

				$('#body').append(form);
				form.submit();

				//2.ajax 방식
				/* $.ajax({
					url : "CartUpdate",
					type : "POST",
					data : {
						cartNo : cartNo,
						cartQty : cartQty
					},
					success : function() {
						//(미구현)테이블 제작성
						//reWriteTable();
					},
					fail : function() {
						window.alert('수량 변경이 실패하였습니다.');
						location.reload();
					}
				}); */
			}
		}
		;

		//장바구니 개별 삭제
		var delBtns = document.getElementsByName('cart_del_btn');
		for (var i = 0; i < delBtns.length; i++) {
			delBtns[i].onclick = function() {
				var rowTr = (this).parentElement.parentElement;
				var cartNo = rowTr.children[0].children[0].value;

				//서블릿 실행
				//1.post 방식
				var form = document.createElement("form");
				form.method = 'post';
				form.action = "/arm/CartDelete";

				var input = document.createElement("input");
				input.type = "hidden";
				input.name = 'cartNo';
				input.value = cartNo;
				$(form).append(input);

				$('#body').append(form);
				form.submit();
			}
		}
		;

		//주문하기
		$('#purchase_btn').on('click', function() {
			//1.post 방식
			var form = document.createElement("form");
			form.method = 'post';
			form.action = '/arm/PurchaseCheck';

			$('#body').append(form);
			form.submit();

			//2.ajax 방식
		});
		//장바구니 관련 메서드 끝---------------------------------------------------------------

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

.cart_qty {
	width: 40px;
}

#pay {
	margin: 0 auto;
	margin-top: 3px;
	width: 95%;
	BORDER-BOTTOM: 2px solid black;
}

#pay button#continue_btn, #pay button#ck_remove_btn {
	border: 1px solid green;
	background: green;
	color: white;
	float: left;
}

button#continue_btn {
	margin-top: 3%;
	font-size: 1.4em;
}

#pay #purchase_btn {
	margin-top: 3%;
	border: 1px solid red;
	background: red;
	color: white;
	float: right;
	font-size: 1.4em;
	width: 150px;
}

#pay p .price { /*결제가격 부분(빨간글씨)*/
	font-size: 1.1em;
	font-weight: 900;
}

#pay p .total_price { /*결제가격 부분(빨간글씨)*/
	color: red;
	font-size: 1.4em;
	font-weight: 900;
}
/*-------장바구니끝-----------*/
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
	.img_col {
		display: none;
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
	<%
		if (errorMsg != null) {
	%>
	<script>
		window.alert('<%=errorMsg%>');
	</script>
	<%
		}
	%>
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
					href="//arm/myinfo?userid=<%= loginUser.getUserId() %>">MyPage</a></li>
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
					<label class="step active">1. 장바구니</label> &nbsp;> &nbsp; <label
						class="step">2. 주문확인</label> &nbsp;> &nbsp; <label
						class="step">3. 주문완료 및 결제</label>
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
							<th width="300px" class="img_col">상품 이미지</th>
							<th width="400px">상품설명</th>
							<th width="150px">수량</th>
							<th width="150px">상품가격</th>
							<th width="30px"></th>
						<tr>
							<%
								int deliCost = 0;
								int sumTotalPrice = 0;

								if (cartList != null) {
									deliCost = 2500;
									for (Cart c : cartList) {
										sumTotalPrice += c.getTotal_price();
							%>
						
						<tr class='items'>
							<td><input type="text" name="cart_no" id="cart_no"
								value="<%=String.valueOf(c.getCart_no())%>"
								style="display: none"><input type="checkbox"
								name="ck_item_select"></td>
							<td class="img_col"><img class="item_img"
								src="<%=c.getItem_img_mini()%>"></td>
							<td>상품명:<%=c.getItem_name()%><br>옵션명: <%=c.getItem_sub_name()%>
							</td>
							<td><input type="number" name="cart_qty" id="cart_qty"
								class="cart_qty" min="1" max="99" value="<%=c.getQuantity()%>"></td>
							<td><span class="item_price"><%=c.getItem_price()+c.getItem_sub_price()%></span>원</td>
							<td><input type="button" name="cart_del_btn" value="x"></td>
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
						총 상품가격 <span class="sum_price"><%=sumTotalPrice%></span>원<br>
						회원 할인가 <span class="dis_price" style="color: red"><%=(int) (sumTotalPrice * loginUser.getDiscount())%>원</span><br>
						배송비 <span class="del_price"><%=deliCost%></span>원
					</p>
					<hr style="border: solid 1px black;">
					<p align="right" style="font-size: 1.4em;">
						총 결제 가격 : <span class="total_price"><%=(int) (sumTotalPrice * (1 - loginUser.getDiscount())) + deliCost%></span>원
					</p>
					<button id="continue_btn">계속 쇼핑하기</button>
					<input type="button" id="purchase_btn" value="전체 구매 하기">
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
