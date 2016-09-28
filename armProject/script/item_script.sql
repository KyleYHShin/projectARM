update item set ITEM_IMG_MINI = '/arm/img/item/01_mini.png', ITEM_IMG = '/arm/img/item/01.png', ITEM_IMG_DETAIL = '/arm/img/item/01_detail.png'
where item_no = 1;
update item set ITEM_IMG_MINI = '/arm/img/item/02_mini.jpg', ITEM_IMG = '/arm/img/item/02.jpg', ITEM_IMG_DETAIL = '/arm/img/item/02_detail.jpg'
where item_no = 2;
update item set ITEM_IMG_MINI = '/arm/img/item/03_mini.jpg', ITEM_IMG = '/arm/img/item/03.jpg', ITEM_IMG_DETAIL = '/arm/img/item/03_detail.jpg'
where item_no = 3;
insert into item values
(seq_item_no.nextval, '���� �������set', 100, 3000, 0, sysdate, 1, '��,����,����,��,�ϻ�',
'/arm/img/item/04_mini.jpg', '/arm/img/item/04.jpg', '/arm/img/item/04_detail.jpg');
insert into item values
(seq_item_no.nextval, '�Ƿ� ���� ����', 100, 12900, 0, sysdate, 2, '����,Ŀ��,��,��,�հ���,�Ǽ��縮',
'/arm/img/item/05_mini.jpg', '/arm/img/item/05.jpg', '/arm/img/item/05_detail.jpg');
insert into item values
(seq_item_no.nextval, '���� �ð�', 100, 21000, 0, sysdate, 2, '����,�ð�,����,Ŀ��,�Ǽ��縮,��ǰ',
'/arm/img/item/06_mini.jpg', '/arm/img/item/06.jpg', '/arm/img/item/06_detail.jpg');
insert into item values
(seq_item_no.nextval, 'would you ����', 200, 4900, 0, sysdate, 3, '�ո�,����,����,�Ǽ��縮,Ŀ��',
'/arm/img/item/07_mini.jpg', '/arm/img/item/07.jpg', '/arm/img/item/07_detail.jpg');
insert into item values
(seq_item_no.nextval, '�ƴ�', 200, 4900, 0, sysdate, 3, '�Ƿ�,�ƴ�,�ո�,����,�ǰ�,�θ��',
'/arm/img/item/08_mini.jpg', '/arm/img/item/08.jpg', '/arm/img/item/08_detail.jpg');
insert into item values
(seq_item_no.nextval, '������ ���尩10set', 200, 11000, 0, sysdate, 2, '��,�尩,���尩,��Ʈ',
'/arm/img/item/09_mini.jpg', '/arm/img/item/09.jpg', '/arm/img/item/09_detail.jpg');
insert into item values
(seq_item_no.nextval, '����� Ÿ��1', 400, 10500, 0, sysdate, 2, 'Ÿ��,����,���,�غ�,��ǰ',
'/arm/img/item/10_mini.jpg', '/arm/img/item/10.jpg', '/arm/img/item/10_detail.jpg');
insert into item values
(seq_item_no.nextval, '�� �����', 400, 6800, 0, sysdate, 1, '���,����,��,�����,��ȣ',
'/arm/img/item/11_mini.jpg', '/arm/img/item/11.jpg', '/arm/img/item/11_detail.jpg');

commit;
insert into product_main values(4, 8);
insert into product_main values(5, 11);
insert into product_main values(6, 5);
insert into product_main values(7, 9);
insert into product_main values(8, 10);
insert into product_main values(9, 4);
insert into product_main values(10, 7);
insert into product_main values(11, 6);

commit;

--����¡ ó�� ���� ����
select * from(
select ceil(rownum/2) page, item_no, item_name, item_cat_no, item_price, item_count, item_update, item_img_mini, item_img, item_img_detail
from (select * from product_main p left join item i on(p.PRM_ITEM_NO = i.ITEM_NO) order by prm_no)) where page =1;

select * from(
select ceil(rownum/2) page, item_no, item_name, item_cat_no, item_price, item_count, item_update, item_img_mini, item_img, item_img_detail
from (select * from item where item_tag like '%��%')) where page =1;

