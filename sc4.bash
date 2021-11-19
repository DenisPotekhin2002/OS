#!/bin/bash
HOME=/home/user
if [[ ! -d $HOME/restore ]]
then
mkdir $HOME/restore
fi
lastBackUp=$(ls -1 $HOME | grep "Backup" | sort | tail -1)
for file in $(ls -1 $HOME/$lastBackUp)
do
if [[ $(echo $file | grep -E "[0-9]{4}-[0-9]{2}-[0-9]{2}") == "" ]]
then
cp $HOME/$lastBackUp/$file $HOME/restore/$file
fi
