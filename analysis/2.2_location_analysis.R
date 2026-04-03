# Note that the mapping component of the location analyses were primarily exploratory and done through QGIS

library(ggplot2)
library(dplyr)
library(lubridate)
library(scales)
library(showtext)

final_species <- read_xlsx("/Users/gengyichen/Desktop/EDS/capstone/data/processed/species_encounter_final.xlsx") 
#or use this path instead: data/processed/combined_camera_data.csv

#load clean data
fox_clean <- final_species %>%
  filter(species == "赤狐") %>%
  mutate(
    time_decimal = decimal,
    season = ifelse(month %in% c(11,12,1,2), "Winter", "Summer"),
    is_daytime = ifelse(time_decimal >= 5/24 & time_decimal < 19/24, "白天", "夜间")
  ) %>%
  filter(!is.na(time_decimal))

#plot open field/water sources cameras for visualization
fox_camdata <- fox_clean %>%
  mutate(
    habitat = ifelse(grepl("^A", camera_number), "Open Fields", "Water Sources"),
    is_daytime = ifelse(time_decimal >= 5/24 & time_decimal < 19/24, "Day", "Night")
  ) %>%
  filter(!is.na(time_decimal))

ggplot(fox_camdata, aes(x = time_decimal, fill = is_daytime)) +
  geom_histogram(bins = 24, boundary = 0, color = "white", linewidth = 0.5) +
    coord_polar(start = 0) +
    scale_x_continuous(
    limits = c(0, 1),
    breaks = seq(0, 7/8, by = 1/8),
    labels = c("0:00", "3:00", "6:00", "9:00", "12:00", "15:00", "18:00", "21:00")
  ) +
    scale_fill_manual(values = c("Day" = "orange", "Night" = "darkblue")) +
    facet_wrap(~habitat) +
    labs(
    title = "Red Fox (Vulpes vulpes ssp) Activity Rhythm",
    subtitle = "Open Fields vs. Water Sources",
    x = "Time of Day", 
    y = "Frequency",
    fill = "Period"
  ) +
  theme_bw() + 
  theme(
    panel.grid.major = element_line(color = "black", linewidth = 0.1), 
    strip.background = element_rect(fill = "grey90"),
    strip.text = element_text(size = 12, face = "bold"),
    axis.text.y = element_blank(),
    axis.ticks = element_blank(),
    legend.position = "bottom"
  )
