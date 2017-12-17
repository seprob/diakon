#!/bin/bash

# NEEDED PACKAGES:
#  - iotop

# Initialize variables
results_filename="io_test_results"

# Check if user is root.
if [ $(id -u) -ne "0" ] # If is not logged as root.
then
   echo "[!] Your're not logged as root!"
   exit 1 # Exit with code error.
fi

while getopts :t:f:h argument; do
   case $argument in
      t)
         # Threshold of iowait parameter.
         threshold=$OPTARG
         ;;
      f)
         # File to save results.
         results_filename=$OPTARG
         ;;
      h)
         echo "[*] Usage: \"$0 -f results_filename\"."
         exit 1
         ;;
      \?)
         echo "[!] Unknown option (usage: \"$0 -f results_filename\")!"
         exit 1
         ;;
   esac
done

echo "" > $results_filename # Clear the file.

# Infinite loop: check what currently makes write and read operations on the disk.

while true
do
   time=$(date +"%T, %d-%m-%Y")
   echo "Tag ($time):" >> $results_filename
   iotop --only -b -n 5 -P -k >> $results_filename
   echo "" >> $results_filename # New line.

   sleep 1 # Sleep for 1 second.
done