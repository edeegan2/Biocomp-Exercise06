#first task of creating file with gender in the first column and years experience
# in the second column
#cutted all columns except the first two in wages.csv, replacing comma with space, 
#and sorting alphabetically then inserting into new csv
cat wages.csv | cut -d, -f 1,2 | sed -E 's/,/ /g' | sort -n > sortedwages.csv
#taking first 1569 lines of sortedwages.csv (females), sorting by second column and 
#putting it into new csv
cat sortedwages.csv | head -1569 | sort -n -k 2 > finalsortedwages.csv
#taking last 1726 lines of sortedwages.csv (males), sorting by second column and 
#adding onto the final csv
cat sortedwages.csv | tail -1726 | sort -n -k 2 >> finalsortedwages.csv

#second task of sorting by wage and taking the lowest earner, displaying only gender
#years experience and wage 
cat wages.csv | sort -t, -k 4 | head -1 | cut -d, -f 1,2,4 
#Print label of Lowest earner
echo Lowest Earner
#repeating for highest earner
cat wages.csv | sort -t, -k 4 | tail -1 | cut -d, -f 1,2,4
echo Highest Earner
#repeating but for top 10 highest female earners
cat wages.csv | grep -E "female" | sort -t, -k 4 | tail -10 | cut -d, -f 1,2,4
echo Top 10 female Earners

# third task of the effect of graduating college on minimum wage
#setting column of wages with 12 years experience in third column as non college min variable
noncollegemin=$(cat wages.csv | cut -d, -f 3,4 | grep -E "(12,)" | cut -d, -f 2)
#setting column of wages with 16 years experience in third column as college min variable
collegemin=$(cat wages.csv | cut -d, -f 3,4 | grep -E "(16,)" | cut -d, -f 2)
#subtracting two variables to see the difference and effect of graduating college
echo "$collegemin -$noncollegemin" | bc
