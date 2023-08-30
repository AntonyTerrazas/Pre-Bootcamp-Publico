/*1. ¿Qué consulta ejecutaría para obtener los ingresos totales para marzo de 2012?*/
SELECT YEAR(charged_datetime) AS Año, MONTHNAME(charged_datetime), SUM(amount) AS Ingresos
FROM billing
WHERE YEAR(charged_datetime) = 2012 AND MONTHNAME(charged_datetime) = "March";

/*2. ¿Qué consulta ejecutaría para obtener los ingresos totales recaudados del cliente con una identificación de 2?*/
SELECT clients.client_id, SUM(billing.amount) AS Monto
FROM billing
JOIN clients ON billing.client_id = clients.client_id
WHERE clients.client_id = 2;

/*3. ¿Qué consulta ejecutaría para obtener todos los sitios que posee client = 10?*/
SELECT clients.client_id, sites.domain_name AS website
FROM clients
JOIN sites ON clients.client_id = sites.client_id
WHERE clients.client_id = 10;

/*4. ¿Qué consulta ejecutaría para obtener el número total de sitios creados por mes por año 
para el cliente con una identificación de 1? ¿Qué pasa con el cliente = 20?*/
SELECT sites.client_id, COUNT(sites.site_id) AS N°id_site, MONTHNAME(sites.created_datetime) As Mes, YEAR(sites.created_datetime) AS Año
FROM sites
WHERE sites.client_id = 1 OR sites.client_id = 20
GROUP BY sites.site_id
ORDER BY sites.client_id ASC, sites.created_datetime ASC;

/*5. ¿Qué consulta ejecutaría para obtener el número total de clientes potenciales generados para cada uno de los sitios 
entre el 1 de enero de 2011 y el 15 de febrero de 2011?*/
SELECT sites.domain_name AS website, COUNT(leads.leads_id) AS N°leads, date_format(leads.registered_datetime, '%M %d,' ' %Y') AS fecha
FROM sites
JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime BETWEEN '2011-01-01 00:00:00' AND '2011-02-15 00:00:00'
GROUP BY leads.leads_id
ORDER BY leads.registered_datetime ASC;

/*6. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y 
el número total de clientes potenciales que hemos generado para cada uno de nuestros clientes 
entre el 1 de enero de 2011 y el 31 de diciembre de 2011?*/
SELECT CONCAT(clients.first_name, '  ' ,clients.last_name) AS nombre_cliente, COUNT(leads.leads_id) AS N°leads
FROM clients 
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime BETWEEN '2011-01-01 00:00:00' AND '2011-12-31 00:00:00'
GROUP BY CONCAT(clients.first_name, '  ' ,clients.last_name)
ORDER BY CONCAT(clients.first_name, '  ' ,clients.last_name) ASC;

/*7. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y 
el número total de clientes potenciales que hemos generado para cada cliente 
cada mes entre los meses 1 y 6 del año 2011?*/
SELECT CONCAT(clients.first_name, '  ' ,clients.last_name) AS nombre_cliente, COUNT(leads.site_id) AS N°leads, MONTHNAME(leads.registered_datetime) AS mes
FROM clients 
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime BETWEEN '2011-01-01 00:00:00' AND '2011-06-30 00:00:00'
GROUP BY nombre_cliente, mes
ORDER BY nombre_cliente, MONTHNAME(leads.registered_datetime) ASC;

/*8. ¿Qué consulta ejecutaría para obtener una lista de nombres de clientes y 
el número total de clientes potenciales que hemos generado para cada uno de los sitios de nuestros clientes 
entre el 1 de enero de 2011 y el 31 de diciembre de 2011? Solicite esta consulta por ID de cliente. 
Presente una segunda consulta que muestre todos los clientes, los nombres del sitio y 
el número total de clientes potenciales generados en cada sitio en todo momento.*/
SELECT CONCAT(clients.first_name, ' ' ,clients.last_name) AS nombre_cliente, sites.domain_name AS website, COUNT(leads.site_id) AS N_leads, MAX(date_format(leads.registered_datetime, '%M %d,' ' %Y')) AS fecha
FROM clients 
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime BETWEEN '2011-01-01 00:00:00' AND '2011-12-31 00:00:00'
GROUP BY nombre_cliente, website;

SELECT CONCAT(clients.first_name, ' ' ,clients.last_name) AS nombre_cliente, sites.domain_name AS website, COUNT(leads.site_id) AS N_leadsMAX, (date_format(leads.registered_datetime, '%M %d,' ' %Y')) AS fecha
FROM clients 
JOIN sites ON clients.client_id = sites.client_id
JOIN leads ON sites.site_id = leads.site_id
WHERE leads.registered_datetime BETWEEN '2011-01-01 00:00:00' AND '2012-12-31 00:00:00'
GROUP BY nombre_cliente, website;

/*9. Escriba una sola consulta que recupere los ingresos totales recaudados de cada cliente para cada mes del año. Pídalo por ID de cliente.*/
SELECT CONCAT(clients.first_name, ' ',clients.last_name) AS nombre_cliente, SUM(amount) AS monto_total, MONTHNAME(billing.charged_datetime) AS mes, YEAR(billing.charged_datetime) AS año
FROM billing
JOIN clients ON billing.client_id = clients.client_id
GROUP BY nombre_cliente, mes, año;

