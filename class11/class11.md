Class 11: Structural Bioinformatics I
================
Kelsey Dang

## The PDB database for biomolecular structure data

> Q1: Download a CSV file from the PDB site (accessible from “Analyze”
> -\> “PDB Statistics” “by Experimental Method and Molecular Type”.

> Determine what proportion of structures are protein?

Download CSV files from PDB website (“Analyze” -\> “PDB Statistics” \>
“by Experimental Method and Molecular Type”)

``` r
# Read CSV
data <- read.csv("Data Export Summary.csv")
data
```

    ##   Experimental.Method Proteins Nucleic.Acids Protein.NA.Complex Other
    ## 1               X-Ray   131278          2059               6759     8
    ## 2                 NMR    11235          1303                261     8
    ## 3 Electron Microscopy     2899            32                999     0
    ## 4               Other      280             4                  6    13
    ## 5        Multi Method      144             5                  2     1
    ##    Total
    ## 1 140104
    ## 2  12807
    ## 3   3930
    ## 4    303
    ## 5    152

``` r
sum(data$Total)
```

    ## [1] 157296

> Q2: Type HIV in the PDB website search box on the home page and
> determine how many HIV-1 protease structures are in the current PDB?
