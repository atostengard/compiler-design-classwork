# compiler-design-classwork
A compiler written in Yak/Lex/C++ which reads in a comma-delimited file of integers and generates a barplot or lineplot in R. Run at command line where arguments are specified below by "usage". Included is an example data.csv file which can be used to run the program. To run, install Bison, Lex, R and g++ compiler. If run on Linux, the plot should open automatically but other platforms may need to open the program folder to find resulting plots. To compile and run, first command is "make" and second command is "./interpreter.out".

usage: <plot type: lineplot, barplot> <csv data file> <plot name> <x-axis name> <y-axis name> <color>

example input:
lineplot data.csv Title Time Output blue
barplot data.csv Title xAxis yAxis red