--item_sub ���� ������
EXECUTE insert_item_sub(4, 'ǳ����-����', 50, 4);
EXECUTE insert_item_sub(4, 'ǳ����-����', 500, 9);
EXECUTE insert_item_sub(4, '����', 300, 14);
EXECUTE insert_item_sub(4, '�ֹ���', 0, 15);
EXECUTE insert_item_sub(5, '�ư���', 2000, 21);
EXECUTE insert_item_sub(5, '��Ʈ������', 1000, 13);
EXECUTE insert_item_sub(6, 'S', 0, 11);
EXECUTE insert_item_sub(6, 'M', 2000, 14);
EXECUTE insert_item_sub(6, 'L(������)', 3000, 28);
EXECUTE insert_item_sub(7, '��Ʈ-����+���� set', 4500, 22);
EXECUTE insert_item_sub(7, '��-����+����set', 4500, 12);
EXECUTE insert_item_sub(7, '����', 1000, 46);
EXECUTE insert_item_sub(7, '����', 1000, 13);
EXECUTE insert_item_sub(8, '�ո���', 5000, 74);
EXECUTE insert_item_sub(8, '�ո����',7000, 13);
EXECUTE insert_item_sub(9, '10set', 0, 7);
EXECUTE insert_item_sub(9, '20set', 10000, 35);
EXECUTE insert_item_sub(9, '30set', 18000, 57);
EXECUTE insert_item_sub(10, '���ּ�Ʈ', 0, 15);
EXECUTE insert_item_sub(10, '�ɵ���', 2500, 15);
EXECUTE insert_item_sub(10, '�̶�׷���', 3000, 15);
EXECUTE insert_item_sub(10, '�߸����', 2000, 15);
EXECUTE insert_item_sub(11, 'īŰ', 0, 15);
EXECUTE insert_item_sub(11, '����', 0, 15);
EXECUTE insert_item_sub(11, '��', 0, 15);

commit;


insert into item values
(seq_item_no.nextval, 'RS-074(���ڹ���)', 100, 12900, 0, sysdate, 2, '����,Ŀ��,��,��,�հ���,�Ǽ��縮',
'/arm/img/item/12_mini.jpg', '/arm/img/item/12.jpg', '/arm/img/item/12_detail.jpg');

insert into item values
(seq_item_no.nextval, '3mm Pink ���� ���ι���', 100, 21000, 0, sysdate, 2, '����,�ð�,����,Ŀ��,�Ǽ��縮,��ǰ',
'/arm/img/item/13_mini.jpg', '/arm/img/item/13.jpg', '/arm/img/item/13_detail.jpg');

insert into item values
(seq_item_no.nextval, '�̴ϼ� Ŀ������', 200, 4900, 0, sysdate, 3, '�ո�,����,����,�Ǽ��縮,Ŀ��',
'/arm/img/item/14_mini.jpg', '/arm/img/item/14.jpg', '/arm/img/item/14_detail.jpg');

insert into item values
(seq_item_no.nextval, '���ŰƼ �������', 100, 3000, 0, sysdate, 1, '��,����,����,��,�ϻ�',
'/arm/img/item/15_mini.jpg', '/arm/img/item/15.jpg', '/arm/img/item/15_detail.jpg');

insert into item values
(seq_item_no.nextval, '���͸� ����', 200, 4900, 0, sysdate, 3, '�ո�,����,����,�Ǽ��縮,Ŀ��',
'/arm/img/item/16_mini.jpg', '/arm/img/item/16.jpg', '/arm/img/item/16_detail.jpg');

insert into item values
(seq_item_no.nextval, '�Ʊ⺼�� �ո�ȣ��', 200, 4900, 0, sysdate, 3, '�Ƿ�,�ƴ�,�ո�,����,�ǰ�,�θ��',
'/arm/img/item/17_mini.jpg', '/arm/img/item/17.jpg', '/arm/img/item/17_detail.jpg');

insert into item values
(seq_item_no.nextval, 'õ�����ؽ� ���尩', 200, 11000, 0, sysdate, 2, '��,�尩,���尩,��Ʈ',
'/arm/img/item/18_mini.jpg', '/arm/img/item/18.jpg', '/arm/img/item/18_detail.jpg');

insert into item values
(seq_item_no.nextval, '����� Ÿ��1', 400, 10500, 0, sysdate, 2, 'Ÿ��,����,���,�غ�,��ǰ',
'/arm/img/item/19_mini.jpg', '/arm/img/item/19.jpg', '/arm/img/item/19_detail.jpg');

