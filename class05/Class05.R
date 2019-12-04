#' ---
#' title: "class05: Data exploration and visualization in R"
#' author: "Kelsey Dang"  
#' date: "Oct 17 2019"  
#' output: github_document
#' ---

# Goals:  
# Appreciate the major elements of exploratory data analysis and why it is important to visualize data  
# Be conversant with data visualization best practices and understand how good visualizations optimize for the human visual system
# Be able to generate informative graphical displays including scatterplots, histrograms, bar graphs, boxplots, dendrograms, and heatmaps and thereby gain exposure to the extensive graphical capabilities of R
# Appreciate that you can build even more complex charts with ggplot and additional R packages such as rgl

# Section 1: Getting Organized

# 1A - Creating a Project

#Steps for creating an RStudio project: File > New Project > New Directory > New Project

# 1B - Getting Data to Plot
#Note: It's helpful to drag the files you want to work with into your R project, so you don't have to write out the entire path to the files.

# 1C - Create an R script
#Steps to open a new R scipt: File > New File > R Script

# Section 2: Customizing Plots
# 2A - Line plot
# Scatterplots represent the most common visualization when we want to show one quantitative variable relative to another


# Read into the data file "weight_chart.txt"

weight <- read.table("bimm143_05_rstats/weight_chart.txt", header = TRUE)

# Print the data
weight

# Now use the plot() function to plot the data as a point and line graph with various customizations.

#The Customizations:  
# type=o -- change scatterplot to a line plot  
# pch=15 -- set point char as a square  
# cex=1.5 -- change plot point size 1.5x normal size  
# lwd=2 -- change line width thickness 2x default  
# ylim=c(2,10) -- change y-axis limits to scale between 2 and 10  

plot(weight$Age, 
     weight$Weight, 
     type= "o",
     pch=15,
     cex=1.5,
     lwd=2,
     ylim=c(2,10),
     ylab="Weight (kg)",
     xlab="Age (months)",
     main = "Baby weight with age",
     col="purple")

# 2B - Barplot
# Most common approach to visualizing amounts (numerical values) is using bars
# utilize the barplot() function

# Make sure to put the correct separation, space is the default
mouse <- read.table("bimm143_05_rstats/feature_counts.txt", header=TRUE, sep="\t")

par(mar=c(5, 12, 2, 2))
barplot(mouse$Count,
        horiz = TRUE,
        ylab = "",
        xlim = c(0,80000),
        names.arg = mouse$Feature,
        main = "Number of features in the mouse GRCm38 genome",
        las = 1)

# 2C - Histograms
# Histograms and density plots provide the most intuitive visualizations of a given distribution  
# Utilize hist() function

x <- c(rnorm(10000),rnorm(10000)+4)

# Note*: the more breaks the more detailed the histogram is
# More curves in the graph
hist(x, breaks = 100)

# Section 3: Using Color in Plots
# 3A - Providing Color Vectors
# The **rainbow()** function takes a single argument, which is the number of colors to generate, then assign it to the col argument


count <- read.delim("bimm143_05_rstats/male_female_counts.txt", sep = "\t", header = TRUE)

# Color the barplot using the rainbow() function
barplot(count$Count,
        names.arg = count$Sample,
        col = rainbow(nrow(count)),
        las = 2,
        ylab = "Counts",
        main = "Comparing Female and Male Counts")

# Color the plot based on the genders
barplot(count$Count,
        names.arg = count$Sample,
        col = c("blue2", "red2"),
        las = 2,
        ylab = "Counts",
        main = "Comparing Female and Male Counts"
)

# 3B - Coloring by Value
# The file "up_down_expression.txt" contains an expression comparison dataset, but has an extra column that classifies the rows into one of 3 groups (up, down, unchanging)
# The goal is to produce a scatterplot with the up being red, the down being blue, and the unchanging being gray

#Read in the file
genes <- read.delim("bimm143_05_rstats/up_down_expression.txt")

# How many TOTAL genes are detailed in this file?
nrow(genes)

# How many genes are labeled as "up", "down", "unchanged" regulated?
table(genes$State)

plot(genes$Condition1,
     genes$Condition2,
     col=genes$State,
     xlab="Expression Condition 1",
     ylab="Expression Condition 2",
     main="Gene Expression Relationships")

# 3C - Dynamic use of Color
# The file "expression_methylation.txt" contains data for gene body methylation, promoter methylation, and gene expression

# Lets plot expression vs. gene regulation
meth <- read.delim("bimm143_05_rstats/expression_methylation.txt")

#How many genes are in this dataset?
nrow(meth)

# Draw a scatterplot() of the gene.meth column against the expression column
plot(meth$gene.meth,
     meth$expression,
     col="lightblue")

# Now, this busy plot is too crowded with a lot of data points on top of each other. We can improve this by coloring by **point density** 
# Use the function densCols() to make a new color vector along with solid plotting character (i.e. pch = 20)

dcols <- densCols(meth$gene.meth, meth$expression)

# Plot changing the plot character ('pch') to a solid circle
plot(meth$gene.meth,
     meth$expression,
     col = dcols,
     pch = 20)

# It's a little bit better, we can see where most of the data points are stacked, but lets add more restrictions to only allow genes with more than zero expression values.

# Find the indices of genes > 0 expression
idx <- meth$expression > 0

# Plot just the genes > 0 expression
## Note this is without the color density
plot(meth$gene.meth[idx], meth$expression[idx])

# Make a density color vector for these new genes
dcols <- densCols(meth$gene.meth[idx], meth$expression[idx])

# Plot with the pretty density coloring!
plot(meth$gene.meth[idx],
     meth$expression[idx],
     col = dcols,
     pch = 20,
     xlab = "Gene Body Methylation",
     ylab = "Gene Expression")

# Note: Can change the colramp used by the **densCols()** function to go between different colors with the colorRampPalette() function.
# By using different colors we can not only see where there is more data point overlap, but which sections are more condensed than others, based on the color distribution.  

dcols.custom <- densCols(meth$gene.meth[idx], meth$expression[idx],colramp = colorRampPalette(c("blue2","green2","red2","yellow")))

plot(meth$gene.meth[idx],
     meth$expression[idx], 
     col = dcols.custom,
     pch = 20,
     xlab = "Gene Body Methylation",
     ylab = "Gene Expression")


















