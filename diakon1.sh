#!/bin/bash

# NEEDED PACKAGES:
#  - sysstat
#  - iotop

# Initialize variables
results_filename="io_test_results"
threshold="1"

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
         echo "[*] Usage: \"$0 -t threshold_of_iowait_parameter -f results_filename\"."
         exit 1
         ;;
      \?)
         echo "[!] Unknown option (usage: \"$0 -t threshold_of_iowait_parameter -f results_filename\")!"
         exit 1
         ;;
   esac
done

# Remove commas from threshold parameter if any.

threshold=$(echo $threshold | sed 's/\,/./')
echo "" > $results_filename # Clear the file.

# Infinite loop.

while true
do
   # Get CPU utilization report (show the percentage of time that
   # the CPUs were idle during which the system had an outstanding
   # disk IO request).
   iowait=`iostat -c | sed -n '4p' | awk '{print $4}'`
   iowait=$(echo $iowait | sed 's/\,/./') # Remove commas.

   if [[ "$iowait" > "$threshold" ]]
   then
      time=$(date +"%T, %d-%m-%Y")
      echo "Alarm ($time):" >> $results_filename
      iotop --only -b -n 5 -P -k >> $results_filename
      echo "" >> $results_filename # New line.
   fi

   sleep 1 # Sleep for 1 second.
done