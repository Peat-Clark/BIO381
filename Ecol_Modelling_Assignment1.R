## Pete Clark
## PBIO 294
## Assignment one - 9/3/2017

#1.	Create	a	vector	that	is	a	sequence	of	from	1	to	100	and	that	
#is	of	length	200.

myVector = seq(from = 1, to = 100, length.out = 200)
myVector

#2.	Multiply	each	element	in	this	list	by	2	and	find	the	sum	of
#the	resulting	vector

vec2 = sum(myVector*2)
vec2

#3.	Create	a	sequence	of	integers	from	1	to	100.		

mySequence = 1:100
mySequence

#4.	Square	each	element	of	this	vector	and	find	the	summation	of	this	transformed	vector.

seqSquared = sum(mySequence^2)
seqSquared

#5.	Select	all	elements	of	the	transformed	vector	(from	4	above)	that	are	less	than	50.

seqSquared = (mySequence^2)
fiftys = seqSquared[seqSquared<50]
fiftys

#6.	 Create	a	3	(rows)	by	4	(cols)	matrix	of	values	1:12

myMatrix = matrix(seq(1:12), nrow=3, ncol=4) 
myMatrix

#7.		Multiple	the	component	at	the	location	[2,3]	and	the	component	at	[3,2].

matMult = myMatrix[2,3]*myMatrix[3,2]
matMult

# 8.	Name	the	rows	(a,b,c)	and	the	columns	(1,2,3,4)

rownames(myMatrix) <- c("a", "b", "c")
colnames(myMatrix) <- c("1", "2", "3", "4")
myMatrix

#9.	Create	a	3 dimensional	array	that	replicates the	matrix	created	in 4	above	three	
# times	in	the	3rd dimensions.	 Continue	the	sequence	of	numbers	to	48.	Name	the	
# dimensions	of	the	array.

myArray <- array(c(myMatrix, 13:48), dim=c(3,4,4))
myArray
dimnames(myArray) <- list(NULL, NULL,c("Dim_1", "Dim_2", "Dim_3", "Dim_4"))
myArray
rownames(myArray) <- c("a", "b", "c")
colnames(myArray) <- c("1", "2", "3", "4")
myArray

# 10.		Multiply	the	2nd row	of	the	2	dimension	by	the	[3,3]	element	of	the	4th dimension
myArray["b",,"Dim_2"]*myArray["c","3","Dim_4"]

#11.	Create	a	vector	of	(1,2)	replicated	to	length	10.		Transform	the	vector	to	a	factor.	
# Change	the	names	of	the	level	1	to	'low'	and	level	2	to	'high'

myVector2 = c(1,2)
myVec2Full = rep(myVector2, length.out=20)
myVec2Factor <- as.character(myVec2Full)
library(plyr)
myVec2FINAL = revalue(myVec2Factor, c("1"="low", "2"="high"))
myVec2FINAL

# 12. Create a vector of integers 1 to 10. Create a data frame that combines this vector
#with the factor variable created in 11 above.

vec12 = 1:10
vec12
vec12DF = data.frame(vec12, myVec2FINAL) 
vec12DF

# 13. Name the columns of 12: 'id', 'treatment'.

vec12DFNamed = data.frame("id"=vec12, "treatment"=myVec2FINAL) 
vec12DFNamed

# 14. Extract positions 1,2,3 and 7 of the treatment column.
vec12DFNamed$treatment[1]
vec12DFNamed$treatment[2]
vec12DFNamed$treatment[3]
vec12DFNamed$treatment[7]

