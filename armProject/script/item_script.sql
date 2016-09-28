update item set ITEM_IMG_MINI = '/arm/img/item/01_mini.png', ITEM_IMG = '/arm/img/item/01.png', ITEM_IMG_DETAIL = '/arm/img/item/01_detail.png'
where item_no = 1;
update item set ITEM_IMG_MINI = '/arm/img/item/02_mini.jpg', ITEM_IMG = '/arm/img/item/02.jpg', ITEM_IMG_DETAIL = '/arm/img/item/02_detail.jpg'
where item_no = 2;
update item set ITEM_IMG_MINI = '/arm/img/item/03_mini.jpg', ITEM_IMG = '/arm/img/item/03.jpg', ITEM_IMG_DETAIL = '/arm/img/item/03_detail.jpg'
where item_no = 3;
insert into item values
(seq_item_no.nextval, '블링블링 손톱깎이set', 100, 3000, 0, sysdate, 1, '손,손톱,깎이,블링,일상',
'/arm/img/item/04_mini.jpg', '/arm/img/item/04.jpg', '/arm/img/item/04_detail.jpg');
insert into item values
(seq_item_no.nextval, '실로 만든 반지', 100, 12900, 0, sysdate, 2, '반지,커플,실,손,손가락,악세사리',
'/arm/img/item/05_mini.jpg', '/arm/img/item/05.jpg', '/arm/img/item/05_detail.jpg');
insert into item values
(seq_item_no.nextval, '반지 시계', 100, 21000, 0, sysdate, 2, '반지,시계,우정,커플,악세사리,소품',
'/arm/img/item/06_mini.jpg', '/arm/img/item/06.jpg', '/arm/img/item/06_detail.jpg');
insert into item values
(seq_item_no.nextval, 'would you 팔찌', 200, 4900, 0, sysdate, 3, '손목,팔찌,구슬,악세사리,커플',
'/arm/img/item/07_mini.jpg', '/arm/img/item/07.jpg', '/arm/img/item/07_detail.jpg');
insert into item values
(seq_item_no.nextval, '아대', 200, 4900, 0, sysdate, 3, '의료,아대,손목,고정,건강,부모님',
'/arm/img/item/08_mini.jpg', '/arm/img/item/08.jpg', '/arm/img/item/08_detail.jpg');
insert into item values
(seq_item_no.nextval, '마마스 고무장갑10set', 200, 11000, 0, sysdate, 2, '고무,장갑,고무장갑,세트',
'/arm/img/item/09_mini.jpg', '/arm/img/item/09.jpg', '/arm/img/item/09_detail.jpg');
insert into item values
(seq_item_no.nextval, '어깨용 타투1', 400, 10500, 0, sysdate, 2, '타투,문신,어깨,해변,소품',
'/arm/img/item/10_mini.jpg', '/arm/img/item/10.jpg', '/arm/img/item/10_detail.jpg');
insert into item values
(seq_item_no.nextval, '긴 가방끈', 400, 6800, 0, sysdate, 1, '어깨,가방,끈,가방끈,보호',
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

--페이징 처리 구문 예시
select * from(
select ceil(rownum/2) page, item_no, item_name, item_cat_no, item_price, item_count, item_update, item_img_mini, item_img, item_img_detail
from (select * from product_main p left join item i on(p.PRM_ITEM_NO = i.ITEM_NO) order by prm_no)) where page =1;

select * from(
select ceil(rownum/2) page, item_no, item_name, item_cat_no, item_price, item_count, item_update, item_img_mini, item_img, item_img_detail
from (select * from item where item_tag like '%팔%')) where page =1;

--item_sub 예비 데이터
EXECUTE insert_item_sub(4, '풍뎅이-빨강', 50, 4);
EXECUTE insert_item_sub(4, '풍뎅이-검정', 500, 9);
EXECUTE insert_item_sub(4, '나비', 300, 14);
EXECUTE insert_item_sub(4, '애벌래', 0, 15);
EXECUTE insert_item_sub(5, '아가일', 2000, 21);
EXECUTE insert_item_sub(5, '스트라이프', 1000, 13);
EXECUTE insert_item_sub(6, 'S', 0, 11);
EXECUTE insert_item_sub(6, 'M', 2000, 14);
EXECUTE insert_item_sub(6, 'L(남성용)', 3000, 28);
EXECUTE insert_item_sub(7, '하트-검정+빨강 set', 4500, 22);
EXECUTE insert_item_sub(7, '별-검정+빨강set', 4500, 12);
EXECUTE insert_item_sub(7, '검정', 1000, 46);
EXECUTE insert_item_sub(7, '빨강', 1000, 13);
EXECUTE insert_item_sub(8, '손목형', 5000, 74);
EXECUTE insert_item_sub(8, '손목긴형',7000, 13);
EXECUTE insert_item_sub(9, '10set', 0, 7);
EXECUTE insert_item_sub(9, '20set', 10000, 35);
EXECUTE insert_item_sub(9, '30set', 18000, 57);
EXECUTE insert_item_sub(10, '우주세트', 0, 15);
EXECUTE insert_item_sub(10, '꽃동산', 2500, 15);
EXECUTE insert_item_sub(10, '켈라그래피', 3000, 15);
EXECUTE insert_item_sub(10, '발리우드', 2000, 15);
EXECUTE insert_item_sub(11, '카키', 0, 15);
EXECUTE insert_item_sub(11, '브라운', 0, 15);
EXECUTE insert_item_sub(11, '블랙', 0, 15);

commit;


insert into item values
(seq_item_no.nextval, 'RS-074(글자반지)', 100, 12900, 0, sysdate, 2, '반지,커플,실,손,손가락,악세사리',
'/arm/img/item/12_mini.jpg', '/arm/img/item/12.jpg', '/arm/img/item/12_detail.jpg');

insert into item values
(seq_item_no.nextval, '3mm Pink 써지 각인반지', 100, 21000, 0, sysdate, 2, '반지,시계,우정,커플,악세사리,소품',
'/arm/img/item/13_mini.jpg', '/arm/img/item/13.jpg', '/arm/img/item/13_detail.jpg');

insert into item values
(seq_item_no.nextval, '이니셜 커플팔찌', 200, 4900, 0, sysdate, 3, '손목,팔찌,구슬,악세사리,커플',
'/arm/img/item/14_mini.jpg', '/arm/img/item/14.jpg', '/arm/img/item/14_detail.jpg');

insert into item values
(seq_item_no.nextval, '헬로키티 손톱깍이', 100, 3000, 0, sysdate, 1, '손,손톱,깎이,블링,일상',
'/arm/img/item/15_mini.jpg', '/arm/img/item/15.jpg', '/arm/img/item/15_detail.jpg');

insert into item values
(seq_item_no.nextval, '레터링 팔찌', 200, 4900, 0, sysdate, 3, '손목,팔찌,구슬,악세사리,커플',
'/arm/img/item/16_mini.jpg', '/arm/img/item/16.jpg', '/arm/img/item/16_detail.jpg');

insert into item values
(seq_item_no.nextval, '아기볼살 손목보호대', 200, 4900, 0, sysdate, 3, '의료,아대,손목,고정,건강,부모님',
'/arm/img/item/17_mini.jpg', '/arm/img/item/17.jpg', '/arm/img/item/17_detail.jpg');

insert into item values
(seq_item_no.nextval, '천연라텍스 고무장갑', 200, 11000, 0, sysdate, 2, '고무,장갑,고무장갑,세트',
'/arm/img/item/18_mini.jpg', '/arm/img/item/18.jpg', '/arm/img/item/18_detail.jpg');

insert into item values
(seq_item_no.nextval, '어깨용 타투1', 400, 10500, 0, sysdate, 2, '타투,문신,어깨,해변,소품',
'/arm/img/item/19_mini.jpg', '/arm/img/item/19.jpg', '/arm/img/item/19_detail.jpg');

insert into item values
(seq_item_no.nextval, '다니엘웰링턴 0607DW', 100, 180000, 0, sysdate, 2, '시계,명품,악세사리,소품',
'/arm/img/item/20_mini.jpg', '/arm/img/item/20.jpg', '/arm/img/item/20_detail.jpg');

insert into item values
(seq_item_no.nextval, '깔끔한 손수건', 100, 2500, 0, sysdate, 2, '손수건, 수건, 청결,',
'/arm/img/item/21_mini.jpg', '/arm/img/item/21.jpg', '/arm/img/item/21_detail.jpg');

insert into item values
(seq_item_no.nextval, '굴러다니지않는 아령', 100, 900, 0, sysdate, 1, '아령, 운동, 근육, 팔근육, 어깨',
'/arm/img/item/22_mini.jpg', '/arm/img/item/22.jpg', '/arm/img/item/22_detail.jpg');

insert into item values
(seq_item_no.nextval, '꽈베기 손토시', 100, 12000, 0, sysdate, 3, '토시, 겨울, 꽈베기, 손',
'/arm/img/item/23_mini.jpg', '/arm/img/item/23.jpg', '/arm/img/item/23_detail.jpg');

insert into item values
(seq_item_no.nextval, '파워 악력기', 100, 18000, 0, sysdate, 1, '손, 악력, 운동기구, ',
'/arm/img/item/24_mini.jpg', '/arm/img/item/24.jpg', '/arm/img/item/24_detail.jpg');

insert into item values
(seq_item_no.nextval, '헬로키티 러닝글러브', 100, 24000, 0, sysdate, 2, '글러브, 손, 키티, 운동',
'/arm/img/item/25_mini.jpg', '/arm/img/item/25.jpg', '/arm/img/item/25_detail.jpg');

insert into item values
(seq_item_no.nextval, '2016스포트 패션방수시계', 200, 12000, 0, sysdate, 3, '시계, 손목, 방수, 스포츠',
'/arm/img/item/26_mini.jpg', '/arm/img/item/26.jpg', '/arm/img/item/26_detail.jpg');

insert into item values
(seq_item_no.nextval, '핸드크림', 200, 17000, 0, sysdate, 1, '손, 세정, 크림,',
'/arm/img/item/27_mini.jpg', '/arm/img/item/27.jpg', '/arm/img/item/27_detail.jpg');

insert into item values
(seq_item_no.nextval, 'USB 온열 마우스패드', 100, 12000, 0, sysdate, 2, 'USB, 온열, 마우스패드,손',
'/arm/img/item/28_mini.jpg', '/arm/img/item/28.jpg', '/arm/img/item/28_detail.jpg');

insert into item values
(seq_item_no.nextval, '후크선장 손', 100, 2000, 0, sysdate, 3, '손, 갈고리, 파티, 장난감',
'/arm/img/item/29_mini.jpg', '/arm/img/item/29.jpg', '/arm/img/item/29_detail.jpg');

insert into item values
(seq_item_no.nextval, '핸드스트랩', 100, 2000, 0, sysdate, 1, '디지털, 카메라, 스트랩, 핸드폰',
'/arm/img/item/30_mini.jpg', '/arm/img/item/30.jpg', '/arm/img/item/30_detail.jpg');

insert into item values
(seq_item_no.nextval, '문어발 마사지기', 100, 4000, 0, sysdate, 2, '뷰티, 마사지, 소품, 진동, 미용',
'/arm/img/item/31_mini.jpg', '/arm/img/item/31.jpg', '/arm/img/item/31_detail.jpg');

insert into item values
(seq_item_no.nextval, '멕데이비드 파워암슬러브', 300, 37000, 0, sysdate, 3, '레저, 스포츠, 보호대, 팔꿈치',
'/arm/img/item/32_mini.jpg', '/arm/img/item/32.jpg', '/arm/img/item/32_detail.jpg');

insert into item values
(seq_item_no.nextval, '슬림 가죽지갑', 100, 26800, 0, sysdate, 1, '지갑, 파우치, 장지갑, 손',
'/arm/img/item/33_mini.jpg', '/arm/img/item/33.jpg', '/arm/img/item/33_detail.jpg');

insert into item values
(seq_item_no.nextval, '네일강화 에센스', 100, 28000, 0, sysdate, 2, '뷰티, 네일, 트리트먼트, 에센스, 손톱',
'/arm/img/item/34_mini.jpg', '/arm/img/item/34.jpg', '/arm/img/item/34_detail.jpg');

insert into item values
(seq_item_no.nextval, '카카오 우산', 100, 17500, 0, sysdate, 3, '카카오, 우산, 비, 손',
'/arm/img/item/35_mini.jpg', '/arm/img/item/35.jpg', '/arm/img/item/35_detail.jpg');

insert into item values
(seq_item_no.nextval, '핸드타투 한정판', 200, 9310, 0, sysdate, 1, '파티의상, 패션, 파티, 타투',
'/arm/img/item/36_mini.jpg', '/arm/img/item/36.jpg', '/arm/img/item/36_detail.jpg');

insert into item values
(seq_item_no.nextval, '배블링T.B.001-네츄럴', 400, 7000, 0, sysdate, 2, '디자인, 타투, 뷰티, 어깨, 팔',
'/arm/img/item/37_mini.jpg', '/arm/img/item/37.jpg', '/arm/img/item/37_detail.jpg');

insert into item values
(seq_item_no.nextval, '스마트 터치장갑', 100, 1000, 0, sysdate, 3, '스마트폰, 장갑, 겨울, 터치',
'/arm/img/item/38_mini.jpg', '/arm/img/item/38.jpg', '/arm/img/item/38_detail.jpg');

insert into item values
(seq_item_no.nextval, '귀여운 벙어리 장갑', 100, 10000, 0, sysdate, 1, '벙어리, 장갑, 손, 겨울',
'/arm/img/item/39_mini.jpg', '/arm/img/item/39.jpg', '/arm/img/item/39_detail.jpg');

insert into item values
(seq_item_no.nextval, 'TISSOT 티쏘 스켈레톤', 200, 1890000, 0, sysdate, 2, '주얼리, 손목, 시계, 가죽시계, 시간',
'/arm/img/item/40_mini.jpg', '/arm/img/item/40.jpg', '/arm/img/item/40_detail.jpg');

insert into item values
(seq_item_no.nextval, '행성팔찌- 달(Moon)', 200, 14800, 0, sysdate, 3, '주얼리, 팔찌, 패션, 우주',
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

EXECUTE insert_item_sub(12, '이니셜 추가', 25000, 120);
EXECUTE insert_item_sub(12, '숫자 추가', 25000, 130);

EXECUTE insert_item_sub(13, '4mm', 1000, 100);
EXECUTE insert_item_sub(13, '5mm', 2000, 100);

EXECUTE insert_item_sub(14, '빨강색', 3000, 123);
EXECUTE insert_item_sub(14, '주황색', 3000, 30);

EXECUTE insert_item_sub(15, '어린이용', 1000, 100);
EXECUTE insert_item_sub(15, '어른용', 2000, 100);

EXECUTE insert_item_sub(16, '검정색', 3000, 50);
EXECUTE insert_item_sub(16, '남색', 3000, 50);

EXECUTE insert_item_sub(17, '하늘색', 4900, 100);
EXECUTE insert_item_sub(17, '바다색', 4900, 100);

EXECUTE insert_item_sub(18, '검정색', 1000, 100);
EXECUTE insert_item_sub(18, '고무고무총난타', 2000, 150);

EXECUTE insert_item_sub(19, '손등 타투', 10500, 40);
EXECUTE insert_item_sub(19, '팔등 타투', 10500, 40);

EXECUTE insert_item_sub(20, '다니엘웰링턴_AD001', 1800000, 10);
EXECUTE insert_item_sub(20, '다니엘웰링턴_AD002', 1800000, 10);

EXECUTE insert_item_sub(21, '손수건 파랑', 2500, 300);
EXECUTE insert_item_sub(21, '손수건 노랑', 2500, 300);

EXECUTE insert_item_sub(22, '아령 5kg', 9000, 250);
EXECUTE insert_item_sub(22, '아령 8kg', 12000, 250);

EXECUTE insert_item_sub(23, '꽈베기 빨강', 12000, 100);
EXECUTE insert_item_sub(23, '꽈베기 보라', 12000, 100);

EXECUTE insert_item_sub(24, '어른용 악력기', 18000, 200);
EXECUTE insert_item_sub(24, '어린이용 악력기', 18000, 200);

EXECUTE insert_item_sub(25, '러닝글러브-검정', 24000, 90);
EXECUTE insert_item_sub(25, '러닝글러브-파랑', 24000, 80);

EXECUTE insert_item_sub(26, '방수-초록', 12000, 100);
EXECUTE insert_item_sub(26, '방수-파랑', 12000, 100);

EXECUTE insert_item_sub(27, '핸드크림_300mg', 17000, 100);
EXECUTE insert_item_sub(27, '핸드크림_400mg', 18000, 100);

EXECUTE insert_item_sub(28, '검정색', 12000, 200);
EXECUTE insert_item_sub(28, '노랑색', 12000, 200);

EXECUTE insert_item_sub(29, '후크선장 도끼', 2000, 150);
EXECUTE insert_item_sub(29, '후크선장 전기톱', 2000, 150);

commit;
EXECUTE insert_item_sub(30, '초록색', 2000, 190);
EXECUTE insert_item_sub(30, '검은색', 2000, 200);

EXECUTE insert_item_sub(31, '오징어발', 4000, 110);
EXECUTE insert_item_sub(31, '지렁이발', 4000, 110);

EXECUTE insert_item_sub(32, '파워암 팔꿈치', 37000, 50);
EXECUTE insert_item_sub(32, '파워암 어깨', 37000, 50);

EXECUTE insert_item_sub(33, '말가죽', 26800, 110);
EXECUTE insert_item_sub(33, '소가죽', 30000, 110);

EXECUTE insert_item_sub(34, '에센스 빨강', 28000, 300);
EXECUTE insert_item_sub(34, '에센스 노랑', 28000, 300);

EXECUTE insert_item_sub(35, '카카오 라이언', 17500, 200);
EXECUTE insert_item_sub(35, '카카오 오리', 17500, 200);

EXECUTE insert_item_sub(36, '핸드타투 손용', 10000, 900);
EXECUTE insert_item_sub(36, '핸드타투 팔용', 10000, 900);

EXECUTE insert_item_sub(37, '타투 어깨', 7000, 120);
EXECUTE insert_item_sub(37, '타투 가슴', 7000, 130);

EXECUTE insert_item_sub(38, '장갑 - 무지개', 1000, 80);
EXECUTE insert_item_sub(38, '장갑 - 보라색', 1000, 90);

EXECUTE insert_item_sub(39, '장갑 - 고양이', 10000, 300);
EXECUTE insert_item_sub(39, '장갑 - 강아지', 10000, 300);

EXECUTE insert_item_sub(40, '티쏘 - 악마', 1890000, 10);
EXECUTE insert_item_sub(40, '티쏘 - 신', 1890000, 10);

EXECUTE insert_item_sub(41, '행성 - 별', 15000, 200);
EXECUTE insert_item_sub(41, '행성 - 태양', 15000, 200);



commit;