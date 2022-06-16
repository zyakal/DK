--DCL (데이터 제어어)(유저 만들고, 유저 권한 주고)
--우리가 쓸일은 잘 없음


--DDL (데이터 정의어)

create DATABASE test1;




CREATE TABLE memberTBL (
	memberID CHAR(8) NOT NULL PRIMARY key,
	memberName CHAR(5) NOT NULL,
	memberAddress CHAR(20) NULL
);

DROP TABLE membertbl;

CREATE TABLE productTBL(
	productName CHAR(4) PRIMARY KEY,
	cost INT NOT NULL,
	MAKEDATE DATE,
	company CHAR(5),
	amount INT NOT null
);
/*
INSERT INTO 테이블명
(값을 넣고 싶은 컬럼명)
VALUES
(값들) */
INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES
(1, '홍길동','서울시');
INSERT INTO membertbl
(memberid, membername, memberaddress)
VALUES
(2, '홍길동','서울시');
INSERT INTO membertbl
(memberid, membername)
VALUES
(3, '홍길동');

--membername은 NOT NULL 때문에 에러가 발생한다

INSERT INTO membertbl
(memberid)
VALUES(4);

INSERT INTO membertbl
(memberid, membername)
VALUES
(5, '심사임당'),
(6, '유관순'),
(7, '나이팅게일');

/* Read(select문)
select 보고싶은 컬럼명들 from 테이블명
[where 보고싶은 조건]
[group by 그룹으로 묶는 조건]
[having 그룹으로 묶는 조건에서의 조건]
[order by 레코드 순서 지정]
[limit 보고싶은 레코드 수 ] */

SELECT memberid, membername, memberaddress
FROM membertbl;

SELECT * FROM membertbl; -- *(와일드카드)를 붙이면 전체

SELECT * FROM membertbl
WHERE memberid = '1';

SELECT * FROM membertbl
WHERE memberid != '1';test1

-- !는 not의 뜻을 가진다. 단, null은 포함되지 않는다.
/* 또한 null일 경우를 검색하고 싶다면 
SELECT * FROM membertbl
WHERE memberid is null; 이라 적어줘야한다.
*/

SELECT * FROM membertbl
where memberaddress IS NULL;

/*주소가 '부산시'이면서 이름이 '사나이'인 레코드를 나타나게 하시오.*/

SELECT * FROM membertbl
where memberaddress = '부산시'
AND membername = '사나이';

-- update (update문)
/* 
	update 테이블명
	set 수정하고 싶은 컬럼명 = 변경하고 싶은 값
	where 레코드 선택
*/

-- like문은 문자열 포함된 레코드를 찾을 때
SELECT * FROM membertbl
WHERE membername LIKE '%팅%';

SELECT * FROM membertbl
WHERE membername LIKE '사%';

SELECT * FROM membertbl
WHERE membername LIKE '나%';


UPDATE membertbl
SET membername = '게일'
WHERE memberid = '7';

UPDATE membertbl
SET membername = 'gugu'
, memberaddress = '강원도'
WHERE memberid = '9';

INSERT INTO membertbl
(memberid, membername)
VALUES
(8, '사나이'),
(9, '아무거나');

 -- Delete (delete문)
 
 /* 
 DELETE FROM 테이블명 WHERE 절
 주소가 null 레코드 전부 삭제
 null 은 is , is not 로 표현한다.
 */
  
DELETE FROM membertbl
WHERE memberaddress IS NULL;


SELECT * FROM employees
WHERE emp_no >= 10000 AND emp_no <= 10010;

SELECT * FROM membertbl
WHERE membername BETWEEN '홍길동' AND '홍길딯'
and memberid >= '2' AND memberid <= '3';

SELECT * FROM membertbl
WHERE memberid >= '2' AND memberid <= '3';


SELECT * FROM departments
WHERE dept_no IN ('d001', 'd003', 'd005');

SELECT * FROM employees
WHERE emp_no % 2 = 0;

-- departments 의 PK값 홀수만 선택하기
SELECT *from departments 
where CONVERT(SUBSTR(dept_no,2),INT) % 2 = 1;

--가상넘버 줘서 정렬, 묶어서 실행
SET @rownum:=0;
SELECT (@rownum:=@rownum+1) AS myno, A.*
FROM employees A
WHERE (@rownum:=0)=0;

