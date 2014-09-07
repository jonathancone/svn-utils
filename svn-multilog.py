from subprocess import call
import sys

projects_file = sys.argv[1]
svn_path = sys.argv[2] 
oldest_rev = sys.argv[3]

with open(projects_file) as f:
    repo_paths = f.readlines()

print [svn_path + line[:-1] for line in repo_paths]

paths = [svn_path + line[:-1] for line in repo_paths]

for path in paths:
	call(['svn', 'log', path, '-v', '--stop-on-copy', '-r', 'HEAD:' + oldest_rev])