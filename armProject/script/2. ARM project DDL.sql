/*-----------------------------------------------------------------------

<< DB ���� ���� �ذ� �޴���>>

  1. Dao�� �ִ� sql ���� Ȯ��
    - sql Developer�� �����ؼ� ���� �����غ���.
      ���� ���� �۵��ϴ� ��� Dao �κ��� �����Ѵ�.
    
  2. ���� �����ص� �ذ���� �ʴ� ���
    - '3. ARM project Test DML.sql' ������ ����
      �ۼ��Ǿ� �ִ� DML ���� ������ Ȯ���Ѵ�.
  
  3. DML ������ ���ذ� ���� ���� ���
    - '2. ARM project DDL.sql' ������ ����
      ���̺�/������/���ν��� ���� ����(DDL)�� Ȯ���ϴ�.
  
  4. ��� ������ ó���ߴµ��� ������ �ذ���� ���� ���
    - �ܼ�â�� ���Ἲ(Integrity)�̳� ���� ����(References) ���� ��°� ���� 
      DDL ���� ��ü�� ������ �����ϴ� ��츦 ���Ѵ�.
      ���忡�� �����Ѵ�.

*/-----------------------------------------------------------------------

--�ʱ�ȭ
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
--1.����
--drop table vender;
create table vender(
  ven_id     number,
  ven_name   varchar2(20 char) not null,
  ven_phone  varchar2(15) not null,
  
  constraint pk_ven_id primary key(ven_id)
  --id ����� item ���̺� �ڵ� ����, ������ �ڵ� 01��(���Ӽ�)���� ����
);

--2.�ڸ�Ʈ
COMMENT ON COLUMN vender.ven_id IS '���޾�ü ID';
COMMENT ON COLUMN vender.ven_name IS '���޾�ü ��';
COMMENT ON COLUMN vender.ven_phone IS '���޾�ü ��ȭ��ȣ';

--3.������
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
--1.����
--drop table item_category;
create table item_category(
  item_category_no   number(3),
  item_category_name varchar2(15 char) not null,
  
  constraint pk_item_category primary key(item_category_no),
  constraint uq_item_category_name unique(item_category_name)
);

--2.�ڸ�Ʈ
COMMENT ON COLUMN item_category.item_category_no IS '��ǰ ī�װ� ��ȣ';
COMMENT ON COLUMN item_category.item_category_name IS '��ǰ ī�װ� ��';

--4.�⺻ ������ �Է�
insert into item_category values( 0, '����');
insert into item_category values( 100, '��');
insert into item_category values( 200, '�ո�');
insert into item_category values( 300, '�Ȳ�ġ');
insert into item_category values( 400, '���');

------------------------------------------------------------------------
--1.����
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
    --�Ǹ��ڰ� �Ǹ����� ��ǰ�� ���� ��� �Ǹ��� ������ ���� �Ұ�
  constraint fk_item_cat_no foreign key(item_cat_no) 
    references item_category(item_category_no) on delete set null
);

--2.�ڸ�Ʈ
COMMENT ON COLUMN item.item_no IS '��ǰ ID';
COMMENT ON COLUMN item.item_name IS '��ǰ ��';
COMMENT ON COLUMN item.item_cat_no IS '��ǰ ī�װ�';
COMMENT ON COLUMN item.item_price IS '��ǰ ����';
COMMENT ON COLUMN item.item_count IS '��ǰ ��ȸ��';
COMMENT ON COLUMN item.item_update IS '��ǰ �����';
COMMENT ON COLUMN item.item_vender IS '��ǰ �Ǹ�ó';
COMMENT ON COLUMN item.item_img_mini IS '����� �ּ�';
COMMENT ON COLUMN item.item_img IS '���� �̹��� �ּ�';
COMMENT ON COLUMN item.item_img_detail IS '��ǰ ���� �̹��� �ּ�';

--3-1.������
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
--1.����
--drop table product_main;
create table product_main(
  prm_no      number(3),
  prm_item_no number,
  
  constraint pk_product_main primary key(prm_no),
  constraint fk_prm_item_no foreign key(prm_item_no)
    references item(item_no) on delete cascade
);

