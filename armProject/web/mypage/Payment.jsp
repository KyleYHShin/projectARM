<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="member.model.vo.User"%>
<%
	User loginUser = (User) session.getAttribute("loginUser");
	int purchaseNo = Integer.parseInt(request.getParameter("purchaseNo"));
	int totalPrice = Integer.parseInt(request.getParameter("totalPrice"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>결제 페이지</title>

<script type="text/javascript" src="/arm/js/jquery-3.1.0.min.js"></script>
<!-- 아임포트 결제 API -->
<script type="text/javascript" src="https://service.iamport.kr/js/iamport.payment-1.1.1.js"></script>
<script type="text/javascript">
	$(function() {

		$('.pay_btn').on('click', function() {
			var pm = $("#pay_method option:selected").val();
			var price =<%=totalPrice%>;
			window.alert(pm + "- " + price);
			
			var IMP = window.IMP;
			IMP.init('imp05535836'); // 'iamport' 대신 부여받은 "가맹점 식별코드"
			window.alert('IMP세팅 완료');

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
				pay_method : $("#pay_method option:selected").val(), 
				// 'card':신용카드, 'trans':실시간계좌이체, 'vbank':가상계좌, 'phone':휴대폰소액결제
				merchant_uid : 'merchant_' + new Date().getTime(),
				name : '주문번호 : ',
				amount : 1400,
				
				buyer_email : 'iamport@siot.do',
				buyer_name : '신연호',
				buyer_tel : '010-1234-5678',
				buyer_addr : '서울특별시 강남구 삼성동',
				buyer_postcode : '123-456'[p[[]]]]
				
			}, function(rsp) {
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '상점 거래ID : ' + rsp.merchant_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				window.alrt(msg);
			});
		});
	});
</script>
<style type="text/css">
body {
	min-width: 240px;
}
</style>

</head>
<body>
	<div>
		<form action="" method="post">
			<table>
				<tr>
					<th>주문자</th>
					<td><%=loginUser.getUserId()%>(<%=loginUser.getUserName()%>)님</td>
				</tr>
				<tr>
					<th>주문번호</th>
					<td><%=purchaseNo%></td>
				</tr>
				<tr>
					<th>결제방식</th>
					<td><select id="pay_method">
							<option value="card">카드결제</option>
							<option value="trans">실시간계좌이체</option>
							<option value="vbank">가상계좌</option>
							<option value="phone">휴대폰소액결제</option>
					</select></td>
				</tr>
				<tr>
					<th>결제금액</th>
					<td><%=totalPrice%></td>
				</tr>
			</table>
			<input type="button" class="cancle_btn" value="결제 취소"> <input
				type="button" class="pay_btn" value="결제 완료">
		</form>
	</div>
</body>
</html>