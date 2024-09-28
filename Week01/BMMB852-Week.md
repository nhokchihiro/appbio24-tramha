# Lecture 1:
a. Set up your computer => DONE

b. Follow the installation instructions => DONE

c. How can you tell that you were successful? => It appeared as below when I tested.

```
conda activate bioinfo
```

d. Can you run the samtools program? => YES (I run head command for example)

```
samtools head file1.bam
```

e. What version is your samtools program? => 1.20

```
samtools --version

```

*Answer:*
```
samtools 1.20
Using htslib 1.20
Copyright (C) 2024 Genome Research Ltd.
```

f. GitHub repository: https://github.com/nhokchihiro/appbio24-tramha

# Lecture 2:
**a. Describe a Unix command not discussed in the class or the book. Try to find something that might be useful. When would you use that command?**

Command line: ssh

Function: Use to log in and connect to a remote computer/machine and execute remote commands.

Example: I use this command line to access Roar Cluster of PSU as below:
```
ssh tmh6573@submit.hpc.psu.edu
```

**b. Describe a customization for the command you chose above (describe the effect of a flag/parameter).**
Command line: ssh -p 

Function: To connect to a server through other port number, not the default port 22.

Example: 
```
[tmh6573@submit01 ~]$ ssh -p 443 tmh6573@submit.hpc.psu.edu
ssh: connect to host submit.hpc.psu.edu port 443: Connection refused
```

**c. What flags will make the ls command write out the files sizes in “human-friendly” mode?**

Any flags go with -h.

*Example 1: Flag -lh: ls -lh*
To list files in long format (-l) and print sizes in human-readable format as KB, GB, MB (-h).
    
```
ls -lh
```
*Answer:*
```
total 0
drwx------@   5 hpbichtram  staff   160B Oct 11  2023 Applications
drwx------+ 184 hpbichtram  staff   5.8K Sep  1 14:01 Desktop
drwx------+   3 hpbichtram  staff    96B Jan 31  2024 Documents
```

*Example 2: Flag -hg: ls -hg *
Same as ls -lh, but it just does not print the owners of these files/folders.

```
ls -gh
```
*Answer:*
```
total 0
drwx------@   5 staff   160B Oct 11  2023 Applications
drwx------+ 184 staff   5.8K Sep  1 14:01 Desktop
drwx------+   3 staff    96B Jan 31  2024 Documents    
```

**d. What flag will make the rm command ask for permission when removing a file?**
Flag -i

**e. Create a nested directory structure. Create files in various directories.**

```
mkdir -p Folder 1/
mkdir -p Folder/1 
mkdir -p Folder/2
mkdir -p Folder/3/text.txt
mkdir -p Folder/2/test1.txt
mkdir -p Folder/2/test2.txt
mkdir -p Folder/README.md
```

**f. List the absolute and relative path to a file.**
- Absolute path: /Users/hpbichtram/Desktop/Images/Fig5.png
- Relative path: Images/Fig5.png (If I am in folder /Users/hpbichtram/Desktop/)

**g. Demonstrate path shortcuts using the home directory, current directory, and parent directory.**
/Users/hpbichtram/Desktop/Folder1/file.txt
- Home directory: ~/Desktop/Folder1/file.txt
- Current directory: ./file.txt (If I am in the Folder 1)
- Parent directory: ../file2.txt (If I am in the Folder 1 and access file2.txt in Desktop)
