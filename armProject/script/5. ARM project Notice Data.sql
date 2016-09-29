insert into notice values(seq_notice_no.nextval, 1, 
'사이즈 측정안내!', '나도모름',
null, sysdate);
insert into notice values(seq_notice_no.nextval, 1, 
'적립금 소멸 안내', '안쓰면 소멸됩니다.',
null, sysdate);

insert into notice values(seq_notice_no.nextval, 1, 
'사용후기 적립금 안내', '후기쓰면 적립금 10원씩',
null, sysdate);
insert into notice values(seq_notice_no.nextval, 1, 
'배송지연 공지', '죄송합니다...',
null, sysdate);

insert into notice values(seq_notice_no.nextval, 1, 
'해외배송 FAQ!!', '해외로 보내드립니다.',
null, sysdate);
insert into notice values(seq_notice_no.nextval, 1, 
'교환/반품시 주소지 안내입니다.', '경기도 의정부시 용현동 528-5번지 2층 앞으로 보내주세요',
null, sysdate);

insert into notice values(seq_notice_no.nextval, 1, 
'개인정보취급방침 변경사항 안내', '저희는 고객님들의 소중한 개인정보를 지키기 위해 최선의 노력을 다하고 있으며
앞으로도 더욱 튼튼하고 안전한 쇼핑몰 구축을 위해 노력하겠습니다.
감사합니다.', null, sysdate);

insert into notice values(seq_notice_no.nextval, 1, 
'저희는 CJ대한통운을 이용합니다', '안녕하세요. 저희는 기존 현대택배에서 고객들의 편의를 위하여 " CJ대한통운"로 변경하였습니다. CJ대한통운 ☎ 1588-1255 로 ARS 접수가능하시며, 인터넷 접수도 가능합니다.',
null, sysdate);

commit;
--여기까지 완료


insert into question values
(seq_question_no.nextval, 'user02', 1, 1, '정말로 진짜 깁스 같나요?', sysdate);

insert into answer values
(seq_answer_no.nextval, '1', '네. 실제 병원에서 사용하는 제품입니다^^', sysdate);

--question 테스트용 데이터 (순서, 아이디, 상품번호, 제품번호, 쓸거, 날짜)
insert into question values(seq_question_no.nextval, 'user01', 3, 6, '확실히 보온이되나요?', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 3, '네 됩니다..', sysdate);

--question 테스트용 데이터
insert into question values(seq_question_no.nextval, 'user01', 4, 8, '글자는 어떻게 새기나요?', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 4, '칼로 긁어서 새깁니다.', sysdate);

--question 테스트용 데이터
insert into question values(seq_question_no.nextval, 'user03', 5, 10, '반지 더 큰건없나요?', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 5, '네 없습니다.', sysdate);

--question 테스트용 데이터
insert into question values(seq_question_no.nextval, 'user02', 6, 12, '색깔 다른건없나요?', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 6, '없습니다.', sysdate);

--question 테스트용 데이터
insert into question values(seq_question_no.nextval, 'user03', 7, 14, '중학생용은 없나요?', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 7, '네 없습니다 ㅡㅡ', sysdate);

--question 테스트용 데이터
insert into question values(seq_question_no.nextval, 'user01', 8, 16, '팔찌가 끊어져 왓는데 어떻합니까', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 8, '고객센터에 연락주시면 바로 처리해드립니다.', sysdate);

--question 테스트용 데이터
insert into question values(seq_question_no.nextval, 'user02', 9, 19, '색깔이 너무 단순해요', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 9, '죄송합니다 고객님 다시 상품 보내드리겠습니다.', sysdate);

--question 테스트용 데이터
insert into question values(seq_question_no.nextval, 'user03', 10, 20, '고무가 금방끊어졌어요..', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 10, '죄송합니다 고객님 확인후에 바로 처리해드리겠습니다.', sysdate);

--question 테스트용 데이터
insert into question values(seq_question_no.nextval, 'user01', 11, 22, '타투가 잘안새겨져요!', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 11, '죄송합니다 고객님..', sysdate);

--question 테스트용 데이터
insert into question values(seq_question_no.nextval, 'user02', 12, 24, '더 비싼건없나요 너무싸네요.', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 12, 'ㄷㄷㄷ?', sysdate);


--question 테스트용 데이터
insert into question values(seq_question_no.nextval, 'user01', 13, 26, '배송왔는데 너무 더럽네요', sysdate);

--answer 테스트용 데이터 입력
insert into answer values(seq_answer_no.nextval, 13, '죄송합니다 고객센터에 전화로 문의해주세요.', sysdate);
commit;

insert into review values(seq_review_no.nextval, 'user01', 4, 1, 4, '글자가 너무 이쁘게 새겨졌어요!', sysdate);

insert into review values(seq_review_no.nextval, 'user02', 5, 2, 5, '반지가 너무 이뻐요!', sysdate);

insert into review values(seq_review_no.nextval, 'user03', 6, 1, 4, '커플반지로 딱이네요!', sysdate);

insert into review values(seq_review_no.nextval, 'user01', 7, 1, 5, '손톱이 너무 잘깍여요!', sysdate);

insert into review values(seq_review_no.nextval, 'user02', 8, 1, 2, '디자인이 별로네요..', sysdate);

insert into review values(seq_review_no.nextval, 'user03', 9, 2, 1, '엄마가 버리래요..', sysdate);

insert into review values(seq_review_no.nextval, 'user01', 10, 1, 3, '천연이라 더 잘닦여요', sysdate);

insert into review values(seq_review_no.nextval, 'user02', 11, 2, 5, '타투 너무 이뻐요!!', sysdate);

insert into review values(seq_review_no.nextval, 'user03', 12, 1, 4, '비싼만큼 값어치 하네요', sysdate);

insert into review values(seq_review_no.nextval, 'user01', 13, 2, 2, '콧물닦는데 쓰면되겠네요', sysdate);

commit;