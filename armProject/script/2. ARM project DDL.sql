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
  
  4. 모든 사항을 처리했는데도 문제가 해결되지 않을 경우
    - 콘솔창에 무결성(Integrity)이나 삭제 참조(References) 에러 출력과 같이 
      DDL 문장 자체에 오류가 존재하는 경우를 뜻한다.
      팀장에게 연락한다.

*/-----------------------------------------------------------------------

--초기화
drop sequence seq_notice_no;
drop table notice;
drop table notice_category;

drop sequence seq_FAQ_no;
drop table FAQ;
drop table FAQ_category;

drop sequence seq_answer_no;
drop table answer;

drop sequence seq_question_no;
drop table question;

drop procedure insert_review;
drop trigger trigger_delete_order;
drop trigger trigger_insert_order;
drop sequence seq_order_no;
drop table orders;

drop sequence seq_review_no;
drop table review;
drop table review_head;

drop sequence seq_purchase_no;
drop table purchase;

drop sequence seq_cart_no;
drop table cart;

drop trigger trigger_update_users;
drop trigger trigger_insert_users;
drop table users;

drop procedure insert_item_sub;
drop table item_bridge;

drop sequence seq_item_sub_no;
drop table item_sub;

drop table product_main;

drop sequence seq_item_no;
drop table item;

drop table item_category;

drop sequence seq_vender_id;
drop table vender;

drop table member;

drop table grade;

commit;

------------------------------------------------------------------------
--1.생성
--drop table vender;
create table vender(
  ven_id     number,
  ven_name   varchar2(20 char) not null,
  ven_phone  varchar2(15) not null,
  
  constraint pk_ven_id primary key(ven_id)
  --id 변경시 item 테이블 자동 변경, 삭제시 자동 01번(무속성)으로 변경
);

--2.코멘트
COMMENT ON COLUMN vender.ven_id IS '공급업체 ID';
COMMENT ON COLUMN vender.ven_name IS '공급업체 명';
COMMENT ON COLUMN vender.ven_phone IS '공급업체 전화번호';

--3.시퀀스
--drop sequence seq_vender_id;
create sequence seq_vender_id
  start with 1
  increment by 1
  maxvalue 9999999
  Minvalue 1
  noCycle
  nocache
;

------------------------------------------------------------------------
--1.생성
--drop table item_category;
create table item_category(
  item_category_no   number(3),
  item_category_name varchar2(15 char) not null,
  
  constraint pk_item_category primary key(item_category_no),
  constraint uq_item_category_name unique(item_category_name)
);

--2.코멘트
COMMENT ON COLUMN item_category.item_category_no IS '상품 카테고리 번호';
COMMENT ON COLUMN item_category.item_category_name IS '상품 카테고리 명';

--4.기본 데이터 입력
insert into item_category values( 0, '없음');
insert into item_category values( 100, '손');
insert into item_category values( 200, '손목');
insert into item_category values( 300, '팔꿈치');
insert into item_category values( 400, '어깨');

------------------------------------------------------------------------
--1.생성
--drop table item;
create table item(
  item_no          number, 
  item_name        varchar2(20 char) not null,
  item_cat_no      number(3),
  item_price       number not null,
  item_count       number default 0,
  item_update      date default sysdate,
  item_vender      number,
  item_tag         varchar2(100 char),
  item_img_mini    varchar2(500),
  item_img         varchar2(500),
  item_img_detail  varchar2(500),
  
  constraint pk_item primary key(item_no),
  constraint fk_item_vender foreign key(item_vender)
    references vender(ven_id),
    --판매자가 판매중인 상품이 있을 경우 판매자 데이터 삭제 불가
  constraint fk_item_cat_no foreign key(item_cat_no) 
    references item_category(item_category_no) on delete set null
);

