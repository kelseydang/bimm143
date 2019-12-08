Class 11: Structural Bioinformatics I
================
Kelsey Dang

### Notes:

  - The PDB archive is the major repository of information about the 3D
    structures of large biological molecules, including proteins and
    nucleic acids  
  - Understanding the shape of these molecules helps to understand how
    they work
      - This knowledge can be used to help deduce a structure’s role in
        human health and disease, and in drug development  
  - The structures in the PDB range from tiny proteins and bits of DNA
    or RNA to complex molecular machines like the ribosome composed of
    many chains of protein and RNA

## The PDB database for biomolecular structure data

> Q1: Download a CSV file from the PDB site (accessible from “Analyze”
> -\> “PDB Statistics” “by Experimental Method and Molecular Type”.

> Determine what proportion of structures are protein?

92.17%

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

Proportion of entries from each method

``` r
round(data$Total / sum(data$Total) * 100, 2)
```

    ## [1] 89.07  8.14  2.50  0.19  0.10

Proportion that are protein

``` r
round(sum(data$Proteins) / sum(data$Total) * 100, 2)
```

    ## [1] 92.71

> Q2: Type HIV in the PDB website search box on the home page and
> determine how many HIV-1 protease structures are in the current PDB?

# Section 3: Introduction to Bio3D in R

Here we will read the 1HSG PDB structure and select the protein
component and write out a new **protein-only** PDB format file. We then
do the same for the ligand (i.e. known drug molecule) creating a
**ligand-only** PDB file.

How many amino acid residues are there in this pdb object and what are
the two non-protein residues?

``` r
library(bio3d)
```

``` r
pdb <- read.pdb("1hsg")
```

    ##   Note: Accessing on-line PDB file

``` r
attributes(pdb)
```

    ## $names
    ## [1] "atom"   "xyz"    "seqres" "helix"  "sheet"  "calpha" "remark" "call"  
    ## 
    ## $class
    ## [1] "pdb" "sse"

``` r
library(bio3d)

pdb <- read.pdb("1hsg.pdb")
pdb
```

    ## 
    ##  Call:  read.pdb(file = "1hsg.pdb")
    ## 
    ##    Total Models#: 1
    ##      Total Atoms#: 1686,  XYZs#: 5058  Chains#: 2  (values: A B)
    ## 
    ##      Protein Atoms#: 1514  (residues/Calpha atoms#: 198)
    ##      Nucleic acid Atoms#: 0  (residues/phosphate atoms#: 0)
    ## 
    ##      Non-protein/nucleic Atoms#: 172  (residues: 128)
    ##      Non-protein/nucleic resid values: [ HOH (127), MK1 (1) ]
    ## 
    ##    Protein sequence:
    ##       PQITLWQRPLVTIKIGGQLKEALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYD
    ##       QILIEICGHKAIGTVLVGPTPVNIIGRNLLTQIGCTLNFPQITLWQRPLVTIKIGGQLKE
    ##       ALLDTGADDTVLEEMSLPGRWKPKMIGGIGGFIKVRQYDQILIEICGHKAIGTVLVGPTP
    ##       VNIIGRNLLTQIGCTLNF
    ## 
    ## + attr: atom, xyz, seqres, helix, sheet,
    ##         calpha, remark, call

``` r
#write.pdb("1hsg.pdb")
#trim.pdb()
```

Creating protein PDB

``` r
protein <- atom.select(pdb, "protein", value=TRUE)
write.pdb(protein, file = "1hsg_protein.pdb")
```

Creating ligand PDB

``` r
ligand <- atom.select(pdb, "ligand", value=TRUE)
write.pdb(ligand, file = "1hsg_ligand.pdb")
```

# Section 4: Atom Selection

  - The Bio3D atom.select() function is central to PDB structure
    manipulation and analysis  
  - This function operates on PDB structure objects and returns the
    numeric indices of a selected atom subset
      - This indices can then be used to access the attributes of PDB
        structure related objects  
  - Utilize the **trim.pdb()** function together with the
    **write.pdb()** function to output new PDB files consisting of a
    subset of selected atoms

<!-- end list -->

``` r
# Select all C-alpha atoms (return their indices)

ca.inds <- atom.select(pdb, "calpha")
ca.inds
```

    ## 
    ##  Call:  atom.select.pdb(pdb = pdb, string = "calpha")
    ## 
    ##    Atom Indices#: 198  ($atom)
    ##    XYZ  Indices#: 594  ($xyz)
    ## 
    ## + attr: atom, xyz, call

# Section 5: 3D Structure Viewing in R

  - Utilize Bio3D **write.pdb()** function to write out a protein only
    PDB file for viewing in VMD
  - Install the development version of the **bio3d.view** package to use
    the 3D biomolecular structure viewing in R
      - Its purpose is to enable quick ‘sanity check’ structure viewing
        without having to rely on opening written-out PDB files in
        programs such as VMD or PyMol

<!-- end list -->

``` r
# The 'devtools' package allows us to install development versions:
# install.packages("devtools")

# Install the bio3d.view package from bitbucket
#devtools::install_bitbucket("Grantlab/bio3d-view")
```

To use in R:

``` r
# Load the package
# library("bio3d.view")

# view the 3D structure
# view(pdb, "overview", col="sse")
```

Note: use the **view()** function to visualize the results of a Normal
Mode Analysis, a bioinformatics method that can predict the major
motions of biomolecules

``` r
# Load the package
#pdb <- read.pdb("1hel")

# Normal mode analysis calculation
#modes <- nma(pdb)

#m7 <- mktrj(modes,
#            mode=7,
#            file="mode_7.pdb")

#view(m7, col=vec2color( rmsf(m7) ))
```

# Section 6: Working with multiple PDB files

  - The Bio3D package was designed to specifically facilitate the
    analysis of multiple structures from both experiment and simulation

Installing the stand-alone muscle alignment program:  
Open terminal and run these two lines of code:  
1\. curl -o “muscle.exe”
“<https://www.drive5.com/muscle/downloads3.8.31/muscle3.8.31_i86win32.exe>”  
2\. muscle.exe -version

<span style="color:red">**Note:** Need to fix because these lines won’t
allow me to download. Given the following error message, “curl: (77)
schannel: next InitializeSecurityContext failed: SEC\_E\_UNTRUSTED\_ROOT
(0x80090325) - The certificate chain was issued by an authority that is
not trusted.”</span>
