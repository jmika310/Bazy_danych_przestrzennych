CREATE TABLE obiekty (
	id SERIAL PRIMARY KEY,
	nazwa VARCHAR(50),
	geom GEOMETRY
);

-- obiekt1
INSERT INTO obiekty (nazwa, geom)
VALUES (
    'obiekt1',
    ST_GeomFromText(
		'COMPOUNDCURVE(
			(0 1, 1 1), 
			CIRCULARSTRING(1 1, 2 0, 3 1, 4 2, 5 1), 
			(5 1, 6 1))', 0)
);

-- obiekt2
INSERT INTO obiekty (nazwa, geom)
VALUES (
    'obiekt2',
    ST_LinetoCurve(
        ST_Difference(
            ST_MakePolygon(
                ST_GeomFromText(
                    'LINESTRING(10 6, 14 6, 16 4, 14 2, 12 0, 10 2, 10 6)',
                    0
                )
            ),
            ST_Buffer(ST_MakePoint(12, 2), 1)
        )
    )
);


-- obiekt3
INSERT INTO obiekty (nazwa, geom)
VALUES ('obiekt3',
    ST_GeomFromText('POLYGON((7 15, 10 17, 12 13, 7 15))', 0)
);

-- obiekt4
INSERT INTO obiekty (nazwa, geom)
VALUES (
    'obiekt4',
    ST_GeomFromText(
        'LINESTRING(20.5 19.5, 22 19, 26 21, 25 22, 27 24, 25 25, 20 20)',0)
);

-- obiekt5
INSERT INTO obiekty (nazwa, geom)
VALUES (
    'obiekt5',
    ST_GeomFromText('GEOMETRYCOLLECTIONZ(POINTZ(30 30 59), POINTZ(38 32 234))', 0)
);

-- obiekt6
INSERT INTO obiekty (nazwa, geom)
VALUES (
    'obiekt6',
    ST_GeomFromText('GEOMETRYCOLLECTION(LINESTRING(1 1, 3 2), POINT(4 2))', 0)
);

SELECT *, ST_HasArc(geom) FROM obiekty