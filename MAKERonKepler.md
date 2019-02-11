# Guide to MAKER Genome Annotation Pipeline on Kepler

### Overview
MAKER was designed for annotating whole-genome assemblies but it may also be useful for annotating shorter sequences. MAKER streamlines the annotation process, handling the execution of numerous annotation processes, like running sequence aligners, gene predictors, and creating standard files for genomic features such GFF3.

### Setting up your MAKER space
It's best to create a new directory in which to run MAKER from. When ready to start the run, this directory will contain three control files, your PBS/torque/qsub/shell script to submit to the resource manager TORQUE using `qsub`, explained below. While running, MAKER will generate a very large number of files. Warning: moving these directories around in your filesystem takes a very long time.

##### Control Files
##### Submission Script

### Loading MAKER
MAKER is installed both locally (`/home/joshd/software/`) and globally (`/share/apps/genomics/`). The global installation is probably less reliable than the local one. If you don't already have one, you may need to create or copy a local module file for maker. Information about how to set up your module environment is in KeplerModules.md.

To load MAKER, type

`module load local/maker`

A message should print with the MAKER version number and a short description. This information is hardcoded in the maker module file at 

