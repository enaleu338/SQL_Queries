/*1. Quantitat de registres de la taula de vols:*/

SELECT count(*) FROM flights;


/*2. Retard promig de sortida i arribada segons l�aeroport origen.*/

SELECT Origin as Origen, avg(ArrDelay) as promig_arribades, avg(DepDelay) as promig_sortides 
    from flights 
    group by Origin


/*3. Retard promig d�arribada dels vols, per mesos, anys i segons l�aeroport origen.*/ 

SELECT Origin as Origen, colYear as Any, colMonth as Mes, ArrDelay as Retard_arribada 
    from flights 
    order by Origin, colYear, colMonth, ArrDelay



/*4. Retard promig d�arribada dels vols, per mesos, anys i segons l�aeroport origen (mateixa consulta que
abans i amb el mateix ordre). Per� a m�s, ara volen que en comptes del codi de l�aeroport es mostri
el nom de la ciutat.*/

SELECT usairports.City as Ciutat, flights.colYear as Any, flights.colMonth as Mes, ArrDelay as Retard_arribada 
	from usairports 
	inner join flights on flights.Origin = usairports.iata
    order by City, colYear, colMonth, ArrDelay
    

/*5. Les companyies amb m�s vols cancelats, per mesos i any. A m�s, han d�estar ordenades de forma
que les companyies amb m�s cancel�lacions apareguin les primeres.*/

select UniqueCarrier as Companyia, colYear as Any, colMonth as Mes, count(cancelled) as vols_cancelats
	from flights 
    where cancelled >0
    group by UniqueCarrier, colYear
    order by count(cancelled) desc
    

/*6 L�identificador dels 10 avions que m�s dist�ncia han recorregut fent vols.*/

SELECT TailNum as Codi_Avi�, sum(Distance) as Dist�ncia_recorreguda FROM flights
    where TailNum like 'N%'
    group by TailNum
    order by sum(Distance) desc limit 10    

    
/*7. Companyies amb el seu retard promig nom�s d�aquelles les quals els seus vols arriben al seu dest�
amb un retard promig major de 10 minuts.*/

SELECT UniqueCarrier as Companyia, avg(ArrDelay) as Retard  FROM flights
    group by UniqueCarrier
    having avg(ArrDelay)>10
    order by avg(ArrDelay) desc