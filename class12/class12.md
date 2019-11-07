Class12: Structural Bioinformatics II
================
Kelsey Dang
11/7/2019

# Prep for docking

We want to produce a protein-only PDB file and a drug only PDB file.

## 1.1 Obtaining and inspecting our input structure

``` r
library(bio3d)

# Download the PDB file
get.pdb("1hsg")
```

    ## Warning in get.pdb("1hsg"): ./1hsg.pdb exists. Skipping download

    ## [1] "./1hsg.pdb"

Create PDB file only for protein

``` r
pdb <- read.pdb("1hsg.pdb")
protein <- atom.select(pdb, "protein", value=TRUE)
write.pdb(protein, file = "1hsg_protein.pdb")
```

and for ligand

``` r
ligand <- atom.select(pdb, "ligand", value=TRUE)
write.pdb(ligand, file="1hsg_ligand.pdb")
```
