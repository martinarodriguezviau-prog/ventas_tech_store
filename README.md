# RetailPro: análisis de ventas de TechStore con SQL y Power BI

## Descripción
RetailPro es un proyecto de análisis de datos sobre TechStore, una cadena
de tecnología, desarrollado en el curso de análisis de datos de Coderhouse.
Modela una base de ventas relacional (Ventas_Tech_DB), responde preguntas
de negocio con SQL y arma un pipeline ETL en Power BI.

## Base de datos
Cuatro tablas: categorias, clientes, productos y ventas (tabla de hechos),
con claves primarias y foráneas. Los datos de prueba son 4 categorías,
5 clientes, 6 productos y 10 ventas de marzo de 2024.

## Archivos del repositorio
- `Ventas Tech Coder.sql`: crea la base y carga los datos de prueba.
- `m4_consultas_negocio.sql`: resumen mensual, ranking de productos,
  clientes recurrentes y meses sobre o bajo el promedio.
- `m5_consultas_joins.sql`: vista base con INNER JOIN, clientes y productos
  sin ventas con LEFT JOIN, y consolidado con UNION ALL.
- `Pipeline_ETL_RodriguezViau_Martina.pbix`: pipeline ETL en Power BI
  (limpieza y transformación con Power Query).
- `RodriguezViau_Martina_Checkpoint2.pbix`: modelo de datos en Power BI
  con relaciones y medidas DAX.

## Cómo ejecutar los scripts
Requisito: MySQL o MariaDB (el script usa el tipo TINYINT(1)).
1. Creá la base con `CREATE DATABASE Ventas_Tech_DB;` y seleccionala
   con `USE Ventas_Tech_DB;`.
2. Ejecutá `Ventas Tech Coder.sql`. Atención: empieza con DROP TABLE IF
   EXISTS y borra las tablas categorias, clientes, productos y ventas si
   ya existen.
3. Ejecutá `m4_consultas_negocio.sql` y `m5_consultas_joins.sql`, en
   cualquier orden: son independientes entre sí, pero necesitan la base
   cargada.

## Alcance y limitaciones
- Son datos de prueba: 10 ventas en un solo mes. Sirven para validar las
  consultas, no para sacar conclusiones de negocio ni de tendencia.
- La base no tiene costos, así que se analiza facturación y no ganancia.
- En la Consulta 4 de m5 el canal no existe en la base: es un valor literal
  que separa la categoría Computación del resto.

## Herramientas
MySQL, Power BI Desktop (Power Query y lenguaje M) y GitHub. La
documentación y la revisión del código se hicieron con asistencia de IA
(Claude) y se validaron manualmente.
