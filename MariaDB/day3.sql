-- dept_emp 테이블에서 dept_no 종류가 몇개가 있는가

SELECT DISTINCT dept_no FROM dept_emp;

-- 사원의 직무가 무엇이 있는지 select 해주시오

SELECT DISTINCT title FROM titles;


-- limit  페이징 처리할때 씀. 강사님이 가장 좋아하는 실행문이라 함
-- limit ?

SELECT * FROM employees
LIMIT 20;
-- 위에서부터 20개

SELECT * FROM employees
LIMIT 0, 10;
-- 처음부터 10개만 보여줘

-- 가장 많은 연봉을 받은 금액 3개만 나오도록 해주시오

SELECT * FROM salaries
ORDER BY salary DESC
LIMIT 3;


SELECT * FROM salaries
ORDER BY salary DESC
LIMIT 4,6;


-- 테이블 복사 , 데이터만 복사되고 틀과 속성은 복사되지 않는다. 컬럼, 데이터타입, 레코드 복사
CREATE TABLE departments_temp2 AS
(SELECT * FROM departments);

-- 테이블 스키마 복사 (레코드 X)
CREATE TABLE departments_temp3
LIKE departments;

-- 내용삽입
INSERT INTO departments_temp3
SELECT * FROM departments;

-- 그룹 함수 min, max, sum, avg, count

SELECT MIN(salary) FROM salaries;

-- group by를 사용 안했을 때는 전체에서 값을 가져온다.

SELECT MIN(salary), MAX(salary), SUM(salary), AVG(salary), COUNT(salary)
FROM salaries;

-- group by 사용 예제

SELECT emp_no, MIN(salary), MAX(salary), SUM(salary), AVG(salary), COUNT(salary)
from salaries 
GROUP BY emp_no;

/* 부서별 사원 수, 부서별 사원수가 20,000명 이상인 부서만 나오도록 하고 싶다. */

SELECT dept_no, COUNT(*)
FROM dept_emp
GROUP BY dept_no
HAVING COUNT(*) >= 20000
ORDER BY COUNT(*) DESC;

/* Q. 가장 적은 salary를 받은 사람의 이름이 나오돍 해주세요 */

select emp_no FROM salaries
ORDER BY salary
LIMIT 1;

SELECT * from employees
WHERE emp_no = (select emp_no FROM salaries
ORDER BY salary
LIMIT 1);

-- auto increment
USE `test1`;

CREATE TABLE t_hobbit(
	i_hobbit INT unsigned AUTO_INCREMENT,
	nm VARCHAR(10) UNIQUE NOT NULL,
	PRIMARY KEY (i_hobbit)
	);
	
	
INSERT INTO t_hobbit (nm)
VALUES ('농구');

INSERT INTO t_hobbit (nm)
VALUES ('축구');

INSERT INTO t_hobbit (nm)
VALUES ('배구');

SELECT * FROM t_hobbit;


CREATE TABLE t_hobbit2(
	hobbit_id INT UNSIGNED PRIMARY KEY,
	NAME VARCHAR(20) NOT NULL,
	create_at DATETIME DEFAULT NOW()
	);
	
INSERT INTO t_hobbit2
(hobbit_id, NAME)
VALUES
(1, '핸드볼');

INSERT INTO t_hobbit2
(hobbit_id, NAME)
SELECT i_hobbit + 3, nm FROM t_hobbit;

/* 각 직업별로 평균 급여를 보고 싶으면???
	(아직 join을 배우지 않은 상태)
*/

SELECT title, AVG(salary) AS avg_salary
FROM titles A
INner JOIN salaries B
ON A.emp_no = B.emp_no
GROUP BY A.title;

-- emp_no : 10001의 모든 salary를 1,000씩 올리고 싶다.

UPDATE salaries
SET salary = salary + 1000
WHERE emp_no = 10001;

SELECT * FROM salaries
WHERE emp_no = 10001;

/* insert ignore, 여러개의 명령문을 실행시 앞의 명령문이 에러가 뜨면 실행이 멈추는데
 이 명령어로 에러를 무시하고 다음 명령문을 실행할수가 있다. */

INSERT ignore INTO t_hobbit2 (hobbit_id, NAME) VALUES (7, '탁구');
INSERT ignore INTO t_hobbit2 (hobbit_id, NAME) VALUES (8, '스키');

/*해당 위치에 값이 없을경우 다음의 값을 넣어주고, 
만약 동일한 값이 있을 시 다른 값을 삽입시켜줌 */
INSERT INTO t_hobbit2 ( hobbit_id, NAME) VALUES (7, '탁구')
ON DUPLICATE KEY UPDATE NAME = '수영';

INSERT INTO t_hobbit2 (hobbit_id, NAME) VALUES(8, '산책')
ON DUPLICATE KEY UPDATE NAME= '달리기';

DROP TABLE t_board;
CREATE TABLE t_board(
i_board INT UNSIGNED PRIMARY KEY,
title VARCHAR(20) UNIQUE NOT NULL,
hits INT UNSIGNED DEFAULT 0
);

SELECT * FROM t_board;

INSERT INTO t_board (i_board, title, hits) VALUES (1, '안녕', 0)
ON DUPLICATE KEY UPDATE hits = hits + 1;

-- 재귀법 방법1
WITH dept_emp_d001(emp_no, from_date, to_date)
AS (
	SELECT emp_no, from_date, to_date 
	FROM dept_emp
	WHERE dept_no = 'd001'
)
SELECT A.* FROM dept_emp_d001 AS A;

-- 방법2

SELECT A.* FROM
(
	SELECT emp_no, from_date, to_date
	FROM dept_emp
	WHERE dept_no = 'd001'
) A;

SELECT * FROM dept_emp_d001;


/*
	Q. 문제가 길다..
*/

CREATE TABLE T_ORDER (
	O_no INT primary KEY,
	cus_no INT,
	fOREIGN KEY(cus_no) REFERENCES t_customer(cus_no),
	o_date DATEtime DEFAULT NOW(),
	o_price INT DEFAULT 0
);

CREATE TABLE T_CUSTOMER (
	cus_no INT PRIMARY KEY,
	nm VARCHAR(10) NOT NULL
);

/* Q2 */



INSERT INTO t_order 
	(O_no, cus_no, o_price)
	values
	(1, 3, 55000),
	(2, 5, 70000),
	(3, 3, 60000);


INSERT INTO t_customer 
	(cus_no, nm)
	VALUES
	(3, '홍길동'),
	(5, '이순신');
	
UPDATE t_customer
SET nm = '장보고'
WHERE cus_no = 5;

DELETE from t_order
WHERE o_no = 2;

SELECT o_no, cus_no FROM t_order
WHERE cus_no = 3;