--2.코멘트
COMMENT ON COLUMN item.item_no IS '상품 ID';
COMMENT ON COLUMN item.item_name IS '상품 명';
COMMENT ON COLUMN item.item_cat_no IS '상품 카테고리';
COMMENT ON COLUMN item.item_price IS '상품 가격';
COMMENT ON COLUMN item.item_count IS '상품 조회수';
COMMENT ON COLUMN item.item_update IS '상품 등록일';
COMMENT ON COLUMN item.item_vender IS '상품 판매처';
COMMENT ON COLUMN item.item_img_mini IS '썸네일 주소';
COMMENT ON COLUMN item.item_img IS '메인 이미지 주소';
COMMENT ON COLUMN item.item_img_detail IS '상품 설명 이미지 주소';

--3-1.시퀀스
--drop sequence seq_item_no;
create sequence seq_item_no
  start with 1
  increment by 1
  maxvalue 9999999
  Minvalue 1
  noCycle
  nocache
;

------------------------------------------------------------------------
--1.생성
--drop table product_main;
create table product_main(
  prm_no      number(3),
  prm_item_no number,
  
  constraint pk_product_main primary key(prm_no),
  constraint fk_prm_item_no foreign key(prm_item_no)
    references item(item_no) on delete cascade
);

--2.코멘트
COMMENT ON COLUMN product_main.prm_no IS '메인페이지 출력 순서';
COMMENT ON COLUMN product_main.prm_item_no IS '메인페이지 상품 ID';

------------------------------------------------------------------------
--1.생성
--drop table item_sub;
create table item_sub(
  item_sub_no     number,
  item_sub_name   varchar2(20 char),
  item_sub_price  number,
  quantity        number,
  
  constraint pk_item_sub primary key(item_sub_no)
);
 
--2.코멘트
COMMENT ON COLUMN item_sub.item_sub_no IS '제품 ID';
COMMENT ON COLUMN item_sub.item_sub_name IS '제품 명';
COMMENT ON COLUMN item_sub.item_sub_price IS '제품 가격';
COMMENT ON COLUMN item_sub.quantity IS '재고 수량';

--3.시퀀스
--drop sequence seq_item_sub_no;
create sequence seq_item_sub_no
  start with 1
  increment by 1
  maxvalue 9999999
  Minvalue 1
  noCycle
  nocache
;

--아이템 추가시 하단에 작성되어있는 프로시저를 이용해야 한다.

------------------------------------------------------------------------
--1.생성
--drop table item_bridge;
create table item_bridge(
  item_no     number not null,
  item_sub_no number not null,
  
  constraint fk_item_bridge_item_no foreign key(item_no) 
    references item(item_no),
    --이 제약조건으로 하위 제품이 삭제되기 전까지 상위 상품은 제거할 수 없다.
    --하위 제품 삭제 -> item_bridge 행 삭제 -> 모두 제거 시 -> 상위 제품 삭제 가능
  constraint fk_item_bridge_item_sub_no foreign key(item_sub_no) 
    references item_sub(item_sub_no) on delete cascade
    --하위 제품 삭제시 자동 (링크) 삭제
);
 
--2.코멘트
COMMENT ON COLUMN item_bridge.item_sub_no IS '제품 ID';
COMMENT ON COLUMN item_bridge.item_no IS '상품 ID';

--3.프로시저 : item_sub 데이터 입력시 사용
--drop procedure insert_item_sub;
CREATE OR REPLACE PROCEDURE insert_item_sub
(
    item_no         IN  NUMBER,
    item_sub_name   IN  VARCHAR2,
    item_sub_price  IN  NUMBER,
    quantity        IN  NUMBER
)
IS        
BEGIN
    insert into item_sub values
    (
      seq_item_sub_no.nextval, 
      item_sub_name, 
      item_sub_price, 
      quantity
    );
    insert into item_bridge values
    (
      item_no,
      seq_item_sub_no.currval
    );
END;
/

--item_sub insert 방법
--EXECUTE insert_item_sub(item_no, item_sub_name, item_sub_price, quantity);

------------------------------------------------------------------------
--1.생성
--drop table grade;
create table grade(
  g_no        number(2),
  g_name      varchar2(10 char),
  g_condition number,
  g_discount  number(3,2),
  
  constraint pk_grade primary key(g_no)
);
 
