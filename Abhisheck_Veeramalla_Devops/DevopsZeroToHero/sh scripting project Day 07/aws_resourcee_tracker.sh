#!/bin/bash

#################################################################
# Author: Pranjal						#
# Date: 1-26-25							#
#								#
#								#
# Project on Reseurce tracking using sh scripting and aws cli	#
# This script will report the AWS resource usage		#
#								#
# Services we will use:						#
# AWS S3							#
# AWS EC2							#
# AWS Lambda							#
# AWS IAM Users							#
#################################################################

set -x

# List s3 buckets
echo "Print List of s3 buckets: "
aws s3 ls > resourceTracker

# List EC2 instances
echo "Print List of ec2 instances: "
# aws ec2 describe-instances
# this will only fetch the Instance ID Only
aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId' # jq = json parser && yq = yaml/yml parser
# FOR EXAMPLE:
# ╰─ $ aws ec2 describe-instances | jq '.Reservations[].Instances[].InstanceId'
# "i-09c1dae4f1275f3c4"

# list AWS Lambda
echo "Print List of lambda functions: "
aws lambda list-functions >> resourceTracker


# list IAM users
echo "Print List of iam-users: "
aws iam list-users