insert into item values
(seq_item_no.nextval, '�ٴϿ������� 0607DW', 100, 180000, 0, sysdate, 2, '�ð�,��ǰ,�Ǽ��縮,��ǰ',
'/arm/img/item/20_mini.jpg', '/arm/img/item/20.jpg', '/arm/img/item/20_detail.jpg');

insert into item values
(seq_item_no.nextval, '����� �ռ���', 100, 2500, 0, sysdate, 2, '�ռ���, ����, û��,',
'/arm/img/item/21_mini.jpg', '/arm/img/item/21.jpg', '/arm/img/item/21_detail.jpg');

insert into item values
(seq_item_no.nextval, '�����ٴ����ʴ� �Ʒ�', 100, 900, 0, sysdate, 1, '�Ʒ�, �, ����, �ȱ���, ���',
'/arm/img/item/22_mini.jpg', '/arm/img/item/22.jpg', '/arm/img/item/22_detail.jpg');

insert into item values
(seq_item_no.nextval, '�ʺ��� �����', 100, 12000, 0, sysdate, 3, '���, �ܿ�, �ʺ���, ��',
'/arm/img/item/23_mini.jpg', '/arm/img/item/23.jpg', '/arm/img/item/23_detail.jpg');

insert into item values
(seq_item_no.nextval, '�Ŀ� �Ƿ±�', 100, 18000, 0, sysdate, 1, '��, �Ƿ�, ��ⱸ, ',
'/arm/img/item/24_mini.jpg', '/arm/img/item/24.jpg', '/arm/img/item/24_detail.jpg');

insert into item values
(seq_item_no.nextval, '���ŰƼ ���ױ۷���', 100, 24000, 0, sysdate, 2, '�۷���, ��, ŰƼ, �',
'/arm/img/item/25_mini.jpg', '/arm/img/item/25.jpg', '/arm/img/item/25_detail.jpg');

insert into item values
(seq_item_no.nextval, '2016����Ʈ �мǹ���ð�', 200, 12000, 0, sysdate, 3, '�ð�, �ո�, ���, ������',
'/arm/img/item/26_mini.jpg', '/arm/img/item/26.jpg', '/arm/img/item/26_detail.jpg');

insert into item values
(seq_item_no.nextval, '�ڵ�ũ��', 200, 17000, 0, sysdate, 1, '��, ����, ũ��,',
'/arm/img/item/27_mini.jpg', '/arm/img/item/27.jpg', '/arm/img/item/27_detail.jpg');

insert into item values
(seq_item_no.nextval, 'USB �¿� ���콺�е�', 100, 12000, 0, sysdate, 2, 'USB, �¿�, ���콺�е�,��',
'/arm/img/item/28_mini.jpg', '/arm/img/item/28.jpg', '/arm/img/item/28_detail.jpg');

insert into item values
(seq_item_no.nextval, '��ũ���� ��', 100, 2000, 0, sysdate, 3, '��, ����, ��Ƽ, �峭��',
'/arm/img/item/29_mini.jpg', '/arm/img/item/29.jpg', '/arm/img/item/29_detail.jpg');

insert into item values
(seq_item_no.nextval, '�ڵ彺Ʈ��', 100, 2000, 0, sysdate, 1, '������, ī�޶�, ��Ʈ��, �ڵ���',
'/arm/img/item/30_mini.jpg', '/arm/img/item/30.jpg', '/arm/img/item/30_detail.jpg');

insert into item values
(seq_item_no.nextval, '����� ��������', 100, 4000, 0, sysdate, 2, '��Ƽ, ������, ��ǰ, ����, �̿�',
'/arm/img/item/31_mini.jpg', '/arm/img/item/31.jpg', '/arm/img/item/31_detail.jpg');

insert into item values
(seq_item_no.nextval, '�ߵ��̺�� �Ŀ��Ͻ�����', 300, 37000, 0, sysdate, 3, '����, ������, ��ȣ��, �Ȳ�ġ',
'/arm/img/item/32_mini.jpg', '/arm/img/item/32.jpg', '/arm/img/item/32_detail.jpg');

insert into item values
(seq_item_no.nextval, '���� ��������', 100, 26800, 0, sysdate, 1, '����, �Ŀ�ġ, ������, ��',
'/arm/img/item/33_mini.jpg', '/arm/img/item/33.jpg', '/arm/img/item/33_detail.jpg');

