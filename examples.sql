SELECT 
  overlapLessThan(
    ST_MakeBox2D(ST_Point(0,0), ST_Point(10,10))::geometry, 
    ST_MakeBox2D(ST_Point(9,9), ST_Point(19,19))::geometry, 
    .01)
SELECT 
  overlapMoreThan(
    ST_MakeBox2D(ST_Point(0,0), ST_Point(10,10))::geometry, 
    ST_MakeBox2D(ST_Point(9,9), ST_Point(19,19))::geometry, 
    .01)	
SELECT				 
  ST_ApproximateMedialAxis(ST_Buffer(ST_Simplify(ST_Collect(planet_osm_roads.way), 1000), 10000))
FROM 
  public.planet_osm_roads 
WHERE 
  planet_osm_roads.highway IN ('motorway', 'motorway_link');
				 			 
DROP TABLE public.test;
SELECT				 
  simplifyRoadMap(ST_Collect(planet_osm_roads.way), 10000) AS geom
INTO
  public.test
FROM 
  public.planet_osm_roads 
WHERE 
  planet_osm_roads.highway IN ('motorway', 'motorway_link');