/*-----------------------------------------------------------------------

<< DB 참조 에러 해결 메뉴얼>>

  1. Dao에 있는 sql 문장 확인
    - sql Developer로 복사해서 직접 실행해본다.
      문제 없이 작동하는 경우 Dao 부분을 수정한다.
    
  2. 직접 실행해도 해결되지 않는 경우
    - '3. ARM project Test DML.sql' 파일을 열어
      작성되어 있는 DML 구문 사용법을 확인한다.
  
  3. DML 구문이 이해가 가지 않을 경우
    - '2. ARM project DDL.sql' 파일을 열어
      테이블/시퀀스/프로시저 등의 정의(DDL)를 확인하다.
  
  3. 모든 사항을 처리했는데도 문제가 해결되지 않을 경우
    - 콘솔창에 무결성(Integrity)이나 삭제 참조(Refferences) 에러 출력과 같이 
      DDL 문장 자체에 오류가 존재하는 경우를 뜻한다.
      팀장에게 연락한다.

*/-----------------------------------------------------------------------

--vender 테스트용 데이터
insert into vender values(seq_vender_id.nextval, '(주)삼익', '010-7222-7333');
insert into vender values(seq_vender_id.nextval, '개미는 뚠뚜', '010-1345-4567');
insert into vender values(seq_vender_id.nextval, '(주)영진상사', '02-5636-8228');

--item 테스트용 데이터
insert into item values
(seq_item_no.nextval, '눈속임 깁스', 300, 20000, 0, sysdate, 1, '팔,깁스,명절,주부',
'섬네일 이미지 주소', '메인 이미지 주소', '설명 이미지 주소');
insert into item values
(seq_item_no.nextval, '일개미 팔찌', 200, 1500, 0, sysdate, 2, '악세사리,소품',
'섬네일 이미지 주소', '메인 이미지 주소', '설명 이미지 주소');
insert into item values
(seq_item_no.nextval, '스마트폰 터치 보온 장갑', 100, 9900, 0, sysdate, 3, '겨울,보온,터치',
'섬네일 이미지 주소', '메인 이미지 주소', '설명 이미지 주소');

--product_main 테스트용 데이터
insert into product_main values(1, 2);
insert into product_main values(2, 3);
insert into product_main values(3, 1);

--item_sub 테스트용 데이터
EXECUTE insert_item_sub(1, '초록색', 0, 20);
EXECUTE insert_item_sub(1, '흰색', 1000, 10);
EXECUTE insert_item_sub(1, '검정색', 1000, 10);
EXECUTE insert_item_sub(2, '기본색', 0, 200);
EXECUTE insert_item_sub(3, '기본색', 0, 100);
EXECUTE insert_item_sub(3, '벙어리-빨강', 2000, 50);
EXECUTE insert_item_sub(3, '벙어리-검정', 2000, 50);

---------------------------------------------------------------------

--cart 테스트용 데이터
insert into cart values(seq_cart_no.nextval, 'user01', 1, 1, 2);
insert into cart values(seq_cart_no.nextval, 'user01', 2, 4, 1);
insert into cart values(seq_cart_no.nextval, 'user02', 1, 2, 3);
insert into cart values(seq_cart_no.nextval, 'user02', 3, 6, 1);

---------------------------------------------------------------------

/* 주문 내역
  1	눈속임 깁스	20000원 - 1	초록색	0원	1개
  2	일개미 팔찌	1500원	- 4	기본색	0원 2개
*/

--1. 주문
--매일 정시에 주문한지 특정기간이 지났는데도 결제가 없는 경우 자동 삭제 쿼리문 필요
insert into purchase values(seq_purchase_no.nextval, 'user01', 23000, 2500, sysdate, null);
insert into purchase values(seq_purchase_no.nextval, 'user02', 9900, 2500, sysdate, null);

--2. 주문 완료 : 해당 주문 상세 데이터 추가(java에서 service~dao 반복처리)
insert into orders values(seq_order_no.nextval, 1, 1, 1);
insert into orders values(seq_order_no.nextval, 1, 4, 2);
insert into orders values(seq_order_no.nextval, 2, 5, 1);

--3. 결제 완료 : 해당 주문 정보 수정
EXECUTE insert_payment(1, 'user01', '카드결제', '신한카드', 25500);
EXECUTE insert_payment(2, 'user02', '계좌이체', '하나은행', 12400);

---------------------------------------------------------------------

--question 테스트용 데이터
insert into question values(seq_question_no.nextval, 'user02', 1, 1, '정말로 진짜 깁스 같나요?', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 1, '네. 실제 병원에서 사용하는 제품입니다^^', sysdate);

--answer 데이터 삭제 -> question의 answer_no가 null로 됨을 확인
--delete from answer where Answer_No=1;

--answer 데이터 수정
--update answer set answer_content='네. 실제 병원에서 사용하는 제품이랍니다! ^^' where answer_no = 2;

---------------------------------------------------------------------

--review 테스트용 데이터
insert into review values(seq_review_no.nextval, 'user01', 1, 1, 4, '이번 명절에 사용했는데 진짜 다 속았어요!! 헤헤', sysdate);
insert into review values(seq_review_no.nextval, 'user02', 3, 5, 5, '터치도 잘되고 따듯해요!!', sysdate);

---------------------------------------------------------------------

--FAQ 테스트용 데이터
insert into FAQ values(seq_FAQ_no.nextval, 1, 
'제품에 하자가 있는데 어떻게 해야 하나요?', 
'아래 담당자에게 문의해주시면 빠르게 해결해 드리겠습니다. 손목 : 010-1010-1010, 팔꿈치 : 010-2020-2020',
sysdate);
insert into FAQ values(seq_FAQ_no.nextval, 2, 
'결제가 제대로 되지 않습니다.', 
'결제 프로그램을 다시 설치해주시고 그래도 되지 않는 경우에는 다른 결제방법을 선택해주세요.', 
sysdate);
insert into FAQ values(seq_FAQ_no.nextval, 3, 
'배송 번호가 확인 되지 않습니다.', 
'현재 시스템상 확인이 불가하여 문자로 발송해드리고 있습니다.', 
sysdate);
insert into FAQ values(seq_FAQ_no.nextval, 4, 
'가입 시 모든 항목을 다 채워야만 하나요?', 
'아닙니다. 필수항목이라고 표시한 부분만 작성하시면 됩니다.^^', 
sysdate);

---------------------------------------------------------------------

--notice 테스트용 데이터
insert into notice values(seq_notice_no.nextval, 1, 
'사이트가 개설되었습니다.', '앞으로 많은 사랑 부탁드립니다!',
null, sysdate);
insert into notice values(seq_notice_no.nextval, 2, 
'오픈기념 배송비 무료 이벤트!', '모든 주문에서 배송비가 제외됩니다.',
null, sysdate);

---------------------------------------------------------------------
--개인용 DML(구문) 작성--


insert into cart values(seq_cart_no.nextval, 'user01', 1, 1, 10);
insert into cart values(seq_cart_no.nextval, 'user01', 2, 4, 1);
commit;

insert into cart values(seq_cart_no.nextval, 'user02', 1, 2, 3);
insert into cart values(seq_cart_no.nextval, 'user02', 3, 6, 1);
commit;



commit;

select item_name, item_img_mini, item_price, item_sub_name, item_sub_price
from item_bridge
left join item using(item_no)
left join item_sub using(item_sub_no)
where item_sub_no = 3;