insert into item values
(seq_item_no.nextval, '���ϰ�ȭ ������', 100, 28000, 0, sysdate, 2, '��Ƽ, ����, Ʈ��Ʈ��Ʈ, ������, ����',
'/arm/img/item/34_mini.jpg', '/arm/img/item/34.jpg', '/arm/img/item/34_detail.jpg');

insert into item values
(seq_item_no.nextval, 'īī�� ���', 100, 17500, 0, sysdate, 3, 'īī��, ���, ��, ��',
'/arm/img/item/35_mini.jpg', '/arm/img/item/35.jpg', '/arm/img/item/35_detail.jpg');

insert into item values
(seq_item_no.nextval, '�ڵ�Ÿ�� ������', 200, 9310, 0, sysdate, 1, '��Ƽ�ǻ�, �м�, ��Ƽ, Ÿ��',
'/arm/img/item/36_mini.jpg', '/arm/img/item/36.jpg', '/arm/img/item/36_detail.jpg');

insert into item values
(seq_item_no.nextval, '���T.B.001-����', 400, 7000, 0, sysdate, 2, '������, Ÿ��, ��Ƽ, ���, ��',
'/arm/img/item/37_mini.jpg', '/arm/img/item/37.jpg', '/arm/img/item/37_detail.jpg');

insert into item values
(seq_item_no.nextval, '����Ʈ ��ġ�尩', 100, 1000, 0, sysdate, 3, '����Ʈ��, �尩, �ܿ�, ��ġ',
'/arm/img/item/38_mini.jpg', '/arm/img/item/38.jpg', '/arm/img/item/38_detail.jpg');

insert into item values
(seq_item_no.nextval, '�Ϳ��� ��� �尩', 100, 10000, 0, sysdate, 1, '���, �尩, ��, �ܿ�',
'/arm/img/item/39_mini.jpg', '/arm/img/item/39.jpg', '/arm/img/item/39_detail.jpg');

insert into item values
(seq_item_no.nextval, 'TISSOT Ƽ�� ���̷���', 200, 1890000, 0, sysdate, 2, '�־�, �ո�, �ð�, ���׽ð�, �ð�',
'/arm/img/item/40_mini.jpg', '/arm/img/item/40.jpg', '/arm/img/item/40_detail.jpg');

insert into item values
(seq_item_no.nextval, '�༺����- ��(Moon)', 200, 14800, 0, sysdate, 3, '�־�, ����, �м�, ����',
'/arm/img/item/41_mini.jpg', '/arm/img/item/41.jpg', '/arm/img/item/41_detail.jpg');


insert into product_main values(12, 19);
insert into product_main values(13, 17);
insert into product_main values(14, 34);
insert into product_main values(15, 30);
insert into product_main values(16, 22);
insert into product_main values(17, 18);
insert into product_main values(18, 24);
insert into product_main values(19, 32);
insert into product_main values(20, 23);
insert into product_main values(21, 31);
insert into product_main values(22, 40);
insert into product_main values(23, 27);
insert into product_main values(24, 41);
insert into product_main values(25, 33);
insert into product_main values(26, 26);
insert into product_main values(27, 37);
insert into product_main values(28, 39);
insert into product_main values(29, 25);
insert into product_main values(30, 12);
insert into product_main values(31, 13);
insert into product_main values(32, 15);
insert into product_main values(33, 29);
insert into product_main values(34, 14);
insert into product_main values(35, 16);
insert into product_main values(36, 21);
insert into product_main values(37, 38);
insert into product_main values(38, 28);
insert into product_main values(39, 20);
insert into product_main values(40, 35);
insert into product_main values(41, 36);


commit;

EXECUTE insert_item_sub(12, '�̴ϼ� �߰�', 25000, 120);
EXECUTE insert_item_sub(12, '���� �߰�', 25000, 130);

EXECUTE insert_item_sub(13, '4mm', 1000, 100);
EXECUTE insert_item_sub(13, '5mm', 2000, 100);

EXECUTE insert_item_sub(14, '������', 3000, 123);
EXECUTE insert_item_sub(14, '��Ȳ��', 3000, 30);

EXECUTE insert_item_sub(15, '��̿�', 1000, 100);
EXECUTE insert_item_sub(15, '���', 2000, 100);

EXECUTE insert_item_sub(16, '������', 3000, 50);
EXECUTE insert_item_sub(16, '����', 3000, 50);

