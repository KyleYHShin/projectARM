<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="member.model.vo.User, member.model.vo.Member, java.sql.Date"%>
   <%
   	User loginUser = (User)session.getAttribute("loginUser");
   Member member = (Member)request.getAttribute("member");
   %>
<!doctype html>
<html lang="ko">
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>MyPage:MyInfo</title>

  
    <link href="/arm/bootstrap/css/bootstrap.min.css" rel="stylesheet">

   

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="/arm/bootstrap/js/bootstrap.min.js"></script>
 
  <script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
  <script type="text/javascript" src = "/arm/js/jquery-3.1.0.min.js"></script>
  <script type="text/javascript">
//--------------------------------------------------------------최근본 목록-----이슬작성-------
		function viewRecentItem(){
			//sessionStorage.clear();
			var rItems = "";
			if(sessionStorage.length==0){
				$("#recent_list").html("<div class='ritem'>최근 본 상품이 없습니다.</div>");
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
		function goCart(){
			location.href="/arm/mypage/MyinfoCart.jsp";
		}
		function goMyinfo(){
			location.href="/arm/myinfo?userid=<%= loginUser.getUserId() %>";
		}
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
	 max-height:100px;
	 border:0;
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
/*-------wrapper-------- */
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
		width : 25%;
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
	#u_btn{
		color : white;
		background : red;

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

	/*contents : 내용 wrapper*/
	#contents {
		width : 100%;
		margin : 0 auto;
		padding-top : 1%;
		min-height : 600px;
		/*background : #ffffcc;*/
	}

	/* -------------------------내용 css----------------------------------- */

	/*소스를 여기에 입력해주세요*/
	#infoTb {
		border: 0px ;
		BORDER-TOP : 2px solid black;
	}
	#infoTb th,td{
		height :35px;
		border : 0px;
		BORDER-TOP : 1px solid #cecece;
	}
	#infoTb th{
		text-align : center;
		width : 150px;
		background : #d9d9d9;
	}
	#infoTb td{
		padding-left : 2%;
		text-align : left;
		width : 400px;
	}
	#infoTb tr:last-of-type td{
		padding: 0;
		BORDER-TOP : 2px solid black;
		BORDER-BOTTOM : 0;
	}
	#infoTb td a{
		display : block;
		text-align : center;
		background : green;
		border : 1px solid green;
		color : white;
		float : left;
		text-decoration:none;
		width : 70px;
		line-height : 20px;
	}
	#infoTb td input[type=submit]{
		float : right;
		background : red;
		color : white;
		border : 1px solid red;
	}
	 @media all and (max-width: 750px){
	 	#infoTb {
	 		font-size : 9pt;
	 	}

	 }

	@media all and (max-width: 300px){
		#infoTb th,td{
			height :30px;
		}
		#infoTb th{
	 		width : 100px;
	 	}
	 	#infoTb td{
	 		width : 200px;
	 	}
	}
	#infoTb input[readonly] {
		border : 0;
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
 <!-- 최상단 기본메뉴 -->
 <div id = "top_menu">
   <nav id="topMenu" >
        <ul>
			<li class="topMenuLi"><a class="menuLink" href="nlist">고객센터</a></li>
			<li class="topMenuLi"><a class="menuLink" href="/arm/mypage/MyinfoCart.jsp">장바구니</a></li>
            <li class="topMenuLi"><a class="menuLink" href="logout">로그아웃</a></li>
            <li class="topMenuLi">환영합니다! <%=loginUser.getUserName() %>님</li>
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
			<li><a href="/arm/mypage/MyinfoCart.jsp" id = "c_btn">장바구니</a></li>
			<li><a href="/arm/mypage/MyinfoPurchase.jsp" id = "bl_btn">구매 내역</a></li>
			<li><a href="/arm/mypage/MyinfoQuestion.jsp" id = "qa_btn">문의 내역</a></li>
			<li><a href="../myinfo?userid=<%= loginUser.getUserId() %>" id = "u_btn">회원정보</a></li>
		</ul>
	</div><!-- cs_menu -->
<div id = "contents">
<!-- ---------------------------내용부분------------------------------------ -->
<!-- 내용을 여기에 입력해 주세요 -->
<h1>My Page</h1>
<form action= "/arm/mupdate" method="post">
<table id = "infoTb" border = "1" align = "center">
	<tr>
		<th>이&nbsp; &nbsp; 름</th><td><input type="text" name="username" value="<%= member.getUserName() %>" readonly></td>
	</tr>
	<tr>
		<th>아 이 디</th><td><input type="text" name="userid" value="<%= member.getUserId() %>" readonly></td>
	</tr>
	<tr>
		<th>비밀번호</th><td><input type = "password" id="userpwd1" name="password" required></td>
	</tr>
	<tr>
		<th>비밀번호확인</th><td><input type = "password" id="userpwd2" name="password1" required> <span id="ckpwd"></span></td>
	</tr>
	<tr>
		<th>생&nbsp; &nbsp; 일</th><td><%= member.getBirthDate() %></td>
	</tr>
	<tr>
		<th>전화번호</th><td><input type="tel" name="phone" value="<%= member.getPhone() %>"></td>
	</tr>
	<tr>
		<th>이 메 일</th><td><input type="email" name="email" value="<%= member.getEmail() %>"></td>
	</tr>
	<tr>
		<th>성&nbsp; &nbsp; 별</th><td><%= member.getGender() %></td>
	</tr>
	<!-- 주소api -->
	<tr>
		<th>우편번호</th>
	<% if(member.getZipCode()!=null){ %>
		<td><input type="text" id="zcode" name="zcode" value="<%= member.getZipCode() %>">
	<% }else{ %>
		<td><input type="text" id="zcode" name="zcode" placeholder="우편번호">
	<% } %>
			<input type="button" onclick="getPostcode()" value="우편번호 찾기"></td>
	</tr>
	<tr>
		<th rowspan="2">주&nbsp; &nbsp; 소</th>
	<%
		String addr = member.getAddress();
		if(addr != null){
			String[] address = addr.split(",");
	%>
		<td><input type="text" id="address" name="address" value="<%= address[0] %>" size="45"></td>
	</tr>
	<tr>
		<td><input type="text" id="address2" name="address2" value="<%= address[1] %>" size="45"></td>
	</tr>
	<%	}else{
	%>
		<td><input type="text" id="address" name="address" placeholder="기본주소" size="45"></td>
	</tr>
	<tr>
		<td><input type="text" id="address2" name="address2" placeholder="상세주소" size="45"></td>
	</tr>
	<%	} %>
	<!-- 주소 api끗-->
	<tr>
		<th>회원등급</th>
		<td><%
			String gradeString= null;
			switch(member.getGrade()){
			case 1 : gradeString = "일반 회원"; break;
			case 2 : gradeString = "브론즈 회원"; break;
			case 3 : gradeString = "실버 회원"; break;
			case 4 : gradeString = "골드 회원"; break;
			case 5 : gradeString = "플레티넘 회원"; break;
			case 6 : gradeString = "다이아몬드 회원"; break;
			default : gradeString = "새싹 회원"; break;
			}%>
			<%= gradeString %>
		</td>
	</tr>
	<tr>
		<th>가 입 일</th><td><%= member.getJoinDate() %></td>
	</tr>
	<tr>
		<td colspan="2"><a href="mdel?userid=<%= member.getUserId() %>">탈퇴하기</a>
		<input type = "submit" value="수정하기">
		</td>
	</tr>
</table>
</form>
<!-----------------------------------------------------내용 끝-->
</div><!--contents끝-->
</div><!--wrapper:menu+contents 끝-->
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
    