--2.�ڸ�Ʈ
COMMENT ON COLUMN product_main.prm_no IS '���������� ��� ����';
COMMENT ON COLUMN product_main.prm_item_no IS '���������� ��ǰ ID';

------------------------------------------------------------------------
--1.����
--drop table item_sub;
create table item_sub(
  item_sub_no     number,
  item_sub_name   varchar2(20 char),
  item_sub_price  number,
  quantity        number,
  
  constraint pk_item_sub primary key(item_sub_no)
);
 
--2.�ڸ�Ʈ
COMMENT ON COLUMN item_sub.item_sub_no IS '��ǰ ID';
COMMENT ON COLUMN item_sub.item_sub_name IS '��ǰ ��';
COMMENT ON COLUMN item_sub.item_sub_price IS '��ǰ ����';
COMMENT ON COLUMN item_sub.quantity IS '��� ����';

--3.������
--drop sequence seq_item_sub_no;
create sequence seq_item_sub_no
  start with 1
  increment by 1
  maxvalue 9999999
  Minvalue 1
  noCycle
  nocache
;

--������ �߰��� �ϴܿ� �ۼ��Ǿ��ִ� ���ν����� �̿��ؾ� �Ѵ�.

------------------------------------------------------------------------
--1.����
--drop table item_bridge;
create table item_bridge(
  item_no     number not null,
  item_sub_no number not null,
  
  constraint fk_item_bridge_item_no foreign key(item_no) 
    references item(item_no),
    --�� ������������ ���� ��ǰ�� �����Ǳ� ������ ���� ��ǰ�� ������ �� ����.
    --���� ��ǰ ���� -> item_bridge �� ���� -> ��� ���� �� -> ���� ��ǰ ���� ����
  constraint fk_item_bridge_item_sub_no foreign key(item_sub_no) 
    references item_sub(item_sub_no) on delete cascade
    --���� ��ǰ ������ �ڵ� (��ũ) ����
);
 
--2.�ڸ�Ʈ
COMMENT ON COLUMN item_bridge.item_sub_no IS '��ǰ ID';
COMMENT ON COLUMN item_bridge.item_no IS '��ǰ ID';

--3.���ν��� : item_sub ������ �Է½� ���
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

--item_sub insert ���
--EXECUTE insert_item_sub(item_no, item_sub_name, item_sub_price, quantity);

------------------------------------------------------------------------
--1.����
--drop table grade;
create table grade(
  g_no        number(2),
  g_name      varchar2(10 char),
  g_condition number,
  g_discount  number(3,2),
  
  constraint pk_grade primary key(g_no)
);
 
--2.�ڸ�Ʈ
COMMENT ON COLUMN grade.g_no IS '��� ��ȣ';
COMMENT ON COLUMN grade.g_name IS '��� ��';
COMMENT ON COLUMN grade.g_condition IS '��� ����(��)';
COMMENT ON COLUMN grade.g_discount IS '������(%)';

--4.�⺻ ������ �Է�
insert into grade values(1, '�Ϲ�', 0, 0.0);
insert into grade values(2, '�����', 20000, 0.01);
insert into grade values(3, '�ǹ�', 50000, 0.02);
insert into grade values(4, '���', 100000, 0.03);
insert into grade values(5, '�÷�Ƽ��', 500000, 0.04);
insert into grade values(6, '���̾Ƹ��', 1000000, 0.05);

------------------------------------------------------------------------
--1.����
--drop table member;
create table member(
  m_id        varchar2(15),--����,������,��ȣ�� ����
  m_pw        varchar2(20) not null,--����,������,��ȣ�� ����
  m_name      varchar2(15 char) not null,
  m_birth     date not null,
  m_gender    char(1),
  m_phone     varchar2(15) not null,--����,��ȣ
  m_email     varchar2(30) not null,--����,������,��ȣ
  m_zipcode   varchar2(6), --���� 6�� ���ڿ��� �Է�
  m_address   varchar2(80 char),
  m_grade     number(2) not null,
  m_joindate  date default sysdate,
  
  constraint pk_member primary key(m_id),
  constraint gender_check check(m_gender in ('M','F')),
  constraint fk_member_grade
    foreign key(m_grade) references grade(g_no) 
);

