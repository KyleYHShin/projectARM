<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>
<!doctype html>
<html lang="ko">
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <title>회원가입</title>

    <!-- Bootstrap -->
    <link href="/arm/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!--[if lt IE 9]>
      <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
      <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="/arm/bootstrap/js/bootstrap.min.js"></script>
  
  <script type="text/javascript" src = "js/jquery-3.1.0.min.js"></script>
  <script type="text/javascript">
  	function nologinCart(){
	    alert("로그인이 필요합니다");
	}
  	//주소api
  	function getPostcode() {
		  var themeObj = {
		     bgColor: "#FFFD80", //바탕 배경색
		     searchBgColor: "#FFFFFF", //검색창 배경색
		     //contentBgColor: "", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
		     //pageBgColor: "", //페이지 배경색
		     textColor: "#333333", //기본 글자색
		     //queryTextColor: "", //검색창 글자색
		     //postcodeTextColor: "", //우편번호 글자색
		     emphTextColor: "#019102", //강조 글자색
		     outlineColor: "#FD840E" //테두리
		  };
		  new daum.Postcode({
		  //테마
		  	theme : themeObj,
		    oncomplete: function(data) {
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
              if(data.userSelectedType === 'R'){
                  //법정동명이 있을 경우 추가한다.
                  if(data.bname !== ''){
                      extraAddr += data.bname;
                  }
                  // 건물명이 있을 경우 추가한다.
                  if(data.buildingName !== ''){
                      extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                  }
                  // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                  fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
              }

              // 우편번호와 주소 정보를 해당 필드에 넣는다.
              document.getElementById('zcode').value = data.zonecode; //5자리 새우편번호 사용
              document.getElementById('address').value = fullAddr;

              // 커서를 상세주소 필드로 이동한다.
              document.getElementById('address2').focus();
	          }
	        }).open();
	      }
	$(function(){
		$("#userpwd2").keyup(function(){
			if($("#userpwd2").val()!=$("#userpwd1").val()){
				$("#ckpwd").html("비밀번호가 일치하지 않습니다.");
				$("#ckpwd").css("font-size","9pt").css("color","red");
				$("input[type=submit]").attr("disabled", true);
				$("input[type=submit]").css("background", "gray").css("border","gray 1px solid");
			}else{
				$("#ckpwd").html("비밀번호가 일치합니다.");
				$("#ckpwd").css("font-size","9pt").css("color","blue");
				$("input[type=submit]").attr("disabled", false);
				$("input[type=submit]").css("background", "red").css("border","red 1px solid");
			}
		});
		$(document).on("hover",".menuLink", function(){
			$(this).css("color","red"),css("cursor","pointer");
		});
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
	
	#contents {
		width : 100%;
		margin : 0 auto;
		padding-top : 1%;
		min-height : 600px;
		/*background : #ffffcc;*/
	}

	/* -------------------------내용 css----------------------------------- */

	/*소스를 여기에 입력해주세요*/
	#joinTb {
		border: 0px ;
		BORDER-TOP : 2px solid black;
	}
	#joinTb th,td{
		height :35px;
		border : 0px;
		BORDER-TOP : 1px solid #cecece;
	}
	#joinTb th{
		text-align : center;
		width : 150px;
		background : #d9d9d9;
	}
	#joinTb td{
		padding-left : 2%;
		text-align : left;
		width : 400px;
	}
	#joinTb tr:last-of-type td{
		padding-left : 0;
		BORDER-TOP : 2px solid black;
		BORDER-BOTTOM : 0;
	}
	#joinTb button{
		background : green;
		border : 1px solid green;
		color : white;
		float : left;
	}
	#joinTb td input[type=submit]{
		float : right;
		background : red;
		color : white;
		border : 1px solid red;
	}
	#joinTb tr:last-of-type td input[type=button], input[type=reset]{
		background : green;
		color : white;
		border : 1px solid green;
	}
	 @media all and (max-width: 750px){
	 	#joinTb {
	 		font-size : 9pt;
	 	}

	 }

	@media all and (max-width: 300px){
		#joinTb th,td{
			height :30px;
		}
		#joinTb th{
	 		width : 100px;
	 	}
	 	#joinTb td{
	 		width : 200px;
	 	}
	}
	

/*---------------------------내용 부분 (wrapper+css)끝--------------------------------- */
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
			<li class="topMenuLi"><a class="menuLink" href="nlist">고객센터</a></li>
            <li class="topMenuLi"><a class="menuLink" onClick="nologinCart()">장바구니</a></li>
	        <li class="topMenuLi"><a class="menuLink" href="/arm/member/MemberJoin.jsp">회원가입</a></li>
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
	<a href="/arm/mainlist"><img src="/arm/img/banner.png" alt = "시작페이지로"></a>
 </div>
