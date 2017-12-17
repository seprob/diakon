# Diakon

## Synopsis

Diakon can be used to looking processes causing high CPU iowait parameter or checking what process actually reads or writes on the disk.

## Usage

"**diakon1.sh**":
```
diakon1.sh -t threshold_of_iowait_parameter -f results_filename
```
where
- "threshold_of_iowait_parameter" is a threshold for iowait parameter and if it exceeded than cause alarm,
- "results_filename" is a path to the filename for alarm results (all data will be overwritten).

Optional usage is 
```
diakon1.sh -h
``` 
which lets you print information about the tool's usage.

"**diakon2.sh**":
```
diakon2.sh -f results_filename
```
where
- "results_filename" is a path to the filename for alarm results (all data will be overwritten).

Optional usage is 
```
diakon2.sh -h
``` 
which lets you print information about the tool's usage.