--2.�ڸ�Ʈ
COMMENT ON COLUMN member.m_id IS '���̵�';
COMMENT ON COLUMN member.m_pw IS '��й�ȣ';
COMMENT ON COLUMN member.m_name IS '�̸�';
COMMENT ON COLUMN member.m_birth IS '�������';
COMMENT ON COLUMN member.m_gender IS '����';
COMMENT ON COLUMN member.m_phone IS '��ȭ��ȣ';
COMMENT ON COLUMN member.m_email IS '�̸���';
COMMENT ON COLUMN member.m_zipcode IS '�����ȣ';
COMMENT ON COLUMN member.m_address IS '�ּ�';
COMMENT ON COLUMN member.m_grade IS 'ȸ�� ���';
COMMENT ON COLUMN member.m_joindate IS '���� ��¥';

------------------------------------------------------------------------
--1.����
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
 
--2.�ڸ�Ʈ
COMMENT ON COLUMN users.user_id IS '���̵�';
COMMENT ON COLUMN users.user_pw IS '��й�ȣ';
COMMENT ON COLUMN users.user_name IS '�̸�';
COMMENT ON COLUMN users.grade_name IS '���';
COMMENT ON COLUMN users.discount IS '������';

--3.Ʈ���� : users �Է�
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

--3.Ʈ����2 : users ����
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

--4.�⺻ ������ �Է�(member, users ����)
insert into member values('admin','admin','������',sysdate,'M','010-7227-4569','shinpeach@naver.com','','',6, sysdate);
insert into member values('user01','pwd01','�׽�Ʈ01',sysdate,'F','010-1111-1111','user01@nate.com','','',1, sysdate);
insert into member values('user02','pwd02','�׽�Ʈ02',sysdate,'M','010-2222-2222','user02@daum.net','02512','���� ���빮�� ����� 16,,�̰����Ʈ 201�� 101ȣ',2, sysdate);
insert into member values('user03','pwd03','�׽�Ʈ03',sysdate,'M','010-3333-3333','user03@daum.net','','',3, sysdate);

--member ������ ����
--update member set m_grade = 5 where m_id = 'user03';

--member ������ ����
--delete from member where m_id = 'user03';

------------------------------------------------------------------------
--1.����
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
 
--2.�ڸ�Ʈ
COMMENT ON COLUMN cart.cart_no IS '��ٱ��� ID';
COMMENT ON COLUMN cart.cart_m_id IS '��ٱ��� ������ ID';
COMMENT ON COLUMN cart.cart_item_no IS '���� ��ǰ ID';
COMMENT ON COLUMN cart.cart_item_sub_no IS '���� ��ǰ ID';
COMMENT ON COLUMN cart.cart_qty IS '��ǰ ����';

--3.������
--drop sequence seq_cart_no;
create sequence seq_cart_no
  start with 1
  increment by 1
  maxvalue 9999999999
  Minvalue 1
  noCycle
  nocache
;

/*--cart ������ �Է�
insert into cart values
(seq_cart_no.nextval, m_id, item_no, item_sub_no, quantity);
*/

------------------------------------------------------------------------
--1.����
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
 
--2.�ڸ�Ʈ
COMMENT ON COLUMN purchase.purchase_no IS '�ֹ� ��ȣ';
COMMENT ON COLUMN purchase.purchase_m_id IS '�ֹ��� ID';
COMMENT ON COLUMN purchase.purchase_name IS '��ۺ�';
COMMENT ON COLUMN purchase.purchase_phone IS '��ǰ �� ����(��ۺ� ����)';
COMMENT ON COLUMN purchase.purchase_email IS '�ֹ� ��¥';
COMMENT ON COLUMN purchase.purchase_zipcode IS '�ش� �ֹ� ���� ��ȣ';
COMMENT ON COLUMN purchase.purchase_address IS '��ۺ�';
COMMENT ON COLUMN purchase.total_price IS '��ǰ �� ����(��ۺ� ����)';
COMMENT ON COLUMN purchase.delivery IS '�ֹ� ��¥';
COMMENT ON COLUMN purchase.purchase_date IS '�ش� �ֹ� ���� ��ȣ';
COMMENT ON COLUMN purchase.paid IS '�ش� �ֹ� ���� ��ȣ';