--2.코멘트
COMMENT ON COLUMN grade.g_no IS '등급 번호';
COMMENT ON COLUMN grade.g_name IS '등급 명';
COMMENT ON COLUMN grade.g_condition IS '등급 조건(원)';
COMMENT ON COLUMN grade.g_discount IS '할인율(%)';

--4.기본 데이터 입력
insert into grade values(1, '일반', 0, 0.0);
insert into grade values(2, '브론즈', 20000, 0.01);
insert into grade values(3, '실버', 50000, 0.02);
insert into grade values(4, '골드', 100000, 0.03);
insert into grade values(5, '플레티넘', 500000, 0.04);
insert into grade values(6, '다이아몬드', 1000000, 0.05);

------------------------------------------------------------------------
--1.생성
--drop table member;
create table member(
  m_id        varchar2(15),--숫자,영문자,기호만 가능
  m_pw        varchar2(20) not null,--숫자,영문자,기호만 가능
  m_name      varchar2(15 char) not null,
  m_birth     date not null,
  m_gender    char(1),
  m_phone     varchar2(15) not null,--숫자,기호
  m_email     varchar2(30) not null,--숫자,영문자,기호
  m_zipcode   varchar2(6), --숫자 6개 문자열로 입력
  m_address   varchar2(80 char),
  m_grade     number(2) not null,
  m_joindate  date default sysdate,
  
  constraint pk_member primary key(m_id),
  constraint gender_check check(m_gender in ('M','F')),
  constraint fk_member_grade
    foreign key(m_grade) references grade(g_no) 
);

--2.코멘트
COMMENT ON COLUMN member.m_id IS '아이디';
COMMENT ON COLUMN member.m_pw IS '비밀번호';
COMMENT ON COLUMN member.m_name IS '이름';
COMMENT ON COLUMN member.m_birth IS '생년월일';
COMMENT ON COLUMN member.m_gender IS '성별';
COMMENT ON COLUMN member.m_phone IS '전화번호';
COMMENT ON COLUMN member.m_email IS '이메일';
COMMENT ON COLUMN member.m_zipcode IS '우편번호';
COMMENT ON COLUMN member.m_address IS '주소';
COMMENT ON COLUMN member.m_grade IS '회원 등급';
COMMENT ON COLUMN member.m_joindate IS '가입 날짜';

------------------------------------------------------------------------
--1.생성
--drop table users;
create table users(
  user_id     varchar2(15),
  user_pw     varchar2(20) not null,
  user_name   varchar2(15 char) not null,
  grade_name  varchar2(10 char) not null,
  discount    number(3, 2) not null,
  
  constraint pk_user primary key(user_id),
  constraint fk_user_id foreign key(user_id) 
    references member(m_id) on delete cascade
);
 
--2.코멘트
COMMENT ON COLUMN users.user_id IS '아이디';
COMMENT ON COLUMN users.user_pw IS '비밀번호';
COMMENT ON COLUMN users.user_name IS '이름';
COMMENT ON COLUMN users.grade_name IS '등급';
COMMENT ON COLUMN users.discount IS '할인율';

--3.트리거 : users 입력
--drop trigger trigger_insert_users;
create or replace trigger trigger_insert_users
after insert on member
for each row
begin
  insert into users
  values(:NEW.m_id, :NEW.m_pw, :NEW.m_name, 
        (select g_name from grade where g_no= :NEW.m_grade),
        (select g_discount from grade where g_no=:NEW.m_grade)
        );
end;
/

--3.트리거2 : users 수정
--drop trigger trigger_update_users;
create or replace trigger trigger_update_users
before update on member
for each row
begin
  update users
  set
    user_pw = :NEW.m_pw, 
    user_name = :NEW.m_name, 
    grade_name = (select g_name from grade where g_no= :NEW.m_grade),
    discount = (select g_discount from grade where g_no=:NEW.m_grade)
  where
    user_id = :OLD.m_id;
end;
/