EXECUTE insert_item_sub(17, '�ϴû�', 4900, 100);
EXECUTE insert_item_sub(17, '�ٴٻ�', 4900, 100);

EXECUTE insert_item_sub(18, '������', 1000, 100);
EXECUTE insert_item_sub(18, '�����ѳ�Ÿ', 2000, 150);

EXECUTE insert_item_sub(19, '�յ� Ÿ��', 10500, 40);
EXECUTE insert_item_sub(19, '�ȵ� Ÿ��', 10500, 40);

EXECUTE insert_item_sub(20, '�ٴϿ�������_AD001', 1800000, 10);
EXECUTE insert_item_sub(20, '�ٴϿ�������_AD002', 1800000, 10);

EXECUTE insert_item_sub(21, '�ռ��� �Ķ�', 2500, 300);
EXECUTE insert_item_sub(21, '�ռ��� ���', 2500, 300);

EXECUTE insert_item_sub(22, '�Ʒ� 5kg', 9000, 250);
EXECUTE insert_item_sub(22, '�Ʒ� 8kg', 12000, 250);

EXECUTE insert_item_sub(23, '�ʺ��� ����', 12000, 100);
EXECUTE insert_item_sub(23, '�ʺ��� ����', 12000, 100);

EXECUTE insert_item_sub(24, '��� �Ƿ±�', 18000, 200);
EXECUTE insert_item_sub(24, '��̿� �Ƿ±�', 18000, 200);

EXECUTE insert_item_sub(25, '���ױ۷���-����', 24000, 90);
EXECUTE insert_item_sub(25, '���ױ۷���-�Ķ�', 24000, 80);

EXECUTE insert_item_sub(26, '���-�ʷ�', 12000, 100);
EXECUTE insert_item_sub(26, '���-�Ķ�', 12000, 100);

EXECUTE insert_item_sub(27, '�ڵ�ũ��_300mg', 17000, 100);
EXECUTE insert_item_sub(27, '�ڵ�ũ��_400mg', 18000, 100);

EXECUTE insert_item_sub(28, '������', 12000, 200);
EXECUTE insert_item_sub(28, '�����', 12000, 200);

EXECUTE insert_item_sub(29, '��ũ���� ����', 2000, 150);
EXECUTE insert_item_sub(29, '��ũ���� ������', 2000, 150);

commit;
EXECUTE insert_item_sub(30, '�ʷϻ�', 2000, 190);
EXECUTE insert_item_sub(30, '������', 2000, 200);

EXECUTE insert_item_sub(31, '��¡���', 4000, 110);
EXECUTE insert_item_sub(31, '�����̹�', 4000, 110);

EXECUTE insert_item_sub(32, '�Ŀ��� �Ȳ�ġ', 37000, 50);
EXECUTE insert_item_sub(32, '�Ŀ��� ���', 37000, 50);

EXECUTE insert_item_sub(33, '������', 26800, 110);
EXECUTE insert_item_sub(33, '�Ұ���', 30000, 110);

EXECUTE insert_item_sub(34, '������ ����', 28000, 300);
EXECUTE insert_item_sub(34, '������ ���', 28000, 300);

EXECUTE insert_item_sub(35, 'īī�� ���̾�', 17500, 200);
EXECUTE insert_item_sub(35, 'īī�� ����', 17500, 200);

EXECUTE insert_item_sub(36, '�ڵ�Ÿ�� �տ�', 10000, 900);
EXECUTE insert_item_sub(36, '�ڵ�Ÿ�� �ȿ�', 10000, 900);

EXECUTE insert_item_sub(37, 'Ÿ�� ���', 7000, 120);
EXECUTE insert_item_sub(37, 'Ÿ�� ����', 7000, 130);

EXECUTE insert_item_sub(38, '�尩 - ������', 1000, 80);
EXECUTE insert_item_sub(38, '�尩 - �����', 1000, 90);

EXECUTE insert_item_sub(39, '�尩 - �����', 10000, 300);
EXECUTE insert_item_sub(39, '�尩 - ������', 10000, 300);

EXECUTE insert_item_sub(40, 'Ƽ�� - �Ǹ�', 1890000, 10);
EXECUTE insert_item_sub(40, 'Ƽ�� - ��', 1890000, 10);

EXECUTE insert_item_sub(41, '�༺ - ��', 15000, 200);
EXECUTE insert_item_sub(41, '�༺ - �¾�', 15000, 200);



commit;