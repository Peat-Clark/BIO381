setwd("~/UVM/BIO 381 Computational Biology/BIO381")

#1.	Read	in	the	weight	data	that	is	posted	on	webpage	as	
#'Weight	data'.

weightData <- read.csv(file = "weightData.csv", header = TRUE)
head(weightData)

#2.		What	type	of	object is the	file	read	in	as?		If	it	is	not	
#a	data	frame,	coerce	it	to	one.

str(weightData) # is a data.frame


#3.		What	are	object/data	types	of	each	of	the	columns?

str(weightData)
#gender is a factor (with 2 levels)
# height is an integer
# weight is an integer

#4.	Plot	weight	(on	y	axis)	vs	height	(on	x	axis)	with	different	
#colored	symbols	for	each	gender.
plot(weightData$weight_lbs, weightData$height_in, col=weightData$gender)

#5.		Write	a	function	to	calculate	'10!', i.e.,	10	factorial 
# (10*9*8*...*1).		Show	the	result	for	10	and	20.

# 10 factorial
x=20
y=1
for(i in 1:x){
  y <-y*((1:x)[i])
}
print(y)

# 20 factorail
x=20
y=1
for(i in 1:x){
  y <-y*((1:x)[i])
}
print(y)
