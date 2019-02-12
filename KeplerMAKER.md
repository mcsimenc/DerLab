[DerDocs Home](https://github.com/mcsimenc/DerLab/blob/master/DerDocsHome.md)
# Guide to MAKER Genome Annotation Pipeline on Kepler

### Overview
MAKER was designed for annotating whole-genome assemblies but it may also be useful for annotating shorter sequences. MAKER streamlines the annotation process, handling the execution of numerous annotation processes, like running sequence aligners, gene predictors, and creating standard files for genomic features such GFF3.

### Loading MAKER
MAKER is installed both locally (`/home/joshd/software/`) and globally (`/share/apps/genomics/`). The global installation is probably less reliable than the local one. If you don't already have one, you may need to create or copy a local module file for maker. Information about how to set up your module environment is in [KeplerModules.md](https://github.com/mcsimenc/DerLab/blob/master/KeplerModules.md)

To load MAKER, type

`module load local/maker`

A message should print with the MAKER version number and a short description. This information is hardcoded in the maker module file at 

### Setting up your MAKER space
It's best to create a new directory in which to run MAKER from. When ready to start the run, this directory will contain three control files, your PBS/torque/qsub/shell script to submit to the resource manager TORQUE using `qsub`, explained below. While running, MAKER will generate a very large number of files. Warning: moving a MAKER output directory around in your filesystem takes a very long time.

In this document, $RUNDIR is the location of the hypothetical directory from which MAKER will be executed.

#### Control Files
To generate template control files, from within $RUNDIR and after loading the MAKER module, type `maker -CTL`. This will generate three files:


[maker_opts.ctl](https://github.com/mcsimenc/DerLab/blob/master/maker_opts.md) contains general settings, \
[maker_bopts.ctl](https://github.com/mcsimenc/DerLab/blob/master/maker_bopts.md) contains BLAST settings, \
[maker_exe.ctl](https://github.com/mcsimenc/DerLab/blob/master/maker_exe.md) contains paths to dependency executables. \

The syntax for the control files is key=value with # preceeded comments. The control files contain descriptive comments. Here is my explanation of the most important options to know about. Default BLAST settings were chosen because MAKER performed well under them for eukaryotic genomes.

DNA and protein sequences can be provided to MAKER in FASTA or GFF3 format. Below, the FASTA options are shown.

##### Notable options in maker_opts.ctl

```
genome= #genome sequence (fasta file or fasta embeded in GFF3 file)
organism_type=eukaryotic #eukaryotic or prokaryotic. Default is eukaryotic
est= #set of ESTs or assembled mRNA-seq in fasta format
protein=  #protein sequence file in fasta format (i.e. from mutiple oransisms)
rmlib= #provide an organism specific repeat library in fasta format for RepeatMasker
repeat_protein=/home/joshd/software/maker/data/te_proteins.fasta #provide a fasta file of transposable element proteins for RepeatRunner
snaphmm= #SNAP HMM file
gmhmm= #GeneMark HMM file
augustus_species= #Augustus gene prediction species model
fgenesh_par_file= #FGENESH parameter file
est2genome=0 #infer gene predictions directly from ESTs, 1 = yes, 0 = no
protein2genome=0 #infer predictions from protein homology, 1 = yes, 0 = no
trna=0 #find tRNAs with tRNAscan, 1 = yes, 0 = no
snoscan_rrna= #rRNA file to have Snoscan find snoRNAs
# This could be used to annotate protein-coding transposable elements.
unmask=0 #also run ab-initio prediction programs on unmasked sequence, 1 = yes, 0 = no
cpus=1 #max number of cpus to use in BLAST and RepeatMasker (not for MPI, leave 1 when using MPI)
pred_stats=0 #report AED and QI statistics for all predictions as well as models
min_protein=0 #require at least this many amino acids in predicted proteins
alt_splice=0 #Take extra steps to try and find alternative splicing, 1 = yes, 0 = no
always_complete=0 #extra steps to force start and stop codons, 1 = yes, 0 = no
split_hit=10000 #length for the splitting of hits (expected max intron size for evidence alignments)
single_exon=0 #consider single exon EST evidence when generating annotations, 1 = yes, 0 = no
single_length=250 #min length required for single exon ESTs if 'single_exon is enabled'
# For re-annotating a genome, set to 1
map_forward=0 #map names and attributes forward from old GFF3 genes, 1 = yes, 0 = no
# To save disk space
clean_up=0 #removes theVoid directory with individual analysis files, 1 = yes, 0 = no
```

##### Paths in maker_exe.ctl

```
#-----Location of Executables Used by MAKER/EVALUATOR
makeblastdb= #location of NCBI+ makeblastdb executable
blastn= #location of NCBI+ blastn executable
blastx= #location of NCBI+ blastx executable
tblastx= #location of NCBI+ tblastx executable
RepeatMasker=/home/joshd/software/maker/bin/../exe/RepeatMasker/RepeatMasker #location of RepeatMasker executable
exonerate=/home/joshd/software/maker/bin/../exe/exonerate/bin/exonerate #location of exonerate executable

#-----Ab-initio Gene Prediction Algorithms
snap=/home/joshd/software/maker/bin/../exe/snap/snap #location of snap executable
gmhmme3= #location of eukaryotic genemark executable
gmhmmp= #location of prokaryotic genemark executable
augustus= #location of augustus executable
fgenesh= #location of fgenesh executable
tRNAscan-SE= #location of trnascan executable
snoscan= #location of snoscan executable
```

#### Submission Script

```
#!/bin/bash
#PBS -k oe
#PBS -N JobName
#PBS -q q40
#PBS -j oe
#PBS -m ea
#PBS -M mcsimenc@csu.fullerton.edu
#PBS -l nodes=1:ppn=40

module load local/maker
module load local/trnascan
module load openmpi

cd /home/derstudent/data/santalales/annotation_all_taxa


echo "START"
date

mpirun -n 40 maker maker_bopts.ctl maker_exe.ctl maker_opts.ctl 1>maker.err 2>maker.log

echo "END"
date
```

[DerDocs Home](https://github.com/mcsimenc/DerLab/blob/master/DerDocsHome.md)