--3-1.������
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
--1.����
--drop table review_head;
create table review_head(
  review_head_no      number(1),
  review_head_content varchar2(10 char),
  
  constraint pk_review_head primary key(review_head_no),
  constraint uk_review_head_content unique(review_head_content)
); 

--2.�ڸ�Ʈ
COMMENT ON COLUMN review_head.review_head_no IS '�ı� ����';
COMMENT ON COLUMN review_head.review_head_content IS '���� ��';

--4.�⺻ ������ �Է�
insert into review_head values(1, '���� ���߾��Ф�');
insert into review_head values(2, '��..�����ε�');
insert into review_head values(3, '�׳�����');
insert into review_head values(4, '�̳�����!');
insert into review_head values(5, '����!!!');

------------------------------------------------------------------------
--1.����
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
  
--2.�ڸ�Ʈ
COMMENT ON COLUMN review.review_no IS '�ı� ��ȣ';
COMMENT ON COLUMN review.review_m_id IS '�ı� �ۼ��� ID';
COMMENT ON COLUMN review.review_item_no IS '�ı� ��ǰ ID';
COMMENT ON COLUMN review.reivew_item_sub_no IS '�ı� ��ǰ ID';
COMMENT ON COLUMN review.review_score IS '�ı� ����';
COMMENT ON COLUMN review.review_content IS '�ı� ����';
COMMENT ON COLUMN review.review_date IS '�ı� �ۼ� ��¥';

--3.������
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
--1.����
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

--2.�ڸ�Ʈ
COMMENT ON COLUMN orders.order_no IS '�ֹ� �� ��ȣ';
COMMENT ON COLUMN orders.order_purchase_no IS '�ֹ� ��ȣ';
COMMENT ON COLUMN orders.order_item_sub_no IS '��ǰ ID';
COMMENT ON COLUMN orders.order_qty IS '����';
COMMENT ON COLUMN orders.order_review_no IS '�ı� ��ȣ';

--3-1.������
--drop sequence seq_order_no;
create sequence seq_order_no
  start with 1
  increment by 1
  maxvalue 9999999999
  Minvalue 1
  noCycle
  nocache
;

--3-2.Ʈ���� : �ֹ� �Ϸ� �Ŀ� ������ ����
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

--3-3.Ʈ���� : �ֹ� ��� �Ŀ� ������ �߰�
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

--3-4.���ν��� : ���� insert + orders update
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
--1.purchase ������ �Է�
insert into purchase values
(seq_purchase_no.nextval, m_id, total_price, delivery, sysdate, null);
 
--2.�ֹ��Ϸ� �� orders ������ �Է�(�ݺ�)
insert into orders values
(seq_order_no.nextval, purchase_no, item_sub_no, quantity);
*/
------------------------------------------------------------------------
--1.����
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
 
--2.�ڸ�Ʈ
COMMENT ON COLUMN question.question_no IS '���� ��ȣ';
COMMENT ON COLUMN question.question_m_id IS '������ ID';
COMMENT ON COLUMN question.question_item_no IS '���� ��ǰ ID';
COMMENT ON COLUMN question.question_item_sub_no IS '���� ��ǰ ID';
COMMENT ON COLUMN question.question_content IS '���� ����';
COMMENT ON COLUMN question.question_date IS '���� ��¥';

--3.������
--drop sequence seq_question_no;
create sequence seq_question_no
  start with 1
  increment by 1
  maxvalue 999999999
  Minvalue 1
  noCycle
  nocache
;

/*--question ������ �Է� ���(no, m_id, item_no, item_sub_no, content, date)
insert into question values
(seq_question_no.nextval, 'user02', 1, 1, '������ ��¥ �齺 ������?', sysdate);
*/