--4.기본 데이터 입력(member, users 동시)
insert into member values('admin','admin','관리자',sysdate,'M','010-7227-4569','shinpeach@naver.com','','',6, sysdate);
insert into member values('user01','pwd01','테스트01',sysdate,'F','010-1111-1111','user01@nate.com','','',1, sysdate);
insert into member values('user02','pwd02','테스트02',sysdate,'M','010-2222-2222','user02@daum.net','02512','서울 동대문구 겸재로 16,,미경아파트 201동 101호',2, sysdate);
insert into member values('user03','pwd03','테스트03',sysdate,'M','010-3333-3333','user03@daum.net','','',3, sysdate);

--member 데이터 수정
--update member set m_grade = 5 where m_id = 'user03';

--member 데이터 삭제
--delete from member where m_id = 'user03';

------------------------------------------------------------------------
--1.생성
--drop table cart;
create table cart(
  cart_no           number(10),
  cart_m_id         varchar2(15) not null,
  cart_item_no      number not null,
  cart_item_sub_no  number not null,
  cart_qty          number(3) default 1,
  
  constraint pk_cart primary key(cart_no),
  constraint fk_cart_m_id foreign key(cart_m_id) 
    references member(m_id) on delete cascade,
  constraint fk_cart_item_no foreign key(cart_item_no) 
    references item(item_no) on delete cascade,
  constraint fk_cart_item_sub_no foreign key(cart_item_sub_no) 
    references item_sub(item_sub_no) on delete cascade
);
 
--2.코멘트
COMMENT ON COLUMN cart.cart_no IS '장바구니 ID';
COMMENT ON COLUMN cart.cart_m_id IS '장바구니 소유자 ID';
COMMENT ON COLUMN cart.cart_item_no IS '상위 상품 ID';
COMMENT ON COLUMN cart.cart_item_sub_no IS '하위 제품 ID';
COMMENT ON COLUMN cart.cart_qty IS '제품 수량';

--3.시퀀스
--drop sequence seq_cart_no;
create sequence seq_cart_no
  start with 1
  increment by 1
  maxvalue 9999999999
  Minvalue 1
  noCycle
  nocache
;

/*--cart 데이터 입력
insert into cart values
(seq_cart_no.nextval, m_id, item_no, item_sub_no, quantity);
*/

------------------------------------------------------------------------
--1.생성
--drop table purchase;
create table purchase(
  purchase_no         number(9),
  purchase_m_id       varchar2(15) not null,
  purchase_name       varchar2(15 char) not null,
  purchase_phone      varchar2(15) not null,
  purchase_email      varchar2(30) not null,
  purchase_zipcode    varchar2(6) not null,
  purchase_address    varchar2(80 char),
  total_price         number(9) not null,
  delivery            number(6) not null,
  purchase_date       date not null,
  paid                char(1),
  
  constraint pk_purchase primary key(purchase_no),
  constraint fk_purchase_m_id foreign key(purchase_m_id) 
    references member(m_id) on delete set null,
  constraint paid_check check(paid in ('Y','N'))
);
 
--2.코멘트
COMMENT ON COLUMN purchase.purchase_no IS '주문 번호';
COMMENT ON COLUMN purchase.purchase_m_id IS '주문자 ID';
COMMENT ON COLUMN purchase.purchase_name IS '배송비';
COMMENT ON COLUMN purchase.purchase_phone IS '제품 총 가격(배송비 제외)';
COMMENT ON COLUMN purchase.purchase_email IS '주문 날짜';
COMMENT ON COLUMN purchase.purchase_zipcode IS '해당 주문 결제 번호';
COMMENT ON COLUMN purchase.purchase_address IS '배송비';
COMMENT ON COLUMN purchase.total_price IS '제품 총 가격(배송비 제외)';
COMMENT ON COLUMN purchase.delivery IS '주문 날짜';
COMMENT ON COLUMN purchase.purchase_date IS '해당 주문 결제 번호';
COMMENT ON COLUMN purchase.paid IS '해당 주문 결제 번호';

--3-1.시퀀스
--drop sequence seq_purchase_no;
create sequence seq_purchase_no
  start with 1
  increment by 1
  maxvalue 999999999
  Minvalue 1
  noCycle
  nocache
