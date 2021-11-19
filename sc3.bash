#!/bin/bash
HOME=/home/user
lastBackUp=$(ls -1 $HOME | grep "Backup" | sort -r -k2 | head -1)
let dateDiff=($(date +%s)-$(date -d $(echo $lastBackUp | sed "s/^Backup-//") +%s))/60/60/24
if [ "$dateDiff" -le 7 ]
then
if [ ! -f /home/user/backup-report ]
then
touch /home/user/backup-report
fi
echo "directory $HOME/$lastBackUp is changed on $(date +%F)" >> /home/user/backup-report
copied="copied files: "
renewed="renewed files: "
for file in $(ls -1 $HOME/source)
do
if [ -f $HOME/$lastBackUp/$file ]
then
if [[ $(stat $HOME/$lastBackUp/$file -c%s) != $(stat $HOME/source/$file -c%s) ]]
then
mv $HOME/$lastBackUp/$file $HOME/$lastBackUp/$file.$(date +%F)
cp $HOME/source/$file $HOME/$lastBackUp/$file
renewed=$renewed$file" and changed previous to "$file.$(date +%F)", "
fi
else
cp $HOME/source/$file $HOME/$lastBackUp/$file
copied=$copied$file", "
fi
done
echo $copied >> /home/user/backup-report
echo $renewed >> /home/user/backup-report
else
ans="new directory $HOME/Backup-$(date +%F) is created, files "
mkdir $HOME/Backup-$(date +%F)
for file in $(ls -1 $HOME/source)
do
cp $HOME/source/$file $HOME/$lastBackUp/$file
ans=$ans$file", "
done
ans=$ans" are copied"
if [ ! -f /home/user/backup-report ]
then
touch /home/user/backup-report
fi
echo $ans >> /home/user/backup-report
fi
