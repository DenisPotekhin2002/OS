#!/bin/bash
if [ $# -ne 1 ]
then
echo "Wrong input"
exit 1
fi
HOME=/home/user
if [ ! -d $HOME/.trash ]
then
mkdir $HOME/.trash
fi
DATE=$(date +%s)
if [ -f $PWD/$1 ]
then
ln $PWD/$1 "$HOME/.trash/$DATE"
rm $PWD/$1
if [ ! -f $HOME/.trash.log ]
then
touch $HOME/.trash.log
fi
echo "$PWD/$1:$DATE" >> $HOME/.trash.log
else
echo "Wrong filename"
fi