------------------------------------------------------------------------
--1.����
--drop table answer;
create table answer(
  answer_no           number(9),
  answer_question_no  number(9) not null,
  answer_content      varchar2(600 char) not null,
  answer_date         date not null,
  
  constraint pk_answer primary key(answer_no),
  constraint fk_answer_question_no foreign key(answer_question_no) 
    references question(question_no) on delete cascade
    --���� ������ �亯 �ڵ�����
);
 
--2.�ڸ�Ʈ
COMMENT ON COLUMN answer.answer_no IS '�亯 ��ȣ';
COMMENT ON COLUMN answer.answer_question_no IS '�ش� ���� ��ȣ';
COMMENT ON COLUMN answer.answer_content IS '�亯 ����';
COMMENT ON COLUMN answer.answer_date IS '�亯 ��¥';

--3.������
--drop sequence seq_answer_no;
create sequence seq_answer_no
  start with 1
  increment by 1
  maxvalue 999999999
  Minvalue 1
  noCycle
  nocache
;

/*--answer ������ �Է� ���(answer_no, answer_question_no, answer_content, answer_date)
insert into answer values
(seq_answer_no.nextval, '1', '��. ���� �������� ����ϴ� ��ǰ�Դϴ�^^', sysdate);
*/

------------------------------------------------------------------------
--1.����
--drop table FAQ_category;
create table FAQ_category(
  FAQ_category_no     number(2),
  FAQ_category_name   varchar2(10 char) not null,
  
  constraint pk_FAQ_category primary key(FAQ_category_no),
  constraint uk_FAQ_category_name unique(FAQ_category_name)
);

--2.�ڸ�Ʈ
COMMENT ON COLUMN FAQ_category.FAQ_category_no IS 'FAQ ī�װ� ��ȣ';
COMMENT ON COLUMN FAQ_category.FAQ_category_name IS 'FAQ ī�װ� ����';

--4.�⺻ ������ �Է�
insert into FAQ_category values(1, '��ǰ');
insert into FAQ_category values(2, '����');
insert into FAQ_category values(3, '���');
insert into FAQ_category values(4, '����');
insert into FAQ_category values(5, '��Ÿ');

------------------------------------------------------------------------
--1.����
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
 
--2.�ڸ�Ʈ
COMMENT ON COLUMN FAQ.FAQ_no IS 'FAQ ��ȣ';
COMMENT ON COLUMN FAQ.FAQ_cat_no IS 'FAQ ī�װ� ��ȣ';
COMMENT ON COLUMN FAQ.FAQ_title IS 'FAQ �� ����';
COMMENT ON COLUMN FAQ.FAQ_content IS 'FAQ �� ����';
COMMENT ON COLUMN FAQ.FAQ_date IS 'FAQ �ۼ���¥';

--3.������
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
--1.����
--drop table notice_category;
create table notice_category(
  notice_category_no    number(2),
  notice_category_name  varchar2(10 char) not null,
  
  constraint pk_notice_category primary key(notice_category_no),
  constraint uk_notice_category_name unique(notice_category_name)
);

--2.�ڸ�Ʈ
COMMENT ON COLUMN notice_category.notice_category_no IS '���� ī�װ� ��ȣ';
COMMENT ON COLUMN notice_category.notice_category_name IS '���� ī�װ� �̸�';

--4.�⺻ ������ �Է�
insert into notice_category values(1, '����');
insert into notice_category values(2, '�̺�Ʈ');
insert into notice_category values(3, 'Ȩ������');
insert into notice_category values(4, '�ý���');

------------------------------------------------------------------------
--1.����
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
 
--2.�ڸ�Ʈ
COMMENT ON COLUMN notice.notice_no IS '���� ��ȣ';
COMMENT ON COLUMN notice.notice_cat_no IS '���� ī�װ� ��ȣ';
COMMENT ON COLUMN notice.notice_title IS '���� ����';
COMMENT ON COLUMN notice.notice_content IS '���� ����';
COMMENT ON COLUMN notice.notice_file IS '���� ÷������ �ּ�';
COMMENT ON COLUMN notice.notice_date IS '���� �ۼ���¥';

--3.������
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








