CREATE TABLE merged_raster AS
SELECT
    ST_Union(rast) AS rast
FROM exports;

SELECT
    ST_Width(rast),
    ST_Height(rast),
    ST_SRID(rast)
FROM merged_raster;
