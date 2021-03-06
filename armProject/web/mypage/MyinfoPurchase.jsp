<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!doctype html>
<html lang="ko">
  <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
   <title>MyPage:Purchase</title>

  
    <link href="/arm/bootstrap/css/bootstrap.min.css" rel="stylesheet">

   

  <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
  <script src="/arm/bootstrap/js/bootstrap.min.js"></script>
  
  <script type="text/javascript" src = "/arm/js/jquery-3.1.0.min.js"></script>
  <script type="text/javascript">

	
 	$(function(){
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
		border : 1px solid orange;
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

/*---------------------------내용 부분------------------------------------ */
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
	#bl_btn{
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

	#contents {
		width : 100%;
		margin : 0 auto;
		padding-top : 2%;
		min-height : 600px;
		/*background : #ffffcc;*/
	}

	/* 영수증부분----------------------- */

	#t_purchase {width:500px; min-width : 200px; border:1px solid #5263bd; margin:auto;}

	@media all and (max-width: 1000px){
      #t_purchase {
         width:500px;
      }
   }

    @media all and (max-width: 750px){
      #t_purchase {
         width:60%;
      }
	 }
   @media all and (max-width: 300px){
      #t_purchase  {
         width:30%;
      }
   }


	.basicDiv {border:1px solid #5263bd; padding:7px 0; color:#5f6fc2;  text-align:left; }

	.tblTop {border-collapse: collapse; border:1px solid #5263bd; border-bottom:0px;}

	.tblTop td {padding:5px 0 10px 30px; font:bold 24px gulim; color:#5263bd; text-align:center;}
	.titstxt {font:bold 12px gulim; color:#5263bd;}

	.tbl {border-collapse: collapse; border:1px solid #5263bd;}
	.tbl td {border:1px solid #5263bd; padding:4px;}
	.tbl td.titTd {font:bold 14px gulim; color:#5263bd;}
	.tbl th {font:bold 13px gulim; color:#5263bd; border:1px solid #5263bd; background:#f0f1f9; padding:4px;}


	.tbl2 {border-collapse: collapse; border:1px solid #5263bd;}
	.tbl2 .del {font:bold 17px gulim; text-align:right; padding-right:10px; padding-top:7px;}
	.tbl2 .tsum {font:bold 20px gulim; text-align:right; padding-right:10px; padding-top:7px; padding-bottom:7px;}

	.tbl3 {border-collapse: collapse; border:1px solid #5263bd;}
	.tbl3 .sta{font:bold 17px gulim; text-align:left; padding-left:10px; padding-top:7px; color: #5f6fc2;}
	.tbl3 .sta2{font:bold 20px gulim; text-align:right; padding-right:10px; padding-top:7px; padding-bottom: 10px;}

	.tbl .item {font:13px gulim; padding-left:15px;}
	.tbl .article {font:13px gulim; text-align:center;}
	.tbl .sum {font:bold 13px gulim; color:#4b4b4b; text-align:right; padding-right:7px;}
	.tbl .date {font:bold 13px gulim; color:#4b4b4b; text-align:center;}
	.tbl .total {font:bold 13px gulim; color:#4b4b4b; text-align:center; padding-right:7px; }

	/*-------영수증 끝*/
	
/*---------------------------내용 부분 끝--------------------------------- */
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
<!-- ---------------------------내용 부분------------------------------------ -->
<div id="wrapper">
	<div id = "cs_menu">
		<ul class = "cs_navi">
			<li><a href="/arm/mypage/MyinfoCart.jsp" id = "c_btn">장바구니</a></li>
			<li><a href="/arm/mypage/MyinfoPurchase.jsp" id = "bl_btn">구매 내역</a></li>
			<li><a href="/arm/mypage/MyinfoQuestion.jsp" id = "qa_btn">문의 내역</a></li>
			<li><a href="/arm/mypage/MyinfoDetail.jsp" id = "u_btn">회원정보</a></li>
		</ul>
	</div><!-- cs_menu -->


<div id = "contents">
<!-- ---------------------------영수증부분------------------------------------ -->
<div id="t_purchase">
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="tblTop">
    <tr>
      <td>영 수 증</td>
	</tr>
  </table>
  
 <table width="100%" cellpadding="0" cellspacing="0" class="tbl stamp">
    <tr>
       <th width="20%">주문번호</th>
      <td colspan="3" class="txt1">777-77-12345</td>
    </tr>

    <tr>
      <th>성명</th>
      <td colspan="3" align="center">[Gold]김동녕</td>
     </tr>
    
	<tr>
      <th>휴대전화</th>
      <td colspan="3">010-2468-2028</td>
    </tr>
 
    <tr>
      <th>이메일</th>
      <td colspan="3">doxdoxdox@naver.com</td>
    </tr>
	
	<tr>
		<th>거래일시</th>
		<td colspan="3">2016년 9월 9일</td>
	</tr>
</table>

  
  <table width="100%" cellspacing="0" cellpadding="0" class="tbl">
    <tr>
      <th>품목</th>
      <th>수량</th>
      
      <th>금액(원)</th>
    </tr>
    <tr>
      <td class="item">컴퓨터</td>
      <td class="article">2</td>
      <td class="sum">1,050,000</td>
    </tr>
 <tr>
      <td class="item">아이패드</td>
      <td class="article">1</td>
      <td class="sum">500,000</td>
 </tr>
 <tr>
      <td class="item"></td>
      <td class="article">&nbsp;</td>
      <td class="sum"></td>
  </tr>
 <tr>
      <td class="item"></td>
      <td class="article">&nbsp;</td>
      <td class="sum"></td>
  </tr>
 <tr>
      <td class="item"></td>
      <td class="article">&nbsp;</td>
      <td class="sum"></td>
  </tr>
 <tr>
      <td class="item"></td>
      <td class="article">&nbsp;</td>
      <td class="sum"></td>
 </tr>
 <tr>
      <td class="item"></td>
      <td class="article">&nbsp;</td>
      <td class="sum"></td>
 </tr>
  </table>

<table width="100%" cellspacing="0" cellpadding="0" class="tbl2">
<tr>
	<td class = "del">배송비 : 5000원</td>
</tr>
<tr>
	<td class = "tsum">총 결제금액 : 1,550,000원</td>
</tr>
</table>

<table width="100%" cellpadding="0" cellspacing="0" class="tbl stamp">
   	  <tr>
      <th width="20%">주소</th>
      <td colspan="3" align="center">경기도 성남시 분당구 정자로56 106동303호</td>
     </tr>
</table>

<table width="100%" cellspacing="0" cellpadding="0" class="tbl3">
<tr>
	<td class = "sta">거래상태</td>
</tr>
<tr>
	<td class = "sta2">결제완료</td>
</tr>
</table>

  
</div><!-----------------------------------------------------t_purchase 끝-->

</div><!--contents끝-->
</div><!--wrapper:menu+contents 끝-->

<!-- ---------------------------내용 부분 끝---------------------------------- -->
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
    