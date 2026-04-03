#!/usr/bin/env python3
"""
Clean and validate temperature data for Mojiang County, Yunnan (1960–2021).

This script:
- Loads raw temperature data
- Converts all temperature columns (MeanTemp, MaxTemp, MinTemp) from °C to °F
- Handles missing or invalid values
- Saves a cleaned version to data/processed/
"""

import pandas as pd
import numpy as np

def clean_temperature(input_file, output_file):
    """Clean raw temperature data and save processed version."""

    # Read raw data
    df = pd.read_csv(input_file)

    # List of temperature columns to convert
    temp_cols = ['MeanTemp', 'MaxTemp', 'MinTemp']

    # Ensure columns exist to avoid errors
    for col in temp_cols:
        if col in df.columns:
            df[col] = df[col] * 9/5 + 32   # Celsius → Fahrenheit

    # (Optional) Example of removing impossible values after conversion
    # Max possible temp ~ 140°F, min ~ -60°F (adjust to your domain knowledge)
    df.loc[(df['MaxTemp'] > 140) | (df['MaxTemp'] < -60), 'MaxTemp'] = np.nan
    df.loc[(df['MinTemp'] > 140) | (df['MinTemp'] < -60), 'MinTemp'] = np.nan
    df.loc[(df['MeanTemp'] > 140) | (df['MeanTemp'] < -60), 'MeanTemp'] = np.nan

    # Save cleaned + converted data
    df.to_csv(output_file, index=False)
    print(f"Cleaned & converted data saved to {output_file}")

    return df


if __name__ == "__main__":
    clean_temperature(
        'data/raw/mojiang_weather_1960_2021.csv',
        'data/processed/mojiang_weather_1960_2021_clean.csv'
    )
