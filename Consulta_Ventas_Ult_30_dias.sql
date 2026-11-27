SELECT
    CONCAT('Cliente ', c.CustomerID) AS NombreCliente,
    v.InvoiceNo,
    MAX(v.InvoiceDate) AS FechaCompra,
    SUM(v.TotalVenta) AS TotalVenta
FROM dbo.Ventas AS v
INNER JOIN dbo.Clientes AS c
    ON v.CustomerID = c.CustomerID
WHERE v.InvoiceDate >= DATEADD(
    DAY,
    -30,
    (SELECT MAX(InvoiceDate) FROM dbo.Ventas)
)
AND v.InvoiceDate <= (
    SELECT MAX(InvoiceDate)
    FROM dbo.Ventas
)
GROUP BY
    c.CustomerID,
    v.InvoiceNo
ORDER BY FechaCompra DESC;