;

------------------------------------------------------------------------
--1.생성
--drop table review_head;
create table review_head(
  review_head_no      number(1),
  review_head_content varchar2(10 char),
  
  constraint pk_review_head primary key(review_head_no),
  constraint uk_review_head_content unique(review_head_content)
); 

--2.코멘트
COMMENT ON COLUMN review_head.review_head_no IS '후기 평점';
COMMENT ON COLUMN review_head.review_head_content IS '평점 글';

--4.기본 데이터 입력
insert into review_head values(1, '완전 망했어요ㅠㅠ');
insert into review_head values(2, '음..별로인데');
insert into review_head values(3, '그냥저냥');
insert into review_head values(4, '겁나좋군!');
insert into review_head values(5, '강추!!!');

------------------------------------------------------------------------
--1.생성
--drop table review;
create table review(
  review_no           number(9),
  review_m_id      varchar2(15) not null,
  review_item_no      number not null,
  reivew_item_sub_no  number,
  review_score        number(1) not null,
  review_content      varchar2(600 char) not null,
  review_date         date not null,
  
  constraint pk_review primary key(review_no),
  constraint fk_review_m_id foreign key(review_m_id) 
    references member(m_id) on delete cascade,
  constraint fk_review_item_no foreign key(review_item_no) 
    references item(item_no) on delete cascade,
  constraint fk_reivew_item_sub_no foreign key(reivew_item_sub_no) 
    references item_sub(item_sub_no) on delete set null,
  constraint fk_review_score foreign key(review_score) 
    references review_head(review_head_no)
);
  
--2.코멘트
COMMENT ON COLUMN review.review_no IS '후기 번호';
COMMENT ON COLUMN review.review_m_id IS '후기 작성자 ID';
COMMENT ON COLUMN review.review_item_no IS '후기 상품 ID';
COMMENT ON COLUMN review.reivew_item_sub_no IS '후기 제품 ID';
COMMENT ON COLUMN review.review_score IS '후기 평점';
COMMENT ON COLUMN review.review_content IS '후기 내용';
COMMENT ON COLUMN review.review_date IS '후기 작성 날짜';

--3.시퀀스
--drop sequence seq_review_no;
create sequence seq_review_no
  start with 1
  increment by 1
  maxvalue 999999999
  Minvalue 1
  noCycle
  nocache
;

------------------------------------------------------------------------
--1.생성
--drop table orders;
create table orders(
  order_no          number(10),
  order_purchase_no number(9) not null,
  order_item_sub_no number,
  order_qty         number(3) not null,
  order_review_no   number(9),
  
  constraint pk_orders primary key(order_no),
  constraint fk_order_purchase_no foreign key(order_purchase_no) 
    references purchase(purchase_no) on delete cascade,
  constraint fk_order_item_sub_no foreign key(order_item_sub_no)
    references item_sub(item_sub_no) on delete set null,
  constraint fk_order_review_no foreign key(order_review_no)
    references review(review_no) on delete set null
);

--2.코멘트
COMMENT ON COLUMN orders.order_no IS '주문 상세 번호';
COMMENT ON COLUMN orders.order_purchase_no IS '주문 번호';
COMMENT ON COLUMN orders.order_item_sub_no IS '제품 ID';
COMMENT ON COLUMN orders.order_qty IS '수량';
COMMENT ON COLUMN orders.order_review_no IS '후기 번호';

--3-1.시퀀스
--drop sequence seq_order_no;
create sequence seq_order_no
  start with 1
  increment by 1
  maxvalue 9999999999
  Minvalue 1
  noCycle
  nocache
;

--3-2.트리거 : 주문 완료 후에 재고수량 감소
--drop trigger trigger_insert_order;
create or replace trigger trigger_insert_order
after insert on orders
for each row
begin
  update item_sub
    set
      QUANTITY = QUANTITY - :NEW.order_qty
    where
      item_sub_no = :NEW.order_item_sub_no;
end;
/

