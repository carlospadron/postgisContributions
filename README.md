# Postgis Contributions
Contains Postgis functions that are not part of the main library

## Functions
### similarByProportion
Returns true if the area of intersection is larger than both areas of the polygons after multiplied by the given proportion.
It helps detect polygons that are similar.

### adjacentByProportion
Returns true if the area of intersection is smaller than both areas of the polygons after multiplied by the given proportion.
It helps detect polygons that are adjacent but overlap a little.

### simplifyMap
Makes a simpler representation of a set of lines. It is useful for reducing scale of datasets
A tolerance value mas be included for the neighbour and for the simplifying factor.
