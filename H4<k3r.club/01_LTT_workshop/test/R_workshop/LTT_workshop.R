# 1.
# Load packages at the top using library():
library(ape)
library(phangorn)
library(phytools)

# 2. 
# Set the working directory to the path you copied in step 8 by
# pasting the path, putting single quotes around it and giving it to
# the setwd() function, then executing it. For example,
# setwd('/your/path/here'). You can type in the function call in 
# this document and then, with the cursor on the line, press, at
# the same time, command Enter, OR you can type the function in the
# Console window below and hit Enter.
setwd('/Users/mathewsimenc/dropbox_csuf/MyClasses/2018S/LTT_workshop/test/R_workshop')
# 3.
# Now use the function list.files() to see a list of the files in
# the directory you just set as the working directory.
list.files()
# 4.
# Leave Rstudio and go to the Finder. Go back to the Terminal window for the session
# on this Mac (not Kepler). Type open . and hit Enter

# 5.
# Look at the png files in the directory and decide which one you are going to use
# to make an LTT plot. Then come back to Rstudio.

# 6.
# Back in Rstudio, from the list.files() output, copy the name of the file ending in
# newick that corresponds to the tree you chose in the last step. Paste the
# name of the file into the read.tree() function, putting quotes around it if
# it doesn't already have them. This time use the <- operator to save the output
# as Tree, like: Tree <- read.tree('yourtree.newick')
Tree <- read.tree('Pogonomyrmex.Gypsy_2.bootstrapped.pathd8_ultrametric.outgroup_692.newick')
# 7.
# Use the ape function plot.phylo() to plot the tree by giving the name of the
# object Tree you just made as an argument, like: plot.phylo(Tree)
plot.phylo(Tree)
# 8.
# Try this later! run plot.phylo(Tree, type='phylogram') after you change
# the type argument from 'phylogram' to:
#                                           a. 'cladogram' 
#                                           b. 'fan' 
#                                           c. 'unrooted'
#                                           d. 'radial' 
plot.phylo(Tree, type='radial')
# 9.
# Assign outgroup to the number of the outgroup of your tree, which is part of the
# Newick tree file name: outgroup <- '123456'
outgroup <- '692'
# 10.
# Use the ape function root() to root the tree so the tree is in the proper relation to
# the outgroup: rooted <- root(t, outgroup)
rooted <- root(Tree, outgroup)
# 11.
# Use the ape function drop.tip() to remove the outgroup from
# the tree: nooutgroup <- drop.tip(rooted, outgroup)
nooutgroup <- drop.tip(rooted, outgroup)
# 12.
# Use the phangorn function nnls.tree to make sure the tree is ultrametric (I don't
# understand the details of this part) nnls<-nnls.tree(cophenetic(nooutgroup), nooutgroup, rooted=TRUE)
nnls <- nnls.tree(cophenetic(nooutgroup), nooutgroup, rooted=TRUE)
# 13.
# Use the phytools function ltt() to make a 
# lineages through time plot ltt(nnls, log.lineages = TRUE, type='p')
# Also try ltt() with log.lineages set to FALSE
ltt(nnls, type='p', log.lineages=FALSE)
ltt(nnls, type='p', log.lineages=TRUE)
# 14.
# That's it for now. Try making the different kinds of trees of the same phylogeny in step 8!