<!-- 카테고리 ~ item 목록 -->
 <div id="wrapper">

 	<div id = "fix_menu">
			<div id="category">
				<ul class="navi">
					<li><a href="/arm/catlist?categoryno=100">손</a>
					<!-- 100 -->
						<ul>
							<li><a href="/arm/catlist?categoryno=110">반지</a></li>
							<li><a href="/arm/catlist?categoryno=120">의료/건강</a></li>
						</ul></li>
					<!-- 손 -->

					<li><a href="/arm/catlist?categoryno=200">손목</a>
					<!-- 200 -->
						<ul>
							<li><a href="/arm/catlist?categoryno=210">팔찌/시계</a></li>
							<li><a href="/arm/catlist?categoryno=220">의료/건강</a></li>
						</ul></li>
					<!-- 손목 -->
					<li><a href="/arm/catlist?categoryno=300">팔목</a>
					<!-- 300 -->
						<ul>
							<li><a href="/arm/catlist?categoryno=310">팔찌/시계</a></li>
							<li><a href="/arm/catlist?categoryno=320">의료/건강</a></li>
						</ul></li>
					<!-- 팔목 -->
					<li><a href="/arm/catlist?categoryno=400">어깨</a>
					<!-- 400 -->
						<ul>
							<li><a href="/arm/catlist?categoryno=410">의류</a></li>
							<li><a href="/arm/catlist?categoryno=420">의료/건강</a></li>
						</ul></li>
					<!-- 어깨 -->

					<li><a id="sch">검색</a></li>
				</ul>
			</div>
	</div><!-- 카테고리 -->
	<div id = "searchbox">
	<form>
	<input type="text" id = "search" name = "search" placeholder = "검색하세요!">&nbsp;&nbsp;<input type="image" id = "schBtn" src = "/arm/img/search2_small.png" width ="25px" height = "25px";>
	</form>
	</div><!-- 검색 -->

	<div id = "sort">
	<a href="#">인기도순</a>&nbsp;&nbsp;
	<a href="#">가격높은순</a>&nbsp;&nbsp;
	<a href="#">가격낮은순</a>&nbsp;&nbsp;
	</div><!-- sort -->
	
	</div><!-- fix_menu(카테고리+검색+정렬) -->
	<div id = "contents">
<h1>회원가입</h1>
<form action= "/arm/mjoin" method="post">
<table id = "joinTb" border = "1" align = "center">
	<tr>
		<th>아 이 디</th><td><input type="text" id="userid" name="userid" required></td>
	</tr>
	<tr>
		<th>이&nbsp; &nbsp; 름</th><td><input type="text" id="username" name="username" required></td>
	</tr>
	<tr>
		<th>비밀번호</th><td><input type="password" id="userpwd1" name="userpwd" required></td>
	</tr>
	<tr>
		<th>비밀번호확인</th><td><input type="password" id="userpwd2" required> <span id="ckpwd"></span></td>
	</tr>
	<tr>
		<th>생&nbsp; &nbsp; 일</th><td><input type="date" name="birthdate"></td>
	</tr>
	<tr>
		<th>전화번호</th><td><input type="tel" name="phone" placeholder="-포함 입력"></td>
	</tr>
	<tr>
		<th>이 메 일</th><td><input type="email" id="email" name="email" required></td>
	</tr>
	<tr>
		<th>성&nbsp; &nbsp; 별</th><td><input type="radio" name="gender" value="M">남&nbsp;
					<input type="radio" name="gender" value="F">여</td>
	</tr>
	<!-- 주소api -->
	<tr>
		<th>우편번호</th>
			<td><input type="text" id="zcode" name="zcode" placeholder="우편번호">
			<input type="button" onclick="getPostcode()" value="우편번호 찾기"></td>
	</tr>
	<tr>
		<th rowspan="2">주&nbsp; &nbsp; 소</th>
		<td><input type="text" id="address" name="address" placeholder="기본주소" size="45"></td>
	</tr>
	<tr>
		<td><input type="text" id="address2" name="address2" placeholder="상세주소" size="45"></td>
	</tr>
	<!-- 주소 api끗-->
	<tr>
		<td colspan="2"><input type="submit" value="가입하기">
		<input type="button" value="취소" onclick="javascipt:history.go(-1);">
		<input type="reset" value="다시작성">
		</td>
	</tr>
</table>
</form>
</div>
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
    