--3-3.트리거 : 주문 취소 후에 재고수량 추가
--drop trigger trigger_delete_order;
create or replace trigger trigger_delete_order
after delete on orders
for each row
begin
  update item_sub
    set
      QUANTITY = QUANTITY + :OLD.order_qty
    where
      item_sub_no = :OLD.order_item_sub_no;
end;
/

--3-4.프로시저 : 리뷰 insert + orders update
--DROP PROCEDURE insert_review;
CREATE OR REPLACE PROCEDURE insert_review
(
    new_order_no  IN number,
    m_id          IN varchar2,
    item_no       IN number,
    item_sub_no   IN number,
    score         IN number,
    content       IN varchar2
)
IS        
BEGIN
    insert into review values
    (
      seq_review_no.nextval, 
      m_id, 
      item_no,
      item_sub_no,
      score,
      content,
      sysdate
    );
    update orders
    set
      order_review_no = seq_review_no.currval
    where
      order_no = new_order_no;
END;
/

/*
--1.purchase 데이터 입력
insert into purchase values
(seq_purchase_no.nextval, m_id, total_price, delivery, sysdate, null);
 
--2.주문완료 시 orders 데이터 입력(반복)
insert into orders values
(seq_order_no.nextval, purchase_no, item_sub_no, quantity);
*/
------------------------------------------------------------------------
--1.생성
--drop table question;
create table question(
  question_no           number(9),
  question_m_id         varchar2(15) not null,
  question_item_no      number not null,
  question_item_sub_no  number,
  question_content      varchar2(600) not null,
  question_date         date not null,
  
  constraint pk_question primary key(question_no),
  constraint fk_question_m_id foreign key(question_m_id)
    references member(m_id) on delete cascade,
  constraint fk_question_item_no foreign key(question_item_no) 
    references item(item_no) on delete cascade,
  constraint fk_question_item_sub_no foreign key(question_item_sub_no) 
    references item_sub(item_sub_no) on delete set null
);
 
--2.코멘트
COMMENT ON COLUMN question.question_no IS '문의 번호';
COMMENT ON COLUMN question.question_m_id IS '문의자 ID';
COMMENT ON COLUMN question.question_item_no IS '문의 상품 ID';
COMMENT ON COLUMN question.question_item_sub_no IS '문의 제품 ID';
COMMENT ON COLUMN question.question_content IS '문의 내용';
COMMENT ON COLUMN question.question_date IS '문의 날짜';

--3.시퀀스
--drop sequence seq_question_no;
create sequence seq_question_no
  start with 1
  increment by 1
  maxvalue 999999999
  Minvalue 1
  noCycle
  nocache
;

/*--question 데이터 입력 방법(no, m_id, item_no, item_sub_no, content, date)
insert into question values
(seq_question_no.nextval, 'user02', 1, 1, '정말로 진짜 깁스 같나요?', sysdate);
*/

------------------------------------------------------------------------
--1.생성
--drop table answer;
create table answer(
  answer_no           number(9),
  answer_question_no  number(9) not null,
  answer_content      varchar2(600 char) not null,
  answer_date         date not null,
  
  constraint pk_answer primary key(answer_no),
  constraint fk_answer_question_no foreign key(answer_question_no) 
    references question(question_no) on delete cascade
    --질문 삭제시 답변 자동삭제
);
 
--2.코멘트
COMMENT ON COLUMN answer.answer_no IS '답변 번호';
COMMENT ON COLUMN answer.answer_question_no IS '해당 질문 번호';
COMMENT ON COLUMN answer.answer_content IS '답변 내용';
COMMENT ON COLUMN answer.answer_date IS '답변 날짜';

--3.시퀀스
--drop sequence seq_answer_no;
create sequence seq_answer_no
  start with 1
  increment by 1
  maxvalue 999999999
  Minvalue 1
  noCycle
  nocache
;

/*--answer 데이터 입력 방법(answer_no, answer_question_no, answer_content, answer_date)
insert into answer values
(seq_answer_no.nextval, '1', '네. 실제 병원에서 사용하는 제품입니다^^', sysdate);
*/

