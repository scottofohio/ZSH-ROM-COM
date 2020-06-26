
# Replace grep with rg also known as ripgrep

Must faster implementation written in rust that ignores files in gitignore hidden files and binaries.

skipts the -R (recursive syntax) and is recursive by default

simple as
```
rg search_term
```

can accept pipe input just like grep

```
cat my.log | rg search_term
```

So far almost exactly the same until you factor in the speed.

on my sample working code base( with files files that shouldn't be searched like log files and version control files)
```
Time comparison

my_project>rg the          - 1s
my_project>grep -R the .   -  28s
```
Now I'm going to run the same search on the codebase with all the directories that shouldn't be searched removed
```
 
