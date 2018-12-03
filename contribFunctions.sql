--Returns true if the area of intersection is larger than both areas of the polygons after multiplied by the given proportion.
--it helps detect polygons that are similar

CREATE OR REPLACE FUNCTION similarByProportion(geomA geometry, geomB geometry, prop numeric) RETURNS boolean AS $$
  DECLARE
    areaA float := ST_Area(geomA);
    areaB float := ST_Area(geomB);   
    areaInt float := ST_Area(ST_Intersection(geomA, geomB));
    intersects boolean := ST_Intersects(geomA, geomB);
  BEGIN  
    IF intersects IS TRUE AND (areaInt >= areaA*prop AND areaInt >= areaB*prop) THEN
      return true;
    ELSE
      return false;
    END IF;
  END;
$$ LANGUAGE plpgsql;

--Returns true if the area of intersection is smaller than both areas of the polygons after multiplied by the given proportion.
--it helps detect polygons that are adjacent but overlap a little
CREATE OR REPLACE FUNCTION adjacentByProportion(geomA geometry, geomB geometry, prop numeric) RETURNS boolean AS $$
  DECLARE
    areaA float := ST_Area(geomA);
    areaB float := ST_Area(geomB);   
    areaInt float := ST_Area(ST_Intersection(geomA, geomB));
    intersects boolean := ST_Intersects(geomA, geomB);
  BEGIN  
    IF intersects IS TRUE AND (areaInt <= areaA*prop AND areaInt <= areaB*prop) THEN
      return true;
    ELSE
      return false;
    END IF;
  END;
$$ LANGUAGE plpgsql;

--Makes a simpler representation of a set of lines. It is useful for reducing scale of datasets
--A tolerance value mas be included for the neighbour and for the simplifying factor.
CREATE OR REPLACE FUNCTION simplifyMap(geom geometry, tolerance integer, factor numeric default .10 ) RETURNS geometry AS $$
  DECLARE
    factor2 := tolerance*factor;
  BEGIN  
    return ST_ApproximateMedialAxis(ST_Simplify(ST_Buffer(ST_Collect(geom), tolerance), factor2));
  END;
$$ LANGUAGE plpgsql;