------------------------------------------------------------------------
--1.생성
--drop table FAQ_category;
create table FAQ_category(
  FAQ_category_no     number(2),
  FAQ_category_name   varchar2(10 char) not null,
  
  constraint pk_FAQ_category primary key(FAQ_category_no),
  constraint uk_FAQ_category_name unique(FAQ_category_name)
);

--2.코멘트
COMMENT ON COLUMN FAQ_category.FAQ_category_no IS 'FAQ 카테고리 번호';
COMMENT ON COLUMN FAQ_category.FAQ_category_name IS 'FAQ 카테고리 내용';

--4.기본 데이터 입력
insert into FAQ_category values(1, '제품');
insert into FAQ_category values(2, '결제');
insert into FAQ_category values(3, '배송');
insert into FAQ_category values(4, '가입');
insert into FAQ_category values(5, '기타');

------------------------------------------------------------------------
--1.생성
--drop table FAQ;
create table FAQ(
  FAQ_no        number,
  FAQ_cat_no    number(2) not null,
  FAQ_title     varchar2(100 char) not null,
  FAQ_content   varchar2(1000 char) not null,
  FAQ_date      date not null,
  
  constraint pk_FAQ primary key(FAQ_no),
  constraint fk_FAQ_cat_no foreign key(FAQ_cat_no) 
    references FAQ_category(FAQ_category_no)
);
 
--2.코멘트
COMMENT ON COLUMN FAQ.FAQ_no IS 'FAQ 번호';
COMMENT ON COLUMN FAQ.FAQ_cat_no IS 'FAQ 카테고리 번호';
COMMENT ON COLUMN FAQ.FAQ_title IS 'FAQ 글 제목';
COMMENT ON COLUMN FAQ.FAQ_content IS 'FAQ 글 내용';
COMMENT ON COLUMN FAQ.FAQ_date IS 'FAQ 작성날짜';

--3.시퀀스
--drop sequence seq_FAQ_no;
create sequence seq_FAQ_no
  start with 1
  increment by 1
  maxvalue 9999999
  Minvalue 1
  noCycle
  nocache
;

------------------------------------------------------------------------
--1.생성
--drop table notice_category;
create table notice_category(
  notice_category_no    number(2),
  notice_category_name  varchar2(10 char) not null,
  
  constraint pk_notice_category primary key(notice_category_no),
  constraint uk_notice_category_name unique(notice_category_name)
);

--2.코멘트
COMMENT ON COLUMN notice_category.notice_category_no IS '공지 카테고리 번호';
COMMENT ON COLUMN notice_category.notice_category_name IS '공지 카테고리 이름';

--4.기본 데이터 입력
insert into notice_category values(1, '공지');
insert into notice_category values(2, '이벤트');
insert into notice_category values(3, '홈페이지');
insert into notice_category values(4, '시스템');

------------------------------------------------------------------------
--1.생성
--drop table notice;
create table notice(
  notice_no       number,
  notice_cat_no   number(2) not null,
  notice_title    varchar2(100 char) not null,
  notice_content  varchar2(1000 char) not null,
  notice_file     varchar2(500),
  notice_date     date not null,
  
  constraint pk_notice primary key(notice_no),
  constraint fk_notice_cat_no foreign key(notice_cat_no) 
    references notice_category(notice_category_no)
);
 
--2.코멘트
COMMENT ON COLUMN notice.notice_no IS '공지 번호';
COMMENT ON COLUMN notice.notice_cat_no IS '공지 카테고리 번호';
COMMENT ON COLUMN notice.notice_title IS '공지 제목';
COMMENT ON COLUMN notice.notice_content IS '공지 내용';
COMMENT ON COLUMN notice.notice_file IS '공지 첨부파일 주소';
COMMENT ON COLUMN notice.notice_date IS '공지 작성날짜';

--3.시퀀스
--drop sequence seq_notice_no;
create sequence seq_notice_no
  start with 1
  increment by 1
  maxvalue 9999999
  Minvalue 1
  noCycle
;

------------------------------------------------------------------------

commit;








