-- a)
SELECT SUM(ST_Length(geometry)) as Dlugosc_drog
FROM roads;

-- b)
SELECT
	name,
	ST_AsText(geometry) as wkt,
	ST_Area(geometry) as pole,
	ST_Perimeter(geometry) as obwód
FROM buildings
WHERE name='BuildingA';

-- c)
SELECT
	name,
	ST_Area(geometry) as pole
FROM buildings
ORDER BY name ASC;

-- d)
SELECT
	name,
	ST_Area(geometry) as pole,
	ST_Perimeter(geometry) as obwod
FROM buildings
ORDER BY pole DESC
LIMIT 2;

-- e)
SELECT 
    ST_Distance(b.geometry, p.geometry) AS odleglosc
FROM buildings b, poi p
WHERE b.name = 'BuildingC' AND p.name = 'K';

-- f)
SELECT 
    ST_Area(
        ST_Difference(
            b1.geometry, 
            ST_Buffer(b2.geometry, 0.5)
        )
    ) AS pole_poza
FROM buildings b1, buildings b2
WHERE b1.name = 'BuildingC' AND b2.name = 'BuildingB';

-- g)
SELECT 
    b.name
FROM buildings b, roads r
WHERE r.name = 'RoadX'
  AND ST_Y(ST_GeomFromText('POINT(' || 
        (ST_XMax(b.geometry) + ST_XMin(b.geometry))/2 || ' ' ||
        (ST_YMax(b.geometry) + ST_YMin(b.geometry))/2 || ')', 0)) 
      > ST_Y(r.geometry);

-- h)
SELECT 
    ST_Area(b.geometry) + ST_Area(ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))', 0)) 
	- 2 * ST_Area(ST_Intersection(b.geometry, 
            ST_GeomFromText('POLYGON((4 7, 6 7, 6 8, 4 8, 4 7))', 0))
    ) AS pole
FROM buildings b
WHERE b.name = 'BuildingC';


