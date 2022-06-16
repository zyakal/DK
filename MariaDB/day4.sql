/* 모델링 & join */

CREATE TABLE t_member_hobbit (
	u_no INT UNSIGNED,
	h_no INT UNSIGNED,
	FOREIGN KEY(u_no) REFERENCES t_member(u_no),
	FOREIGN KEY(h_no) REFERENCES t_hobbit(h_no)
	
);

CREATE TABLE t_member (
	u_no INT UNSIGNED PRIMARY KEY,
	u_name VARCHAR(10)
);

CREATE TABLE t_hobbit (
	h_no INT UNSIGNED PRIMARY KEY,
	h_name VARCHAR(10)
);

/*----------------------------------------------------------------------------*/

DROP TABLE t_member_hobbit2;

CREATE TABLE t_member_hobbit2 (
	u_no CHAR(8),
	h_no INT UNSIGNED,
	PRIMARY KEY (u_no, h_no),
	FOREIGN KEY(u_no) REFERENCES membertbl(memberid),
	FOREIGN KEY(h_no) REFERENCES t_hobbit2(hobbit_id)
);
	
SELECT * FROM t_member_hobbit2;

INSERT INTO t_hobbit2 (hobbit_id, name) VALUES( 2, '등산');
INSERT INTO t_hobbit2 (hobbit_id, name) VALUES( 3, '게임');
INSERT INTO membertbl (memberid, membername) VALUES( '5', '아무개');
INSERT INTO membertbl (memberid, membername) VALUES( '7', '심사임당');

INSERT INTO t_member_hobbit2 (u_no, h_no) VALUES( '1', 1);
INSERT INTO t_member_hobbit2 (u_no, h_no) VALUES( '1', 2);
INSERT INTO t_member_hobbit2 (u_no, h_no) VALUES( '5', 3), ('5', 7), ('5', 8);
INSERT INTO t_member_hobbit2 (u_no, h_no) VALUES( '7', 6);

SELECT B.*, A.* FROM t_member_hobbit2 A
INNER JOIN membertbl B
ON A.u_no = B.memberid;

SELECT B.*, A.*, C.* FROM t_member_hobbit2 A
INNER JOIN membertbl B
ON A.u_no = B.memberid
INNER JOIN t_hobbit2 C
ON A.h_no = C.hobbit_id;


-- 사원번호, 사원명, 직책, 부서이름 나타나게 select

SELECT A.emp_no, A.first_name, A.last_name, B.title FROM employees A
INNER JOIN titles B
ON A.emp_no = B.emp_no;

SELECT D.dept_name FROM dept_emp C
INNER JOIN departments D
ON C.dept_no = D.dept_no;

SELECT A.emp_no, A.first_name, A.last_name, D.title, C.dept_name FROM employees A
INNER JOIN dept_emp B
ON A.emp_no = B.emp_no
INNER JOIN departments C
ON B.dept_no = C.dept_no
INNER JOIN titles D
ON A.emp_no = D.emp_no;



-- 남녀 사원의 평균 연봉 

SELECT A.gender, avg(B.salary) FROM employees A
INNER JOIN salaries B
ON A.emp_no = B.emp_no
GROUP BY A.gender;

-- 부서별 가장 높은 평균 연봉 값
-- 개인 평균 연봉 > 부서로 그룹만듦  >  가장 높은 연봉값

SELECT C.dept_name, AVG(A.salary)  FROM salaries A
INNER JOIN dept_emp B
ON A.emp_no = B.emp_no
INNER JOIN departments C
ON B.dept_no = C.dept_no
GROUP BY c.dept_name
ORDER BY AVG(A.salary) DESC;

-- ↑ 틀렸음 --
-- ↓ 정답 --

SELECT z.dept_no, MAX(Z.avg_salary) AS max_salary
FROM (
	SELECT B.dept_no, A.emp_no, AVG(A.salary) AS avg_salary 
	FROM salaries A
	INNER JOIN dept_emp B
	ON A.emp_no = B.emp_no
	GROUP BY A.emp_no
) Z
GROUP BY Z.dept_no;

-- 피드백 참고해서 다시 만들어봄 

SELECT x.dept_name, MAX(Z.avg_salary) AS max_salary
FROM (
	SELECT B.dept_no, A.emp_no, AVG(A.salary) AS avg_salary 
	FROM salaries A
	INNER JOIN dept_emp B
	ON A.emp_no = B.emp_no
	GROUP BY A.emp_no
) Z
INNER JOIN departments X
ON z.dept_no = x.dept_no
GROUP BY x.dept_name
ORDER BY max_salary desc;





-- 부서별 연봉 평균값, max값, min값 나오게

SELECT C.dept_name, AVG(A.salary), MAX(A.salary), MIN(A.salary) FROM salaries A
INNER JOIN dept_emp B
ON A.emp_no = B.emp_no
INNER JOIN departments C
ON B.dept_no = C.dept_no
GROUP BY dept_name;

-- 직무별 연봉 평균값

SELECT B.title, AVG(A.salary) FROM salaries A
INNER JOIN titles B
ON A.emp_no = B.emp_no
GROUP BY B.title;

