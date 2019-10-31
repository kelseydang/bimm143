Class6 R Functions
================
Kelsey Dang
10/17/2019

# This is Heading 1

This is my mark from class06 in **BIMM143**.

``` r
# This is to a demo a code chunk
plot(1:10)
```

![](class06_files/figure-gfm/unnamed-chunk-1-1.png)<!-- -->

## Practice reading files

Here I practice reading 3 different files…

``` r
read.csv("test1.txt")
```

    ##   Col1 Col2 Col3
    ## 1    1    2    3
    ## 2    4    5    6
    ## 3    7    8    9
    ## 4    a    b    c

``` r
read.table("test2.txt", sep="$", header = TRUE)
```

    ##   Col1 Col2 Col3
    ## 1    1    2    3
    ## 2    4    5    6
    ## 3    7    8    9
    ## 4    a    b    c

``` r
read.table("test3.txt", header = TRUE)
```

    ##   X1 X6 a
    ## 1  2  7 b
    ## 2  3  8 c
    ## 3  4  9 d
    ## 4  5 10 e

``` r
# Separated by space and a tab
```

### Creating Functions

``` r
# y is an optional input option
add <- function(x, y=1)
  {
    # Sum the input x and y
    x + y
  }
```

``` r
add(1)
```

    ## [1] 2

``` r
add(5,5)
```

    ## [1] 10

``` r
# These are vectorized, this still works, within num of arguments
add(c(1, 2, 3))
```

    ## [1] 2 3 4

``` r
add(c(1, 2,3), 4)
```

    ## [1] 5 6 7

A new function to re-scale data

``` r
# This function is using the range() function
rescale <- function(x)
{
  rng <- range(x)
  (x - rng[1]) / (rng[2] - rng[1])
}

rescale(1:10)
```

    ##  [1] 0.0000000 0.1111111 0.2222222 0.3333333 0.4444444 0.5555556 0.6666667
    ##  [8] 0.7777778 0.8888889 1.0000000

Test some

``` r
# How would you get your function to work here...
rescale( c(1,2,NA,3,10) )
```

    ## [1] NA NA NA NA NA

``` r
x <- c(1,2,NA,3,10)
# rng <- range(x) ; this gave u errors before, so remove NA
rng <- range(x, na.rm = TRUE)
rng
```

    ## [1]  1 10

``` r
# Redoing the rescale function with removing the NA
rescale2 <- function(x)
{
  rng <- range(x, na.rm = TRUE)
  (x - rng[1]) / (rng[2] - rng[1])
}

rescale2( c(1,2,NA,3,10) )
```

    ## [1] 0.0000000 0.1111111        NA 0.2222222 1.0000000

``` r
rescale3 <- function(x, na.rm=TRUE, plot=FALSE)
{
 rng <-range(x, na.rm=na.rm)
 print("Hello")
 answer <- (x - rng[1]) / (rng[2] - rng[1])
 
 print("is it me you are looking for?")
 if(plot) {
 plot(answer, typ="b", lwd=4)
 }
 print("I can see it in ...")
 return(answer)
}
```

``` r
rescale3(1:10, plot = TRUE)
```

    ## [1] "Hello"
    ## [1] "is it me you are looking for?"

![](class06_files/figure-gfm/unnamed-chunk-12-1.png)<!-- -->

    ## [1] "I can see it in ..."

    ##  [1] 0.0000000 0.1111111 0.2222222 0.3333333 0.4444444 0.5555556 0.6666667
    ##  [8] 0.7777778 0.8888889 1.0000000

``` r
rescale4 <- function(x, na.rm=TRUE, plot=FALSE)
{
 rng <-range(x, na.rm=na.rm)
 print("Hello")
 answer <- (x - rng[1]) / (rng[2] - rng[1])
 return(answer)
 print("is it me you are looking for?")
 if(plot) {
 plot(answer, typ="b", lwd=4)
 }
 print("I can see it in ...")
 return(answer)
}

rescale4(1:10, plot=TRUE)
```

    ## [1] "Hello"

    ##  [1] 0.0000000 0.1111111 0.2222222 0.3333333 0.4444444 0.5555556 0.6666667
    ##  [8] 0.7777778 0.8888889 1.0000000
