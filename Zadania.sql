-- Zadanie 2
SELECT ST_Area(
			ST_Buffer(
				ST_ShortestLine(o3.geom, o4.geom), 5))
FROM obiekty o3, obiekty o4
WHERE o3.nazwa='obiekt3' 
AND o4.nazwa='obiekt4';

-- Zadanie 3 
-- Warunek podstawowy: linia musi tworzyć zamknięty obszar
UPDATE obiekty
SET geom = ST_MakePolygon(
				ST_AddPoint(geom, ST_StartPoint(geom))
           )
WHERE nazwa = 'obiekt4';

SELECT * from obiekty
WHERE nazwa = 'obiekt4';

-- Zadanie 4
INSERT INTO obiekty (nazwa, geom)
SELECT'obiekt7', ST_Union(o3.geom, o4.geom)
FROM obiekty AS o3, obiekty AS o4
WHERE o3.nazwa = 'obiekt3' AND o4.nazwa = 'obiekt4';

SELECT * from obiekty
WHERE nazwa = 'obiekt7';

-- Zadanie 5
SELECT 
	SUM(ST_Area(ST_Buffer(geom, 5))) AS suma_pol
FROM obiekty
WHERE ST_HasArc(geom) = 'false';
