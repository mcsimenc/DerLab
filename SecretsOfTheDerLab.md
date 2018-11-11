# Secrets of the Der Lab
## Volume 1: Guide to Kepler: shortcuts and hidden passageways
###1. Aliases and Environment variables

1a. make an environment variable for the path of the script

`export S=/home/mcsimenc/scripts/apple-project/quant-snp-matrix.py`

1b. making aliases that open scripts I'm currently working on

`~alias s='vim $S'`

2. Always make a help for scripts that display when it is called with 0 arguments

In Python this is how I do it. Super simple and saves me the frustration of having forgotten what a script I wrote is for.
```
args = sys.argv
if len(args) < 2 or '-h' in args:
print('''
 usage:
	quant-snp-matrix.py <Psalmon> <STsalmon> <STmap> <Tsalmon> <Tmap>
''', file=sys.stderr)
    sys.exit()
```

3. More Environment variables

When I was working on the script from #2, I did this to make trying it out easier

export Psalmon=/home/mcsimenc/home2data/apple-pear/reference/MalusDomesticaAnnotation.PhytozomeV12/quantitation/salmon_output
export STsalmon=/home/mcsimenc/home2data/apple-pear/hiseq.huck.psu.edu/StringTieAssemblies/masked/salmon_quant/salmon_output
export STmap=/home/mcsimenc/home2data/apple-pear/hiseq.huck.psu.edu/StringTieAssemblies/masked/stringtie2phytozome.map

Then when I wanted to call the script I would do

`$S $Psalmon $STsalmon $STmap`

and if there was a bug, editing was as simple as

`s`

Saves a lot of time.

4. Make environment variables of directories you currently work in and files you often use. For example, the paths to the reference genomes we're working on, which we need for many programs. MG1 for Malus domestica genome version 1

```
export A=/home/mcsimenc/home2data/apple-pear/hiseq.huck.psu.edu
export MG1=/home/mcsimenc/home2data/apple-pear/reference/reference_genome1/Mdomestica_196_v1.0.fa
export MG2=/home/mcsimenc/home2data/apple-pear/reference/reference_genome2/GDDH13_1-1_formatted.fasta
```

then you have shortcuts like this

```
cd $A
cp $A/matt/test/newfile.txt .
ln -s $MG1
```
