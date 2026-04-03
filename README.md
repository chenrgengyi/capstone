# EDS Captone: Red Fox Spatial Ecology in Agricultural Landscapes

## Project Summary
This study analyzes Red Fox activity patterns on an animal-friendly farmland in Northern China. Using R-based spatial heatmaps and seasonal/diel rhythm analysis, I identified that red fox encounters were significantly higher in winter, at night, and in open-spaced agricultural lands. These findings enable land managers to implement targeted, cost-effective conservation strategies and seasonal conflict-mitigation protocols.

## Project Structure and Reproducibility
- data/raw: Original spatial and species encounter data
- data/processed: Cleaned and processed joint dataset
- scripts: For initial data cleaning
- analyses: Analysis scripts (in R)
- visualizations: Generated plots and visualizations

Note on Version Control: The analytical workflow was developed locally in RStudio and migrated to GitHub. While the repository reflects the final iterative structure, the initial data cleaning from local directories was performed in an R environment.
Note on Usage: This project is for educational uses only. If there are any questions, please get in touch with chenrgengyi@gmail.com

## Key Findings
While the North China Leopard is the flagship species in the region, the Red Fox serves as a high-data proxy for understanding spatial patterns, predator-prey relationships, and available corridors. 

1. Seasonal Hotspots (Winter vs. Summer)
The spatial analysis reveals a significant expansion of hotspots during the winter months. Additionlly, temoral analysis supports this results, while summer months (july-oct) totaled 130 total activity encounters, winter months (nov-feb) had 367 total camera trap records.  
- Summer: Activity is fragmented and concentrated in peripheral forest edges.
- Winter: The heatmap shows a consolidated, high-intensity corridor  through the central farmland, likely driven by reduced human presence or shifting prey availability.

2. Diel Rhythms & Habitat Preference
Using circular activity plots, the data highlights a strong preference for nocturnal & open fields.
- Nocturnal Patterns: significant increase in activities seen at Open Fields camera stations and between 21:00 and 03:00.
- Water Sources: Activity near water sources is significantly lower in frequency, which could indicate favorable predator-prey condition.
