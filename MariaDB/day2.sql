SELECT *, CONVERT(memberid, INT), CAST(memberid AS INT)
FROM membertbl;

SELECT *, CAST(memberid AS INT) FROM membertbl
WHERE CONVERT(memberid, INT);

/*
departments테이블에 값을 입력해주세요.
dept_no : d010
dept_name : 'business'
*/


INSERT into departments(dept_no,dept_name)
VALUES ('d010', 'business');
 

/*
2. employees 테이블에 근로자 등록
emp_no:500000
birth_date : 1999-10-10
first-name : Gildong
last_name : Hong
gender : M
hire_date : 2022-03-29
*/


INSERT INTO employees
(emp_no, birth_date, first_name, last_name, gender, hire_date)
VALUES
(500000, 1999-10-10, Gildong, Hong, M, 2022-03-29);

SELECT * FROM employees
WHERE emp_no = 500000;



/*
employees 테이블에서 여자면서 last_name에 'ch'가 있는 사람들
모두 select하시오
*/

SELECT * FROM employees
WHERE last_name LIKE '%ch%'
AND gender = 'F';


/*
	+ 생일이 1952년인 사람만
*/

SELECT LEFT(birth_date, 4) FROM employees;

SELECT * FROM employees
WHERE LEFT(birth_date, 4) = '1952';
-- 최종 
SELECT * FROM employees
WHERE last_name LIKE '%ch%'
AND gender = 'F'
AND LEFT(birth_date, 4) = '1952';

/*
	+ 생일이 9월인 사람만
*/

SELECT * FROM employees
WHERE last_name LIKE '%ch%'
AND gender = 'F'
AND LEFT(birth_date, 4) = '1952'
AND birth_date LIKE '____-09-__';

/*
	또는 1960년 이상만
*/

SELECT * FROM employees
WHERE last_name LIKE '%ch%'
AND gender = 'F'
AND LEFT(birth_date, 4) >= '1960';

/* mid 쓰는 법 mid(컬럼명, 뽑아낼 자릿수, 몇자리까지)*/

SELECT birth_date, RIGHT(birth_date, 2), MID(birth_date, 6, 2)
FROM employees;

/*
employees 테이블에서
emp_no: 500000 사원의
성별을 여성으로 바꾸고, hire_date는 2021-03-29로 바꾸고
first_name은 Jindong으로 변경
*/

UPDATE employees
SET gender = 'F', hire_date = '2021-03-29', first_name = 'Jindong'
WHERE emp_no = 500000;

SELECT * FROM employees
WHERE emp_no = 500000;

/*
employees 테이블에서 고용일자가 2020년 이후인 사람들 삭제하는 쿼리문
*/

DELETE FROM employees
WHERE left(hire_date, 4) >= 2020;

/*
emp_no = 499613인 근로자의  birth_date가 같은 사람 찾기
*/

SELECT * FROM employees
WHERE birth_date = '1953-06-09';

SELECT birth_date FROM employees
WHERE emp_no = 499613;

SELECT * FROM employees
WHERE birth_date = (SELECT birth_date FROM employees
WHERE emp_no = 499613);

/*
emp_no가 499619인 사람과 같은 성별을 갖고 있는 사람만 나타나도록 하라
sub쿼리에는 스칼라값(하나의 컬럼)만 나와야 한다.
*/

SELECT * FROM employees
WHERE gender = (SELECT gender FROM employees WHERE emp_no = 499619)
AND emp_no != 499619;


/* ANY와 ALL 쓰지말랍니다  */
SELECT salary FROM salaries WHERE emp_no = 10010;

SELECT * FROM salaries 
WHERE salary >= ALL (SELECT salary FROM salaries WHERE emp_no = 10010);

SELECT * FROM salaries 
WHERE salary >= ANY (SELECT salary FROM salaries WHERE emp_no = 10010);


/*
salaries 테이블에서 emp_no가 10010
*/


/*
오름차순 : 위에서 아래로 값이 커진다 -ASC
내림차순 : 위에서 아래로 값이 작아진다 - DESC
*/

SELECT * FROM salaries
WHERE emp_no IN (499988,499987,499976)
ORDER BY emp_no DESC, salary DESC;

-- 1990년 이후에 고용된 사람
SELECT * from employees 
where LEFT(hire_date, 4) >= 1990;

/* 생일과 성별 내림차순 */

SELECT * FROM employees
ORDER BY birth_date desc, gender DESC;

SELECT * from employees 
where LEFT(hire_date, 4) = 1985;

/*
생일이 1965년생 이상, 여자, 고용날 오름차순
*/
SELECT birth_date FROM employees WHERE LEFT(birth_date, 4) >= 1965;

SELECT * FROM employees
WHERE LEFT(birth_date, 4) >= 1965
AND gender = 'f'
ORDER BY hire_date;


