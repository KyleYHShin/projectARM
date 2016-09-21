show user;
--system이면 진행

create user arm identified by arm;

grant connect to arm; --접속권한
grant resource to arm; --테이블 관리 권한
GRANT CREATE TRIGGER TO arm; --트리거 생성 권한

/* 
1. 완료 후 sql Developer 좌측에서 새 접속 생성 클릭

2. 접속 이름 : ARM project
   사용자 이름 : arm
   비밀번호 : arm
   
3. 생성 완료 후 접속

4. 해당 계정에서 '2. ARM project DDL.sql' 실행

5. 해당 계정에서 '3. ARM project Test DML.sql' 실행

*/