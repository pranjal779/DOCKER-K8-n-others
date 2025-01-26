#!/bin/bash


##################
#
# Author: pranj779
# Date: 01/25/2025
#
# #################
#
# Write a script that is divisible by 3 and 5 and not by 15

# Simplified Version Without expr:
for i in {1..100}; do
	if [[ ( $((i % 3)) == 0 || $((i % 5)) == 0 ) && $((i % 15)) != 0 ]]; then
		echo $i
	fi
done


# old syntax
# for i in {1..100}; do
# if ([`expr $i %3` == 0] || [`expr $i %5` == 0]) && [`expr $i % 15` != 0];
# then
#	echo $i
#fi;
#done
