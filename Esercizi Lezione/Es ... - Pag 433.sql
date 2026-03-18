/*	SUBQUERY - FROM
ES ? : Mostrare il numero massimo, minimo e medio di pezzi inseriti negli ordini */

SELECT max(pezzi), min(pezzi),
floor(avg(pezzi)) as media
FROM (SELECT orderNumber,
SUM(quantityordered) AS pezzi
FROM orderdetails
GROUP BY orderNumber) AS lineitems;