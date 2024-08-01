import pandas as pd
import struct
import math as math
df = pd.read_csv('FirstGenPokemon.csv')

type_conversion = {
    'None': 99,
    'normal': 0,
    'fighting': 1,
    'flying': 2,
    'poison': 3,
    'ground': 4,
    'rock': 5,
    'bug': 6,
    'ghost': 7,
    'steel': 8,
    'fire': 9,
    'water': 10,
    'grass': 11,
    'electric': 12,
    'psychic': 13,
    'ice': 14,
    'dragon': 15,
    'dark': 16,
    'fairy': 17
}

# Function to convert types to their corresponding numbers
def convert_type(type_value):
    return type_conversion[type_value] if type_value in type_conversion else -1

# Extract the relevant columns
df_extracted = df[["Number", " Type1", " Type2"]]

# Replace NaN values with None
# Use .loc to avoid SettingWithCopyWarning
df_extracted.loc[:, ' Type1'] = df_extracted[' Type1'].fillna("None")
df_extracted.loc[:, ' Type2'] = df_extracted[' Type2'].fillna("None")

# Replace the type strings with their corresponding numbers
df_extracted.loc[:, ' Type1'] = df_extracted[' Type1'].apply(convert_type)
df_extracted.loc[:, ' Type2'] = df_extracted[' Type2'].apply(convert_type)

# Output the result to separate text files
# Function to write a column to a binary file
def write_to_binary_file(filename, data):
    with open(filename, 'wb') as f:
        for value in data:
            f.write(struct.pack('I', value))  # 'i' format for a 4-byte integer

 # Write each column to a separate binary file
write_to_binary_file('pokemon_type1.bin', df_extracted[' Type1'])
write_to_binary_file('pokemon_type2.bin', df_extracted[' Type2'])