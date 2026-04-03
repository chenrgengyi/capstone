library(sf)
library(fs)
library(tidyverse)
library(mapview)

# Load shapefile 
stations_sf <- st_read("/Users/gengyichen/Desktop/EDS/capstone/data/raw/leopardfield_station.shp")

# Keep only functional columns
stations_cleaned <- stations_sf %>%
  select(
    name = Name, 
    type = Type, 
    lon = Longtitude, 
    lat = Latitude, 
    altitude = Altitude,
    obs_time = Time,
    geometry
  ) %>%
  filter(!is.na(lon) & !is.na(lat)) %>% 
  filter(obs_time != 0)

# Load final output： note here I did manipulate data outside of RStudio, mainly to make sure that time has been converted correctly
# for example, the time column was broken down by hour, minute, and second, and the formula(=(HOUR(G3)*3600 + MINUTE(G3)*60 + SECOND(G3))/86400) 
# was converted to decimal (just to double check)
final_output <- read_xlsx("/Users/gengyichen/Desktop/EDS/capstone/data/processed/species_encounter_final.xlsx")

encounters_df <- final_output
final_merge <- stations_cleaned %>%
  inner_join(encounters_df, by = c("name" = "camera_number"))

#output final merge file as spatial output
st_write(final_merge, "/Users/gengyichen/Desktop/EDS/capstone/data/processed/final_merge.shp", delete_layer = TRUE)
