# LBYARCH Pokemon Battle Simulator
Included in the downloads are:
- ChuaRamos_mp2 : This is the main asm file to be ran and where it will output the results
- macro.asm : This file contains macros such as PRINT_DEC and also includes macros needed to perform the computation between the pokemons so that the code does not need to be repeated multiple times in the main asm file
- FirstGenPokemon.csv : This is the pokemon dataset obtained from kaggle the link can be found here: https://www.kaggle.com/datasets/dizzypanda/gen-1-pokemon?resource=download
- Preprocess.ipynb : A pyhton Jupyter Notebook file, this is the file responsible for preprocessing the dataset from kaggle into only the relevant columns (type1 and type2), converting the types into integers for easier referencing and outputting it into a binary file for the assembly file to read
- pokemon_type1.bin : This binary file contains the type1's of each pokemon
- pokemon_type2.bin : This binary file contains the type2's of each pokemon

## Notes
The types of the pokemons where converted from its string types (water, grass etc) into integers for easier referencing the way in it was converted was by using the table provided in canvas and numbering each type from 0-17 starting from Normal to Fairy type, a value of 99 was given to types which had NaN value
In case a new binary file of the types are needed open the jupyter notebook file and run the code (run all)

## How to Run
Open the ChuaRamos_mp2.asm in rars and build and run the program. The program will ask for 2 integers ranging from (1-151) with each integer corresponding to the index/row of the pokemon in the dataset (ex. 3 corresponds to Venusaur). After 2 integers have been inputted the resulting integer is the
pokemon that won the battle based on its type.

## Members
Chua, Matthew Adrian Uy__
Ramos, Ashley Kylle

