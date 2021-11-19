#!/bin/bash
HOME=/home/user
found=false
deleted=false
restoring=$1
finish=false
while [[ $finish == false ]]
do
#echo $finish
changedRestoring=false
for i in $(grep $restoring $HOME/.trash.log)
do
pathName=$(echo $i | awk -F ":" '{print $1}')
fileName=$(echo $i | awk -F ":" '{print $2}')
if [[ -f $HOME/.trash/$fileName ]]
then
found=true
echo "restore $pathName?"
read ans
if [[ $ans == "yes" ]]
then
if [ -d $(dirname $pathName) ]
then
ln $HOME/.trash/$fileName $pathName &&
{
deleted=true
rm $HOME/.trash/$fileName
finish=true
break
} || 
{
echo "change file name"
read ans2
restoring=$ans2
changedRestoring=true
#break
}
else
echo "directory $(dirname $pathName) was deleted"
ln $HOME/.trash/$fileName $HOME/$1 &&
{
deleted=true
rm $HOME/.trash/$fileName
finish=true
break
} || 
{
echo "change file name"
read ans2
restoring=$ans2
changedRestoring=true
#break
}
fi
fi
fi
done
if [[ $changedRestoring == false && $deleted == false ]]
then
break
fi
done
if [[ $found == "false" ]]
then
echo "nothing found"
else
if [[ $deleted == "false" ]]
then
echo "nothing else found"
fi
fi
