<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.ArrayList, member.model.vo.User, item.model.vo.*, itemqna.model.vo.Question"%>
<%
  User loginUser = (User)session.getAttribute("loginUser");
  Question question = (Question)session.getAttribute("itemlist");
  
  ArrayList<Question> list = (ArrayList<Question>)request.getAttribute("itemlist");
  ArrayList<Answer> alist = (ArrayList<Answer>)request.getAttribute("answerList");
  String msg = (String)request.getAttribute("msg");
%>
<!doctype html>
<html lang="ko">
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>MyPage:MyQuestion</title>

  
    <link href="/arm/bootstrap/css/bootstrap.min.css" rel="stylesheet">

   

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="/arm/bootstrap/js/bootstrap.min.js"></script>
  
  <script type="text/javascript" src = "/arm/js/jquery-3.1.0.min.js"></script>
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
		function goCart(){
			location.href="/arm/mypage/MyinfoCart.jsp";
		}
		function goMyinfo(){
			location.href="/arm/myinfo?userid=<%= loginUser.getUserId() %>";
		}
//------------------------------------------------------------------------끗---------
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
		$(".qna .question").click(function(){
			$(this).next().slideToggle();
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
/*-------wrapper-------- */
	#wrapper{
		margin: 0 auto;
		max-width : 1000px;
		height : auto;
	}
	#cs_menu{
		width:100%;
		height : 40px;
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
		width : 25%;
		padding : 0;
		position : relative;
		line-height : 30px;
	}
	.cs_navi li a{
		font-size : 18px;
		font-weight:900;
		color : black;
		text-decoration:none;
		padding : 5px;
		display : block;
		
	}
	.cs_navi li a:hover{
		color : white;
		background : rgba(255,0,0,0.8);
		cursor : pointer;
	}
	#qa_btn{
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
	/*contents : 내용 wrapper*/
	#contents{
	
	}
	/* -------------------------내용 css----------------------------------- */


	#qna {
		display : none;
		width :100%;
		min-height : 600px;
		
		margin : 5px auto;
		padding : 5px;
	}
	.qna {
		margin:0 auto;
		BORDER-TOP: 2px solid black;
		BORDER-BOTTOM: 2px solid black;
		background : white;

		width : 80%;
	}
	
	.qna tr th, .qna tr td{
		BORDER-BOTTOM: 1px solid #d9d9d9;
		padding : 10px;
	}
	.qna tr th {
		text-align : center;
	}
	.qna tr td:nth-child(2n+1), .qna tr th:nth-child(2n+1){
		background: #ebebeb;
	}
	.qna .question:hover {
		cursor : pointer;
		background : #ebebeb;
	}
	.qna .answer{
		display : none;
	}

	@media all and (max-width: 1000px){
		#wrapper{
			font-size :
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
 <!-- 최상단 기본메뉴 -->
 <div id = "top_menu">
   <nav id="topMenu" >
        <ul>
			<li class="topMenuLi"><a class="menuLink" href="/arm/nlist">고객센터</a></li>
			<li class="topMenuLi"><a class="menuLink" href="/arm/mypage/MyinfoCart.jsp">장바구니</a></li>
            <li class="topMenuLi"><a class="menuLink" href="/arm/mypage/MyinfoCart.jsp">MyPage</a></li>
            <li class="topMenuLi"><a class="menuLink" href="/arm/logout">로그아웃</a></li>
            <li class="topMenuLi">환영합니다! <%=loginUser.getUserName() %>님</li>
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
			<li><a href="/arm/mypage/MyinfoCart.jsp" id = "c_btn">장바구니</a></li>
			<li><a href="/arm/mypage/MyinfoPurchase.jsp" id = "bl_btn">구매 내역</a></li>
			<li><a href="/arm/iqlist?userid=<%= loginUser.getUserId() %>" id = "qa_btn">문의 내역</a></li>
			<li><a href="/arm/myinfo?userid=<%= loginUser.getUserId() %>" id = "u_btn">회원정보</a></li>
		</ul>
	</div><!-- cs_menu -->


<div id = "contents">
<!-- ---------------------------내용부분------------------------------------ -->
<!-- 내용을 여기에 입력해 주세요 -->
	<div class="qna">
	<h1>MY 문의내역</h1>
	<br>
	
	<form action="/arm/iqlist" method="post">	
		<table class = "qna" cellspacing ="0">
		<tr>
			<th width = "10%">종류</th><th>상품 / 옵션</th><th width = "15%">작성일</th>
		</tr>
		
		<%
		if(list != null) {
		for(Question q:list){	 
		%>
				
		<tr class = "question">
			<td>[문의]</td><td><span style="float:left; font-size:0.5em;">상품 : <%=q.getItem_name() %>&nbsp;&nbsp;/ 옵션 : <%=q.getItem_sub_name() %></span><br>
			<%=q.getContent() %></td>
			<td><%=String.valueOf(q.getDate())%><a href="ItemQnaDeleteServlet?q_no=<%= q.getQuestion_no() %>">삭제하기</a></td>
			
		</tr>
		<tr class = "answer">
			<td>[답변]</td><td colspan ="2"> <%if(q.getAnswer().getContent() !=null){ %><%=q.getAnswer().getContent() %>
			<%}else{ %>답변을 준비중입니다<%} %></td>
		</tr>
		<% }
		} else {%>		
		<tr>
			<td colspan="3"><%= msg %></td>
		</tr>	
		<% } %>
		</table>
		</form>
		<br>
	</div>		
		
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
    