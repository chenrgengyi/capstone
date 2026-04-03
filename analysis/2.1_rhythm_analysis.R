library(ggplot2)
library(dplyr)
library(lubridate)
library(scales)
library(showtext)

final_species <- read_xlsx("/Users/gengyichen/Desktop/EDS/capstone/data/processed/species_encounter_final.xlsx") 

#load clean data
fox_clean <- final_species %>%
  filter(species == "赤狐") %>%
  mutate(
    time_decimal = decimal,
    season = ifelse(month %in% c(11,12,1,2), "Winter", "Summer"),
    is_daytime = ifelse(time_decimal >= 5/24 & time_decimal < 19/24, "白天", "夜间")
  ) %>%
  filter(!is.na(time_decimal))

#plot summer/winter data for visualization
fox_plot_data <- fox_clean %>%
  left_join(legend_info, by = c("season", "is_daytime"))
full_rhythmanalysis <- ggplot(fox_clean, aes(x = time_decimal, fill = season)) +
  geom_histogram(aes(y = ..density..), bins = 24, boundary = 0, color = "white") +
  coord_polar(start = 0) + 
  coord_polar(start = 0, clip = "off") +
  scale_x_continuous(
    limits = c(0, 1),
    breaks = seq(0, 0.9, by = 1/8),
    labels = c("00:00", "03:00", "06:00", "09:00", "12:00", "15:00", "18:00", "21:00")
  ) +
  scale_fill_manual(values = c("Winter" = "#E69F00", "Summer" = "#000092")) +
  theme_minimal() +
  labs(
    title = "Activity  Analysis of Red Fox (Winter vs Summer)",
    x = NULL, y = NULL, fill = "season"
  ) +
  theme(
    axis.text.y = element_blank(), 
    axis.text.x = element_text(size = 11, face = "bold", color = "black"),
    axis.ticks.y = element_blank(),
    panel.grid.major = element_line(color = "grey90"),
    legend.position = "bottom",
    plot.title = element_text(hjust = .5, face = "bold", size = 16),
    panel.spacing.x = unit(2, "cm"),
    plot.subtitle = element_text(hjust = 0.5)
  )
