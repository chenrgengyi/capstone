library(tidyverse)
library(lubridate)
library(exiftoolr)
library(fs)
library(readxl)
library(dplyr)
library(tidyr)
library(tidyverse)
library(lubridate)


#====initial data cleaning/visualization====
base_path <- "/Users/gengyichen/Desktop/EDS/capstone/202601" 
print(dir_ls(base_path, type = "directory"))
all_files <- dir_ls(base_path, recurse = TRUE)

# 1. path to table
video_table <- tibble(full_path = as.character(all_files)) %>%
  filter(str_detect(full_path, "(?i)\\.(mp4|avi|mov)$"))

# 2. 
final_output <- video_table %>%
  mutate(
    path_parts = str_split(full_path, "/"),
    camera_id = map_chr(path_parts, ~ .x[length(.x) - 2]),
    species = map_chr(path_parts, ~ .x[length(.x) - 1]),
    file_name = basename(full_path),
    raw_ts = str_extract(file_name, "\\d{4}-\\d{2}-\\d{2}_\\d{2}-\\d{2}-\\d{2}"),
    shot_time = ymd_hms(raw_ts),
    date = as.Date(shot_time),
    time = format(shot_time, "%H:%M:%S")
  ) %>%
  select(camera_id, date, species, time) %>%
  arrange(camera_id, date, time)

final_output <- final_output %>%
  mutate(species = str_trim(species)) %>% # get rid of spaces
  mutate(species = case_when(
    str_detect(species, "赤狐") ~ "赤狐", # 赤狐 stand for red fox
    TRUE ~ species
  ))

print(head(final_output))
