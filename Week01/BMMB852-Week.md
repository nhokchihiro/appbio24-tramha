Lecture 1:
a. Set up your computer => DONE
b. Follow the installation instructions => DONE
c. How can you tell that you were successful? => It appeared as below when I tested.
hpbichtram@Trams-MacBook-Pro ~
$ conda activate bioinfo

(bioinfo) 
hpbichtram@Trams-MacBook-Pro ~
$ 
(bioinfo) 
hpbichtram@Trams-MacBook-Pro ~
$ doctor.py

# Doctor! Doctor! Give me the news.
# Checking symptoms ...
# bwa           ... OK
# datamash      ... OK
# fastqc -h     ... OK
# hisat2        ... OK
# featureCounts ... OK
# efetch        ... OK
# esearch       ... OK
# samtools      ... OK
# fastq-dump    ... OK
# bowtie2       ... OK
# bcftools      ... OK
# seqtk         ... OK
# seqkit        ... OK
# bio           ... OK
# fastq-dump -X 1 -Z SRR1553591 ... OK
# You are doing well, Majesty!
(bioinfo) 

d. Can you run the samtools program? => YES (I run head command for example)
hpbichtram@Trams-MacBook-Pro ~/Desktop
$ samtools head file1.bam
@HD	VN:1.3	SO:coordinate
@SQ	SN:chr1	LN:248956422
@SQ	SN:chr2	LN:242193529
@SQ	SN:chr3	LN:198295559
@SQ	SN:chr4	LN:190214555
@SQ	SN:chr5	LN:181538259
@SQ	SN:chr6	LN:170805979
@SQ	SN:chr7	LN:159345973
@SQ	SN:chr8	LN:145138636
@SQ	SN:chr9	LN:138394717
@SQ	SN:chr10	LN:133797422
@SQ	SN:chr11	LN:135086622
@SQ	SN:chr12	LN:133275309
@SQ	SN:chr13	LN:114364328
@SQ	SN:chr14	LN:107043718
@SQ	SN:chr15	LN:101991189
@SQ	SN:chr16	LN:90338345
@SQ	SN:chr17	LN:83257441
@SQ	SN:chr18	LN:80373285
@SQ	SN:chr19	LN:58617616
@SQ	SN:chr20	LN:64444167
@SQ	SN:chr21	LN:46709983
@SQ	SN:chr22	LN:50818468
@SQ	SN:chrX	LN:156040895
@SQ	SN:chrY	LN:57227415
@SQ	SN:chrM	LN:16569
@PG	ID:bwa	PN:bwa	VN:0.7.17-r1188	CL:bwa mem -t 8 -v 1 /cvmfs/data.galaxyproject.org/byhand/hg38/hg38canon/bwa_index_v0.7.10-r789/hg38canon.fa /jetstream2/scratch/main/jobs/57375835/inputs/dataset_e57d86dd-61b9-4159-8184-1b1b0ef8adbf.dat /jetstream2/scratch/main/jobs/57375835/inputs/dataset_c6e0b8e0-b921-4742-b140-bb1890650c13.dat
(bioinfo) 

e. What version is your samtools program? => 1.20
hpbichtram@Trams-MacBook-Pro ~
$ samtools --version
samtools 1.20
Using htslib 1.20
Copyright (C) 2024 Genome Research Ltd.

f. GitHub repository: https://github.com/nhokchihiro/appbio24-tramha

Lecture 2:
a. Describe a Unix command not discussed in the class or the book. Try to find something that might be useful. When would you use that command?
Command line: ssh
Function: Use to log in and connect to a remote computer/machine and execute remote commands.
Example: I use this command line to access Roar Cluster of PSU as below:
ssh tmh6573@submit.hpc.psu.edu

b. Describe a customization for the command you chose above (describe the effect of a flag/parameter).
Command line: ssh -p 
Function: To connect to a server through other port number, not the default port 22.
Example: 
[tmh6573@submit01 ~]$ ssh -p 443 tmh6573@submit.hpc.psu.edu
ssh: connect to host submit.hpc.psu.edu port 443: Connection refused

c. What flags will make the ls command write out the files sizes in “human-friendly” mode?
Any flags go with -h.
    Example 1: Flag -lh: ls -lh 
        To list files in long format (-l) and print sizes in human-readable format as KB, GB, MB (-h).
    hpbichtram@Trams-MacBook-Pro ~
    $ ls -lh
    total 0
    drwx------@   5 hpbichtram  staff   160B Oct 11  2023 Applications
    drwx------+ 184 hpbichtram  staff   5.8K Sep  1 14:01 Desktop
    drwx------+   3 hpbichtram  staff    96B Jan 31  2024 Documents

    Example 2: Flag -hg: ls -hg 
        Same as ls -lh, but it just does not print the owners of these files/folders.
    hpbichtram@Trams-MacBook-Pro ~
    $ ls -gh
    total 0
    drwx------@   5 staff   160B Oct 11  2023 Applications
    drwx------+ 184 staff   5.8K Sep  1 14:01 Desktop
    drwx------+   3 staff    96B Jan 31  2024 Documents    

d. What flag will make the rm command ask for permission when removing a file?
Flag -i

e. Create a nested directory structure. Create files in various directories. 
hpbichtram@Trams-MacBook-Pro ~/Desktop
$ mkdir -p Folder 1/

hpbichtram@Trams-MacBook-Pro ~/Desktop
$ mkdir -p Folder/1 

hpbichtram@Trams-MacBook-Pro ~/Desktop
$ mkdir -p Folder/2

hpbichtram@Trams-MacBook-Pro ~/Desktop
$ mkdir -p Folder/3/text.txt

hpbichtram@Trams-MacBook-Pro ~/Desktop
$ mkdir -p Folder/2/test1.txt

hpbichtram@Trams-MacBook-Pro ~/Desktop
$ mkdir -p Folder/2/test2.txt

hpbichtram@Trams-MacBook-Pro ~/Desktop
$ mkdir -p Folder/README.md

f. List the absolute and relative path to a file.
- Absolute path: /Users/hpbichtram/Desktop/Images/Fig5.png
- Relative path: Images/Fig5.png (If I am in folder /Users/hpbichtram/Desktop/)

g. Demonstrate path shortcuts using the home directory, current directory, and parent directory.
/Users/hpbichtram/Desktop/Folder1/file.txt
- Home directory: ~/Desktop/Folder1/file.txt
- Current directory: ./file.txt (If I am in the Folder 1)
- Parent directory: ../file2.txt (If I am in the Folder 1 and access file2.txt in Desktop)