-- 1)
SELECT b2019.*
FROM budynki_2019 AS b2019
JOIN budynki_2018 AS b2018
  ON ST_Intersects(b2019.geom, b2018.geom)
WHERE b2018.polygon_id IS NULL OR NOT ST_Equals(b2019.geom, b2018.geom);

-- 2)
SELECT p.type, COUNT(*) AS liczba_poi
FROM punkty_2019 p
JOIN budynki_2019 b ON ST_DWithin(p.geom, b.geom, 500)
WHERE p.poi_id NOT IN (SELECT poi_id FROM punkty_2018)
  AND b.polygon_id NOT IN (SELECT polygon_id FROM budynki_2018)
GROUP BY p.type;

-- 3)
CREATE TABLE streets_reprojected AS
SELECT *, ST_Transform(geom, 3068) AS geom_3068
FROM t2019_kar_streets;

-- 4)
CREATE TABLE input_points (
    id SERIAL PRIMARY KEY,
    geom geometry(Point, 4326));

INSERT INTO input_points (geom) VALUES
(ST_SetSRID(ST_MakePoint(8.36093, 49.03174), 4326)),
(ST_SetSRID(ST_MakePoint(8.39876, 49.00644), 4326));

-- 5)
UPDATE input_points
SET geom = ST_Transform(geom, 3068);

--SELECT Find_SRID('public', 'input_points', 'geom');

-- 6)
CREATE TABLE skrzyzowania AS
SELECT DISTINCT st.*
FROM streets_reprojected st, input_points ip
WHERE ST_DWithin(st.geom, ST_Transform(ip.geom, 4326), 200);

SELECT * FROM skrzyzowania

-- 7)
SELECT COUNT(DISTINCT p19.*) AS ilosc
FROM public.punkty_2019 AS p19
JOIN public.parki AS p
    ON ST_DWithin(p19.geom, p.geom, 300)
WHERE p19.type = 'Sporting Goods Store';

-- 8)
CREATE TABLE "T2019_KAR_BRIDGES" AS
SELECT ST_Intersection(t.geom, c.geom) AS geom
FROM tory t, cieki c
WHERE ST_Intersects(t.geom, c.geom);

SELECT * FROM "T2019_KAR_BRIDGES"

