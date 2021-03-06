#!/bin/zsh

# this is a script to take a backup of a Hard drive with the dd command in linux and zip it for backup.

# The program requires the package "pigz" and "pv" to be installed, as it will use pigz instead of gzip so that the job may be done as fast as possible with all available cores on a machine. PV will be used to monitor progress of the action.

#We'll go ahead and check if these programs are installed, and get them installed.
for program in pigz pv; do
  installed=$(command -v $program)
  [[ -z "$installed" ]] && echo "$program is not installed" && sudo apt update && sudo apt install $program || echo "$program is installed"
done

# Here is the action:
date=$(date +"%m.%d.%y")

echo "Name the Backup"

read backupname

echo "Select drive letter to backup e.g sdA or sdB in lowercase."

read drive

pv </dev/sd$drive | pigz -c >/home/fenix/Downloads/$date$backupname.img.gz
