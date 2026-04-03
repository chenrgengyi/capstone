library(dplyr)
library(readr)
library(readxl)

# Define the file names
df1 <- read_xlsx("/Users/gengyichen/Desktop/EDS/capstone/data/raw/A_Camera_Data_2025.xlsx", col_types = "text")
df2 <- read_xlsx("/Users/gengyichen/Desktop/EDS/capstone/data/raw/AB_Camera_Data_2026.xlsx", col_types = "text")
df3 <- read_xlsx("/Users/gengyichen/Desktop/EDS/capstone/data/raw/B_Camera_Data_2025.xlsx", col_types = "text")

# Standardize var. names
df2 <- df2 %>% 
  rename(camera_number = camera_id)

# Combine all three data frames
combined_data <- bind_rows(df1, df2, df3) %>% 
  filter(!is.na(species))


# Export files
write_csv(combined_data, "Combined_Camera_Data_2025_2026.csv")
