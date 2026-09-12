-- ============================================================
-- m5_consultas_joins.sql
-- Pre-entrega: Consultas con JOINs para el proyecto — Cruzando tablas
-- Base de datos: Ventas_Tech_DB
-- Proyecto: TechStore
-- ============================================================

-- ── Consulta 1: Vista base del proyecto (INNER JOIN) ───────
-- Cruza ventas con clientes, productos y categorías para tener
-- en una sola fila: fecha, cliente, producto, cantidad, precio,
-- total de venta y las dimensiones descriptivas (ciudad, categoría).
SELECT
    v.fecha_venta,
    c.nombre           AS nombre_cliente,
    c.ciudad            AS ciudad_cliente,
    p.nombre_producto,
    cat.nombre_categoria AS categoria_producto,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas v
INNER JOIN clientes c   ON v.id_cliente = c.id_cliente
INNER JOIN productos p  ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta;

-- ── Consulta 2: Clientes sin ventas (LEFT JOIN) ────────────
-- Clientes registrados que nunca realizaron una compra.
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes c
LEFT JOIN ventas v ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL;

-- ── Consulta 3: Productos sin ventas (LEFT JOIN) ───────────
-- Productos del catálogo que nunca tuvieron una venta registrada.
SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos p
LEFT JOIN categorias cat ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas v ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL;

-- ── Consulta 4: Consolidado por canal (UNION ALL) ──────────
-- Nota: la base no tiene una columna real de "canal". Se crea como
-- valor literal dentro de cada SELECT, tal como pide la consigna.
-- Criterio elegido: categoría de producto, agrupando "Computación"
-- (la categoría que más factura) contra el resto del catálogo.
SELECT
    'Computación' AS canal,
    COUNT(*)      AS cantidad_ventas,
    SUM(v.cantidad * v.precio_unitario) AS total_facturado
FROM ventas v
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
WHERE cat.nombre_categoria = 'Computación'

UNION ALL

SELECT
    'Otras categorías' AS canal,
    COUNT(*)           AS cantidad_ventas,
    SUM(v.cantidad * v.precio_unitario) AS total_facturado
FROM ventas v
INNER JOIN productos p ON v.id_producto = p.id_producto
INNER JOIN categorias cat ON p.id_categoria = cat.id_categoria
WHERE cat.nombre_categoria <> 'Computación';
