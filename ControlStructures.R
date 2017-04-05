# cONTROL STRUCTURESFOR r PROGRAMMING
# Logical operators <- run code that gives us TRUE FALE answers

5>3
5<3
5>=3
5>=5
5<=3
5==5 #(means equal)
5 != 5 #(!= means not equal) 

# compound & for AND
5>3 & 1!=2

# use | for OR
1==2 | 1!=2

# logicals work with vectors
1:5 > 3

a<-1:10
b<-10:1
a>4 & b>4

# use "long form" of & and | to find the first comparison that can be evaluated
# as a TRUE FALSE, and just use that
a>4 && b>4

# also use "long form" for the OR | comparison
a>4 || b>4

# can use isTRUE to test whether any statement is a vector of length 1 that has 
# a value of TRUE

z <- 0
isTRUE(z)

z <- 1
isTRUE(z)

# xor for exclusive or testing of vectors
a <- c(0,0,1)
b <- c(0,1,1)
a | b
xor(a,b) # exclusive OR statment, where both must match

# Set Operations
# boolean algebra on sets of atomic vectors
# (logical, numeric, character strings

a<-1:7
b<-5:10

# union for all statements, shows only uniques, not duplicates
union(a,b)

# intersect to get common elements
intersect(a,b)

# set dif to get distnct elements - output depends on order of variables
setdiff(a,b)
setdiff(b,a)

# set equal to check for identical elements - logical with t/f
setequal(a,b)

# more generally to compare two objects
z <- matrix(1:12,nrow=4,byrow=TRUE)
z1 <- matrix(1:12,nrow=4,byrow=FALSE)

z==z1 # provides element by element comparison
identical(z,z1) # compares totoal matrices

# useful for if statements is %in% or is.element
d<-12
d %in% union(z,z1)
is.element(d,union(z,z1))

#################
# If statements!
# written as:
# if (condition) expression
#or
# if (condition) expression1 else expression2

# can string them along:
# if (condition) expression else if (condition) expression2 else expression3

z<-signif(runif(1),digits=2)
print(z)
z > 0.5
if(z > 0.5) cat(z, "is a bigger than average number","\n")

if(z>0.8) cat(z, "is a large number","\n") else
  if(z<0.2) cat(z, "is a small number","\n") else
  {
    cat(z,"is an ordinary sized number","\n")
    cat("z^2 = ", z^2, "\n")
  }

# avoid multiple true false vectors

z <- 1:10

# this wont do anything
if(z>7) print(z)

# but probably not what you want
if (z < 7) print(z)

#use subsetting here
print(z[z<7])

# ifelse function, looks like this:
# iselse(test,yes,n0)
# test is an object that cna be coerced to y/n
# Yes returns values for true elements
# no returns elsements for false elements

# lets imagine we have an insect population where each females lays 10.2 eggs 
# draw a Poisson
# but in addition, 35% of females are parasitized and sterile

tester <- runif(1000)
eggs <- ifelse(tester>0.35, rpois(n=1000,lambda = 10.2),0)
head(eggs)
hist(eggs)
