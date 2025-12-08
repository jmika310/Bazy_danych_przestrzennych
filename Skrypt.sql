CREATE EXTENSION postgis;
CREATE EXTENSION postgis_raster;

SELECT * FROM uk_250k

-- ze względu na wielkość danych ograniczyłem się do 6 kafli wokół PN Lake District
CREATE TABLE uk_250k_mosaic AS
SELECT ST_Union(rast) AS rast
FROM uk_250k;

SELECT * FROM national_park;

CREATE TABLE uk_lake_district AS
SELECT
  ST_Clip(u.rast, n.wkb_geometry) AS rast
FROM uk_250k_mosaic u, national_park n
WHERE ST_Intersects(u.rast, n.wkb_geometry)
  AND n.ogc_fid = 1;

SELECT * FROM uk_lake_district;

SELECT * FROM b04
SELECT * FROM b08

CREATE TABLE b04_mosaic AS
SELECT rid, ST_Union(rast) AS rast
FROM b04
GROUP BY rid;

CREATE TABLE b08_mosaic AS
SELECT rid, ST_Union(rast) AS rast
FROM b08
GROUP BY rid;

CREATE TABLE b04_clipped AS
SELECT ST_Clip(rast, (SELECT wkb_geometry FROM national_park WHERE ogc_fid = 1), true) AS rast
FROM b04_mosaic;

CREATE TABLE b08_clipped AS
SELECT ST_Clip(rast, (SELECT wkb_geometry FROM national_park WHERE ogc_fid = 1), true) AS rast
FROM b08_mosaic;

CREATE TABLE b04_mosaic_27700 AS
SELECT ST_Transform(rast, 27700) AS rast
FROM b04_mosaic;

CREATE TABLE b04_clipped AS
SELECT ST_Clip(
         rast,
         ST_Transform((SELECT wkb_geometry FROM national_park WHERE ogc_fid = 1), 27700),true) AS rast
FROM b04_mosaic_27700;

CREATE TABLE b08_mosaic_27700 AS
SELECT ST_Transform(rast, 27700) AS rast
FROM b08_mosaic;

CREATE TABLE b08_clipped AS
SELECT ST_Clip(
         rast,
         ST_Transform((SELECT wkb_geometry FROM national_park WHERE ogc_fid = 1), 27700),
         true
       ) AS rast
FROM b08_mosaic_27700;

CREATE TABLE ndwi AS
SELECT ST_MapAlgebraExpr(
          b4.rast, 
          b8.rast,
          '([rast1] - [rast2]) / ([rast1] + [rast2] + 0.000001)',
          '32BF'
       ) AS rast
FROM b04_clipped b4
JOIN b08_clipped b8
  ON ST_SameAlignment(b4.rast, b8.rast);

WITH template AS (
    SELECT rast AS rast_template FROM ndwi LIMIT 1
)
SELECT ST_Union(ST_Resample(rast, (SELECT rast_template FROM template))) AS rast
INTO ndwi_merged
FROM ndwi;
