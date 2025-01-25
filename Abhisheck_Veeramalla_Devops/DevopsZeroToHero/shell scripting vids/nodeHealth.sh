??? from here until ???END lines may have been inserted/deleted
#!/bin/bash

# this below box falls in best practice
# Also known as metadata information

##########################################
# Author: Pranjal			 #	
# Date: 01/25/2025			 #	
#                                        #
# This script outputs the node health	 #
#					 #	
# Version: v1				 #	
##########################################


set -x # debug mode
# whenever using pipe command use pipe command specific syntax? (unsure about this) {also falls in best practice?}
set -e # exit the script when there is an error			# pipe-syntax-goodpractice
set -o pipefail							# pipe-sytanx-goodpractice




# if -o pipefail is not set, set -e will not error out if the commands  have pipe '|'.

# echo "Print the disk space"
df -h

# echo "Print the memory"
free -g

# echo "Print the cpu"
nproc

# Using awk command with | pipe command with ps -ef
# Basically to get the process ID of the amzon process in my Laptop.
ps -ef | grep amazon | awk -F" " '{print $2}'



# comment set -o pipefail and try the following command
# asdfafadf | echo
# # or
# asdfasdfewfadf | echo | asdfasdfadf
# # or
# asdfafg | echo | sdafsfw | echo
# Then un comment set -o pipefail and then observe the behaviour

# understand the set -o pipefall drawback as well

# alternate way to set the above commands are:
# set -exo pipefail
# but according to abhishek to follow this method as the seperate method has more flexibilty and easy



