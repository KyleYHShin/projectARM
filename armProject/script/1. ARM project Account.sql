show user;
--system�̸� ����

create user arm identified by arm;

grant connect to arm; --���ӱ���
grant resource to arm; --���̺� ���� ����
GRANT CREATE TRIGGER TO arm; --Ʈ���� ���� ����

/* 
1. �Ϸ� �� sql Developer �������� �� ���� ���� Ŭ��

2. ���� �̸� : ARM project
   ����� �̸� : arm
   ��й�ȣ : arm
   
3. ���� �Ϸ� �� ����

4. �ش� �������� '2. ARM project DDL.sql' ����

5. �ش� �������� '3. ARM project Test DML.sql' ����

*/