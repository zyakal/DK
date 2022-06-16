-- 224p~230p, 형변환 convert

SELECT '10';
SELECT CONVERT('10', INT);

SELECT '10' + '10';
SELECT CONVERT('10', INT) + CONVERT('10', INT);
SELECT 10;

SELECT CONVERT(10, CHAR);

-- 형변환, cast

SELECT CAST('10' AS INT);

-- 문자열 합치기 concat
SELECT 'A1' + '2B2';

SELECT CONCAT('A1', '2B2');

-- IF

SELECT if(100>200, '100>200', '100<200');

USE `employees`;

-- employees 테이블에 gender 값이 'M'이면 남자, 'F'이면 여자가 뜨도록 해주세요

SELECT gender FROM employees;

SELECT gender,if( gender='M', '남자', '여자') AS '성별'  FROM employees;

-- 응용 M이면 남자, F면 여자, A면 외계인

SELECT gender,if( gender='M', '남자', if(gender= 'F', '여자', '외계인')) AS '성별'  FROM employees
;

-- 응용2, 농구 > basketball, 배구 > valleyball, 축구 > football

SELECT nm, if(nm='농구', 'basketball', if(nm='배구', 'valleyball', 'football')) from t_hobbit;

-- ifnull (오라클 : nvl, SQL-Server : isnull)

SELECT *, IFNULL(memberaddress, '주소없음')
FROM membertbl;


SELECT CONCAT(nm,
		if(nm = '농구', 'basketball', if(nm='배구', 'valleyball', 'football')
	))
from t_hobbit;

-- nullif

SELECT NULLIF('안녕', '안녕');
SELECT NULLIF('안녕1', '안녕2');

-- case 값 when 비교값 then ... case로 시작해서 end로 끝나야한다

SELECT nm,
case nm when '농구' then 'basketball'
			when '배구' then 'valleyball'
			when '축구' then 'football'
			ELSE '없음'
	end
FROM t_hobbit;
-- case when 조건식 then...

SELECT
	nm,
	case when nm = '농구' then 'baketball'
			when nm = '배구' then 'valleyball'
			when nm = '축구' then 'football'
			ELSE '없음'
	end
FROM t_hobbit;
-- ASCII

SELECT ASCII('A');

-- 문자열합치기 concat, concat_ws
SELECT CONCAT_WS('_', 'A', 'B', 'C');

-- format 천단위 콤마, 실수 몇자리까지 나타낼지 선택
SELECT FORMAT(11112222, 0);

-- insert
SELECT INSERT ( 'abcdefghi', 3, 4, '@@@@');
SELECT INSERT ( 'abcdefghi', 3, 0, '@@@@');

-- upper, lower

SELECT 'aBc', 'AbC', 'aBc' = 'AbC', UPPER('aBc');

-- 빈칸 없애기
SELECT '    abc    ', TRIM('    a  bc   ');
SELECT TRIM(BOTH 'ㅋ' FROM 'ㅋㅋㅋㅋㅋㅋabcㅋㅋㅋㅋ');

-- date_format
SELECT *, DATE_FORMAT(create_at, '%Y/%m/%d %h:%i') FROM t_hobbit2;

SELECT STR_TO_DATE(create_at, '%l:%i %p') FROM t_hobbit2;