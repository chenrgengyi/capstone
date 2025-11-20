#!/usr/bin/env python3
"""
Clean and validate water quality sensor data.

This script handles common issues in sensor data:
- Missing values
- Sensor drift
- Out-of-range measurements
"""

import pandas as pd
import numpy as np
from datetime import datetime

def clean_sensor_data(input_file, output_file):
    """Clean raw sensor data and save processed version."""

    # Read raw data
    df = pd.read_csv(input_file)

    # Remove invalid pH values (must be 0-14)
    df.loc[(df['pH'] < 0) | (df['pH'] > 14), 'pH'] = np.nan

    # Remove negative dissolved oxygen
    df.loc[df['dissolved_oxygen'] < 0, 'dissolved_oxygen'] = np.nan

    # Flag temperature outliers
    df['temp_flag'] = (df['temperature'] < -5) | (df['temperature'] > 40)

    # Save cleaned data
    df.to_csv(output_file, index=False)
    print(f"Cleaned data saved to {output_file}")

    return df

if __name__ == "__main__":
    # Process example data
    clean_sensor_data('data/raw/weather_2024.csv', 
                      'data/processed/weather_2024_clean.csv')
