-- ============================================================
-- m4_consultas_negocio.sql
-- Pre-entrega: Consultas SQL de negocio — Extrayendo métricas clave con SQL
-- Base de datos: Ventas_Tech_DB (tabla ventas)
-- Proyecto: TechStore
-- ============================================================

-- ── Consulta 1: Resumen ejecutivo mensual ──────────────────
-- Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes
SELECT 
    EXTRACT(MONTH FROM fecha_venta) AS mes,
    SUM(cantidad * precio_unitario) AS total_facturado,
    COUNT(*) AS cantidad_pedidos,
    AVG(cantidad * precio_unitario) AS ticket_promedio
FROM ventas
GROUP BY EXTRACT(MONTH FROM fecha_venta)
ORDER BY mes;

-- ── Consulta 2: Ranking de productos (Top 5) ───────────────
-- Top 5 de id_producto por total facturado, con unidades vendidas
SELECT 
    id_producto,
    SUM(cantidad) AS unidades_vendidas,
    SUM(cantidad * precio_unitario) AS total_facturado
FROM ventas
GROUP BY id_producto
ORDER BY total_facturado DESC
LIMIT 5;

-- ── Consulta 3: Clientes recurrentes ───────────────────────
-- id_cliente con más de un pedido, cantidad de pedidos y total gastado
SELECT 
    id_cliente,
    COUNT(*) AS cantidad_pedidos,
    SUM(cantidad * precio_unitario) AS total_gastado
FROM ventas
GROUP BY id_cliente
HAVING COUNT(*) > 1;

-- ── Consulta 4: Meses por encima/debajo del promedio ───────
-- Total facturado por mes, etiquetado según si superó o no el promedio general
SELECT 
    mes,
    total_facturado,
    CASE 
        WHEN total_facturado > (SELECT AVG(total_mes) 
                                 FROM (SELECT SUM(cantidad * precio_unitario) AS total_mes
                                       FROM ventas
                                       GROUP BY EXTRACT(MONTH FROM fecha_venta)) AS sub)
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM (
    SELECT 
        EXTRACT(MONTH FROM fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY EXTRACT(MONTH FROM fecha_venta)
) AS resumen_mensual
ORDER BY mes;

-- ── Hallazgos ───────────────────────────────────────────────
-- 1. Todas las ventas cargadas corresponden a marzo de 2024, por lo que
--    el análisis mensual queda limitado a un único período con estos datos de prueba.
-- 2. El producto 1 concentra $3600 de facturación, muy por encima del resto
--    (el segundo, producto 3, factura $1350), siendo el principal generador de ingresos.
-- 3. Los 5 clientes de la base realizaron exactamente 2 pedidos cada uno,
--    por lo que el 100% de la cartera actual califica como "cliente recurrente".
