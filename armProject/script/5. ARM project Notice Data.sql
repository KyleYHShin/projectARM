insert into notice values(seq_notice_no.nextval, 1, 
'������ �����ȳ�!', '������',
null, sysdate);
insert into notice values(seq_notice_no.nextval, 1, 
'������ �Ҹ� �ȳ�', '�Ⱦ��� �Ҹ�˴ϴ�.',
null, sysdate);

insert into notice values(seq_notice_no.nextval, 1, 
'����ı� ������ �ȳ�', '�ı⾲�� ������ 10����',
null, sysdate);
insert into notice values(seq_notice_no.nextval, 1, 
'������� ����', '�˼��մϴ�...',
null, sysdate);

insert into notice values(seq_notice_no.nextval, 1, 
'�ؿܹ�� FAQ!!', '�ؿܷ� �����帳�ϴ�.',
null, sysdate);
insert into notice values(seq_notice_no.nextval, 1, 
'��ȯ/��ǰ�� �ּ��� �ȳ��Դϴ�.', '��⵵ �����ν� ������ 528-5���� 2�� ������ �����ּ���',
null, sysdate);

insert into notice values(seq_notice_no.nextval, 1, 
'����������޹�ħ ������� �ȳ�', '����� ���Ե��� ������ ���������� ��Ű�� ���� �ּ��� ����� ���ϰ� ������
�����ε� ���� ưư�ϰ� ������ ���θ� ������ ���� ����ϰڽ��ϴ�.
�����մϴ�.', null, sysdate);

insert into notice values(seq_notice_no.nextval, 1, 
'����� CJ��������� �̿��մϴ�', '�ȳ��ϼ���. ����� ���� �����ù迡�� ������ ���Ǹ� ���Ͽ� " CJ�������"�� �����Ͽ����ϴ�. CJ������� �� 1588-1255 �� ARS ���������Ͻø�, ���ͳ� ������ �����մϴ�.',
null, sysdate);

commit;
--������� �Ϸ�


insert into question values
(seq_question_no.nextval, 'user02', 1, 1, '������ ��¥ �齺 ������?', sysdate);

insert into answer values
(seq_answer_no.nextval, '1', '��. ���� �������� ����ϴ� ��ǰ�Դϴ�^^', sysdate);

--question �׽�Ʈ�� ������ (����, ���̵�, ��ǰ��ȣ, ��ǰ��ȣ, ����, ��¥)
insert into question values(seq_question_no.nextval, 'user01', 3, 6, 'Ȯ���� �����̵ǳ���?', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 3, '�� �˴ϴ�..', sysdate);

--question �׽�Ʈ�� ������
insert into question values(seq_question_no.nextval, 'user01', 4, 8, '���ڴ� ��� ���⳪��?', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 4, 'Į�� �ܾ ����ϴ�.', sysdate);

--question �׽�Ʈ�� ������
insert into question values(seq_question_no.nextval, 'user03', 5, 10, '���� �� ū�Ǿ�����?', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 5, '�� �����ϴ�.', sysdate);

--question �׽�Ʈ�� ������
insert into question values(seq_question_no.nextval, 'user02', 6, 12, '���� �ٸ��Ǿ�����?', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 6, '�����ϴ�.', sysdate);

--question �׽�Ʈ�� ������
insert into question values(seq_question_no.nextval, 'user03', 7, 14, '���л����� ������?', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 7, '�� �����ϴ� �Ѥ�', sysdate);

--question �׽�Ʈ�� ������
insert into question values(seq_question_no.nextval, 'user01', 8, 16, '��� ������ �Ӵµ� ��մϱ�', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 8, '�����Ϳ� �����ֽø� �ٷ� ó���ص帳�ϴ�.', sysdate);

--question �׽�Ʈ�� ������
insert into question values(seq_question_no.nextval, 'user02', 9, 19, '������ �ʹ� �ܼ��ؿ�', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 9, '�˼��մϴ� ���� �ٽ� ��ǰ �����帮�ڽ��ϴ�.', sysdate);

--question �׽�Ʈ�� ������
insert into question values(seq_question_no.nextval, 'user03', 10, 20, '���� �ݹ���������..', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 10, '�˼��մϴ� ���� Ȯ���Ŀ� �ٷ� ó���ص帮�ڽ��ϴ�.', sysdate);

--question �׽�Ʈ�� ������
insert into question values(seq_question_no.nextval, 'user01', 11, 22, 'Ÿ���� �߾Ȼ�������!', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 11, '�˼��մϴ� ����..', sysdate);

--question �׽�Ʈ�� ������
insert into question values(seq_question_no.nextval, 'user02', 12, 24, '�� ��ѰǾ����� �ʹ��γ׿�.', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 12, '������?', sysdate);


--question �׽�Ʈ�� ������
insert into question values(seq_question_no.nextval, 'user01', 13, 26, '��ۿԴµ� �ʹ� �����׿�', sysdate);

--answer �׽�Ʈ�� ������ �Է�
insert into answer values(seq_answer_no.nextval, 13, '�˼��մϴ� �����Ϳ� ��ȭ�� �������ּ���.', sysdate);
commit;

insert into review values(seq_review_no.nextval, 'user01', 4, 1, 4, '���ڰ� �ʹ� �̻ڰ� ���������!', sysdate);

insert into review values(seq_review_no.nextval, 'user02', 5, 2, 5, '������ �ʹ� �̻���!', sysdate);

insert into review values(seq_review_no.nextval, 'user03', 6, 1, 4, 'Ŀ�ù����� ���̳׿�!', sysdate);

insert into review values(seq_review_no.nextval, 'user01', 7, 1, 5, '������ �ʹ� �߱￩��!', sysdate);

insert into review values(seq_review_no.nextval, 'user02', 8, 1, 2, '�������� ���γ׿�..', sysdate);

insert into review values(seq_review_no.nextval, 'user03', 9, 2, 1, '������ ��������..', sysdate);

insert into review values(seq_review_no.nextval, 'user01', 10, 1, 3, 'õ���̶� �� �ߴۿ���', sysdate);

insert into review values(seq_review_no.nextval, 'user02', 11, 2, 5, 'Ÿ�� �ʹ� �̻���!!', sysdate);

insert into review values(seq_review_no.nextval, 'user03', 12, 1, 4, '��Ѹ�ŭ ����ġ �ϳ׿�', sysdate);

insert into review values(seq_review_no.nextval, 'user01', 13, 2, 2, '�๰�۴µ� ����ǰڳ׿�', sysdate);

commit;