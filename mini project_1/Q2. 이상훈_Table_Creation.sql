CREATE TABLE 고객정보(
    회원번호 NUMBER PRIMARY KEY, -- PRIMARY KEY 생성
    회원등급 VARCHAR2(20),
    가입일 DATE,
    최종방문일 DATE,
    본인인증 VARCHAR2(20),
    성별 VARCHAR2(10),
    나이 VARCHAR2(10),
    배송지도로명 VARCHAR2(200),
    배송지지번 VARCHAR2(200)
    );
    
CREATE TABLE 상품정보(
    상품번호 VARCHAR2(200) PRIMARY KEY,
    상품명 VARCHAR2(300),
    업체명 VARCHAR2(50),
    카테고리명 VARCHAR2(50),
    브랜드명 VARCHAR2(50),
    상품구분 VARCHAR2(20),
    대표판매가 NUMBER(10,2),
    배송비 VARCHAR2(50),
    판매상태 VARCHAR2(20),
    전시상태 VARCHAR2(20)
    );
    
CREATE TABLE 주문정보(
    주문번호 NUMBER,
    순번 NUMBER,
    주문일시 DATE,
    진행구분 VARCHAR2(20),
    배송지 VARCHAR2(100),
    상품번호 VARCHAR2(200),
    수량 NUMBER,
    판매가 NUMBER(10,2),
    배송비 NUMBER(10,2),
    쿠폰할인액 NUMBER(10,2),
    회원주문여부 VARCHAR2(10),
    회원번호 NUMBER,
    PRIMARY KEY (주문번호, 순번) -- 2개의 컬럼으로 PRIMARY KEY 설정 
    );

CREATE TABLE 결제정보(
    주문번호 NUMBER,
    결제번호 NUMBER,
    결제일시 DATE,
    진행구분명 VARCHAR2(20),
    결제수단 VARCHAR2(30),
    결제금액 NUMBER(10,2),
    카드사 VARCHAR2(30),
    할부개월 NUMBER,
    PRIMARY KEY(주문번호, 결제번호)
    );
    
CREATE TABLE 환불정보(
    주문번호 NUMBER,
    환불번호 NUMBER PRIMARY KEY,
    진행구분 VARCHAR2(20),
    결제수단 VARCHAR2(30),
    환불금액 NUMBER(10,2),
    할부개월 NUMBER,
    환불일자 DATE
    );
    
DROP TABLE 고객정보;
DROP TABLE 상품정보;
DROP TABLE 주문정보;
DROP TABLE 결제정보;
DROP TABLE 환불정보;

SELECT * FROM 환불정보;


ALTER TABLE 상품정보 MODIFY 상품명 VARCHAR2(300);   -- 상품정보의 상품명이 VARCHAR2(200) 이였는데 입력하기에 모자라다는 오류 메세지로 MODIFY 함수를 사용하여 CARCHAR2(300)으로 변경
ALTER TABLE 결제정보 RENAME COLUMN 견제번호 TO 결제번호;  -- 컬럼명을 오입력해서 테이블 생성후 컬럼명 변경
ALTER TABLE 결제정보 RENAME COLUMN 진행구분 TO 진행구분명;
ALTER TABLE 결제정보 MODIFY 결제수단 VARCHAR2(30);



SELECT 결제번호, COUNT(*) FROM 결제정보  -- 결제번호로 PRIMARY KEY를 만들려고 했는데 만들어지지 않아 카운팅하여 값 확인, 2이상의 카운트 값이 없음에도 PRIMARY KEY로 설정 할 수 없는 이유는 모르겠음 ㅜㅜ
GROUP BY 결제번호
Having COUNT(*) > 1;

ALTER TABLE 주문정보
ADD CONSTRAINT FK_회원번호 FOREIGN KEY(회원번호) REFERENCES 고객정보(회원번호); --주문정보의 회원번호를 고객정보의 회원번호를 참조하여 FOREIGN KEY 를 만들려고 하였지만 오류가 발생

SELECT 회원번호
    FROM 고객정보
MINUS
SELECT 회원번호
    FROM 주문정보;  -- 상기 오류 원인을 찾고자 두 테이블간의 회원번호 비교 - 고객정보에 없는 회원번호가 주문정보에 있어서 FOREIGN KEY로 사용할 수 없었음 FK 없이 코드 마무리
    
    
