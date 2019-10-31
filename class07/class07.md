Class 7 R functions and packages
================
Kelsey Dang
10/22/2019

## R functions revisited

Source my functions from last day

``` r
source("http://tinyurl.com/rescale-R")
```

``` r
rescale(1:10)
```

    ##  [1] 0.0000000 0.1111111 0.2222222 0.3333333 0.4444444 0.5555556 0.6666667
    ##  [8] 0.7777778 0.8888889 1.0000000

``` r
rescale(c(1, 10, 5, NA, 6))
```

    ## [1] 0.0000000 1.0000000 0.4444444        NA 0.5555556

Notes:  
\* The function warning() - keeps on running, but throws a warning  
\* The function stop() - stops running your function completely  
\* Adding a ‘\!’ in front of the function call outputs the opposite  
\* There are different error output messages for rescale v. rescale2,
rescale2 error message is more understandable

## A new function called **both.na()**

First make some simple input where I know the answer

``` r
x <- c(1, 2, NA, 3, NA)
y <- c(NA, 3, NA, 3, 4)
```

Looked online and found the **is.na()** function

``` r
is.na(x)
```

    ## [1] FALSE FALSE  TRUE FALSE  TRUE

and the \*\*which()\* function tells me where the TRUE values are

``` r
which( is.na(x) )
```

    ## [1] 3 5

Individual output for x and y

``` r
is.na(x)
```

    ## [1] FALSE FALSE  TRUE FALSE  TRUE

``` r
is.na(y)
```

    ## [1]  TRUE FALSE  TRUE FALSE FALSE

The **AND** function, so I can figure out how many TRUE there are
combined

``` r
is.na(x) & is.na(y)
```

    ## [1] FALSE FALSE  TRUE FALSE FALSE

Taking the **sum()** of TRUE FALSE vector will tell me how many TRUE
elements I have

``` r
sum(is.na(x) & is.na(y))
```

    ## [1] 1

``` r
sum(c(TRUE, TRUE, FALSE, TRUE))
```

    ## [1] 3

Now, create a function that does the same thing, but put together called
**both.na()**

``` r
both_na <- function(x, y)
{
  sum(is.na(x) & is.na(y))
}
```

Testing our newly created function

``` r
x <- c(NA, NA, NA)
y1 <- c( 1, NA, NA)
y2 <- c( 1, NA, NA, NA)
```

``` r
both_na(x, y2)
```

    ## Warning in is.na(x) & is.na(y): longer object length is not a multiple of
    ## shorter object length

    ## [1] 3

Note: reason why the error outputs 3, even though it is out of bounds is
because of **RECYCLING**

``` r
# Since x is shorter, it will keep recycling the x-values of the vector until it reaches all of the length of vector y
x <- c(1, NA, NA)

# This is the recycling process for x : c(1, NA, NA, 1, NA, NA)
# So this outputs 4
y3 <- c( 1, NA, NA, NA, NA, NA)
both_na(x, y3)
```

    ## [1] 4

Now, use stop() function to prevent the recycling

``` r
length(x)
```

    ## [1] 3

``` r
length(y3)
```

    ## [1] 6

Creating the new function utilizing stop()

``` r
both_na2 <- function(x, y)
{
  if (length(x) != length(y))
  {
    stop("Make the vectors the same length!")
  }
  sum(is.na(x) & is.na(y))
}
```

Testing our new both\_na2() function with using the stop() function

``` r
#both_na2(x, y3)
```

### Practice writing function : grade()

Write a function that determines an overall grade from a vector of
student HW assignment scores dropping the lowest single alignment score

``` r
# Student 1
s1 <- c(100, 100, 100, 100, 100, 100, 100, 90)

# Student 2
s2 <- c(100, NA, 90, 90, 90, 90, 97, 80)
```

Steps: Calculate the grade as is

``` r
perfect <- c(100, 100, 100, 100, 100, 100, 100, 100)
score <- sum(s1) / sum(perfect)
print(score)
```

    ## [1] 0.9875

Now, take out the lowest score

``` r
lowest <- (s1[which.min(s1)])
print(lowest)
```

    ## [1] 90

Assignment sum now dropping lowest score

``` r
sum(s1[-which.min(s1)])
```

    ## [1] 700

Find average

``` r
mean(s1[-which.min(s1)])
```

    ## [1] 100

Now, run this on s2. How do we deal with NA homework?

``` r
which.min(s2)
```

    ## [1] 8

``` r
s2[-which.min(s2)]
```

    ## [1] 100  NA  90  90  90  90  97

``` r
mean(s2[-which.min(s2)], na.rm = TRUE)
```

    ## [1] 92.83333

Using **any()** function

``` r
any(is.na(s2))
```

    ## [1] TRUE

We have our working code now turn it into a first function

``` r
grade <- function(x)
{
  if( any(is.na(x)) )
  {
    warning("Student is missing an assignment")
  }
  mean(x[-which.min(x)], na.rm = TRUE)
}
```

Grade s1 and s2 with the new function

``` r
grade(s1)
```

    ## [1] 100

``` r
grade(s2)
```

    ## Warning in grade(s2): Student is missing an assignment

    ## [1] 92.83333

Now, grade the whole class

``` r
url <- "https://tinyurl.com/gradeinput"
hw <- read.csv(url, row.names = 1)
```

Using the **apply()** function  
1 represents row, 2 represents column

``` r
apply(hw, 1, grade)
```

    ## Warning in FUN(newX[, i], ...): Student is missing an assignment
    
    ## Warning in FUN(newX[, i], ...): Student is missing an assignment
    
    ## Warning in FUN(newX[, i], ...): Student is missing an assignment
    
    ## Warning in FUN(newX[, i], ...): Student is missing an assignment

    ##  student-1  student-2  student-3  student-4  student-5  student-6 
    ##   91.75000   82.50000   84.25000   88.00000   88.25000   89.00000 
    ##  student-7  student-8  student-9 student-10 student-11 student-12 
    ##   94.00000   93.75000   87.75000   81.33333   86.00000   91.75000 
    ## student-13 student-14 student-15 student-16 student-17 student-18 
    ##   92.25000   87.75000   83.33333   89.50000   88.00000   97.00000 
    ## student-19 student-20 
    ##   82.75000   82.75000

## Installing a bioconduction package

The commands on the slides did not work for the 3.6.1 version of
Rstudio, the following below are the commands from bioconductor.  
if (\!requireNamespace(“BiocManager”, quietly = TRUE))
install.packages(“BiocManager”)

BiocManager::install(“msa”)
