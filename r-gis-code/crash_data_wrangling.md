Crash Data Wrangling
================

## Read the data

``` r
library(tidyverse)
```

    ## ── Attaching packages ──────────────────────────────────────────── tidyverse 1.2.1 ──

    ## ✔ ggplot2 3.0.0     ✔ purrr   0.2.5
    ## ✔ tibble  1.4.2     ✔ dplyr   0.7.7
    ## ✔ tidyr   0.8.1     ✔ stringr 1.3.1
    ## ✔ readr   1.1.1     ✔ forcats 0.3.0

    ## ── Conflicts ─────────────────────────────────────────────── tidyverse_conflicts() ──
    ## ✖ dplyr::filter() masks stats::filter()
    ## ✖ dplyr::lag()    masks stats::lag()

``` r
library(sp)
library(sf)
```

    ## Linking to GEOS 3.7.0, GDAL 2.3.2, PROJ 5.2.0

``` r
raw_data <- read_csv(
  "~/Projects/vision-zero-pdx/FilteredLessColumnsFullWithCalc.csv",
  col_types = cols(
    CRASH_DT = col_date(format = "%m/%d/%Y %H:%M"),
    LAT = col_double(),
    LON = col_double()
  )
)
```

## Compute day of week

We use the `lubridate::wday` function to compute the day of the week,
since it’s not in the raw data. Note that `lubridate` uses the
convention: 1 means Sunday and 7 means Saturday.

``` r
spatial_data <- 
  raw_data %>% mutate(WDAY = lubridate::wday(CRASH_DT))
```

## Make a simple features (`sf` package) data frame

``` r
spatial_data <- SpatialPointsDataFrame(
  coords = select(spatial_data, LON, LAT),
  data = select(spatial_data, CRASH_ID:WDAY),
  proj4string = CRS("+init=epsg:4326")
) %>% st_as_sf()
```

## Save as GeoJSON

``` r
unlink("crash_spatial.geojson") # `st_write` won't over-write a file
st_write(spatial_data, "crash_spatial.geojson")
```

    ## Writing layer `crash_spatial' to data source `crash_spatial.geojson' using driver `GeoJSON'
    ## features:       81983
    ## fields:         10
    ## geometry type:  Point
