# svn-utils
Small utilities for working with Subversion

#### git-svn-cloneback.sh
Perform a `git svn clone` based on the last N revisions of the SVN repo.  This is useful if you have a giant SVN repo you want to move to git, but you don't want to clone the entire history.
```bash    
# Syntax
./git-svn-cloneback.sh -u <SVN url> -l <limit>

# Example: Clone just the last 500 revisions from the SVN HEAD

./git-svn-cloneback.sh -u https://svn/proj/trunk -l 500

# Example: Clone starting from 4 revisions before SVN r9871

./git-svn-cloneback.sh -u https://svn/proj/trunk@9871 -l 4

# Example: Clone last 20 revisions into mydir

./git-svn-cloneback.sh -u https://svn/proj/trunk -l 20 -o mydir --authors-file=svn-auth.txt
```
