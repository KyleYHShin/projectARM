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
  
  3. ��� ������ ó���ߴµ��� ������ �ذ���� ���� ���
    - �ܼ�â�� ���Ἲ(Integrity)�̳� ���� ����(Refferences) ���� ��°� ���� 
      DDL ���� ��ü�� ������ �����ϴ� ��츦 ���Ѵ�.
      ���忡�� �����Ѵ�.

*/-----------------------------------------------------------------------

--vender �׽�Ʈ�� ������
insert into vender values(seq_vender_id.nextval, '(��)����', '010-7222-7333');
insert into vender values(seq_vender_id.nextval, '���̴� �Ӷ�', '010-1345-4567');
insert into vender values(seq_vender_id.nextval, '(��)�������', '02-5636-8228');

--item �׽�Ʈ�� ������
insert into item values
(seq_item_no.nextval, '������ �齺', 300, 20000, 0, sysdate, 1, '��,�齺,����,�ֺ�',
'������ �̹��� �ּ�', '���� �̹��� �ּ�', '���� �̹��� �ּ�');
insert into item values
(seq_item_no.nextval, '�ϰ��� ����', 200, 1500, 0, sysdate, 2, '�Ǽ��縮,��ǰ',
'������ �̹��� �ּ�', '���� �̹��� �ּ�', '���� �̹��� �ּ�');
insert into item values
(seq_item_no.nextval, '����Ʈ�� ��ġ ���� �尩', 100, 9900, 0, sysdate, 3, '�ܿ�,����,��ġ',
'������ �̹��� �ּ�', '���� �̹��� �ּ�', '���� �̹��� �ּ�');

--product_main �׽�Ʈ�� ������
insert into product_main values(1, 2);
insert into product_main values(2, 3);
insert into product_main values(3, 1);

--item_sub �׽�Ʈ�� ������
EXECUTE insert_item_sub(1, '�ʷϻ�', 0, 20);
EXECUTE insert_item_sub(1, '���', 1000, 10);
EXECUTE insert_item_sub(1, '������', 1000, 10);
EXECUTE insert_item_sub(2, '�⺻��', 0, 200);
EXECUTE insert_item_sub(3, '�⺻��', 0, 100);
EXECUTE insert_item_sub(3, '���-����', 2000, 50);
EXECUTE insert_item_sub(3, '���-����', 2000, 50);

---------------------------------------------------------------------

--cart �׽�Ʈ�� ������
insert into cart values(seq_cart_no.nextval, 'user01', 1, 1, 2);
insert into cart values(seq_cart_no.nextval, 'user01', 2, 4, 1);
insert into cart values(seq_cart_no.nextval, 'user02', 1, 2, 3);
insert into cart values(seq_cart_no.nextval, 'user02', 3, 6, 1);

---------------------------------------------------------------------

/* �ֹ� ����
  1	������ �齺	20000�� - 1	�ʷϻ�	0��	1��
  2	�ϰ��� ����	1500��	- 4	�⺻��	0�� 2��
*/

--1. �ֹ�
--���� ���ÿ� �ֹ����� Ư���Ⱓ�� �����µ��� ������ ���� ��� �ڵ� ���� ������ �ʿ�
insert into purchase values(seq_purchase_no.nextval, 'user01', 23000, 2500, sysdate, null);
insert into purchase values(seq_purchase_no.nextval, 'user02', 9900, 2500, sysdate, null);

--2. �ֹ� �Ϸ� : �ش� �ֹ� �� ������ �߰�(java���� service~dao �ݺ�ó��)
insert into orders values(seq_order_no.nextval, 1, 1, 1);
insert into orders values(seq_order_no.nextval, 1, 4, 2);
insert into orders values(seq_order_no.nextval, 2, 5, 1);

--3. ���� �Ϸ� : �ش� �ֹ� ���� ����
EXECUTE insert_payment(1, 'user01', 'ī�����', '����ī��', 25500);
EXECUTE insert_payment(2, 'user02', '������ü', '�ϳ�����', 12400);

---------------------------------------------------------------------

--question �׽�Ʈ�� ������
insert into question values(seq_question_no.nextval, 'user02', 1, 1, '������ ��¥ �齺 ������?', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 1, '��. ���� �������� ����ϴ� ��ǰ�Դϴ�^^', sysdate);

--answer ������ ���� -> question�� answer_no�� null�� ���� Ȯ��
--delete from answer where Answer_No=1;

--answer ������ ����
--update answer set answer_content='��. ���� �������� ����ϴ� ��ǰ�̶��ϴ�! ^^' where answer_no = 2;

---------------------------------------------------------------------

--review �׽�Ʈ�� ������
insert into review values(seq_review_no.nextval, 'user01', 1, 1, 4, '�̹� ������ ����ߴµ� ��¥ �� �ӾҾ��!! ����', sysdate);
insert into review values(seq_review_no.nextval, 'user02', 3, 5, 5, '��ġ�� �ߵǰ� �����ؿ�!!', sysdate);

---------------------------------------------------------------------

--FAQ �׽�Ʈ�� ������
insert into FAQ values(seq_FAQ_no.nextval, 1, 
'��ǰ�� ���ڰ� �ִµ� ��� �ؾ� �ϳ���?', 
'�Ʒ� ����ڿ��� �������ֽø� ������ �ذ��� �帮�ڽ��ϴ�. �ո� : 010-1010-1010, �Ȳ�ġ : 010-2020-2020',
sysdate);
insert into FAQ values(seq_FAQ_no.nextval, 2, 
'������ ����� ���� �ʽ��ϴ�.', 
'���� ���α׷��� �ٽ� ��ġ���ֽð� �׷��� ���� �ʴ� ��쿡�� �ٸ� ��������� �������ּ���.', 
sysdate);
insert into FAQ values(seq_FAQ_no.nextval, 3, 
'��� ��ȣ�� Ȯ�� ���� �ʽ��ϴ�.', 
'���� �ý��ۻ� Ȯ���� �Ұ��Ͽ� ���ڷ� �߼��ص帮�� �ֽ��ϴ�.', 
sysdate);
insert into FAQ values(seq_FAQ_no.nextval, 4, 
'���� �� ��� �׸��� �� ä���߸� �ϳ���?', 
'�ƴմϴ�. �ʼ��׸��̶�� ǥ���� �κи� �ۼ��Ͻø� �˴ϴ�.^^', 
sysdate);

---------------------------------------------------------------------

--notice �׽�Ʈ�� ������
insert into notice values(seq_notice_no.nextval, 1, 
'����Ʈ�� �����Ǿ����ϴ�.', '������ ���� ��� ��Ź�帳�ϴ�!',
null, sysdate);
insert into notice values(seq_notice_no.nextval, 2, 
'���±�� ��ۺ� ���� �̺�Ʈ!', '��� �ֹ����� ��ۺ� ���ܵ˴ϴ�.',
null, sysdate);

---------------------------------------------------------------------
--���ο� DML(����) �ۼ�--


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


