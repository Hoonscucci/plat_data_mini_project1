SELECT *
    FROM 고객정보 C
    FULL OUTER JOIN 주문정보 O ON C.회원번호 = O.회원번호
    FULL OUTER JOIN 결제정보 P ON O.주문번호 = P.주문번호
    ;