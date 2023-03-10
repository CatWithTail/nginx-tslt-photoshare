#!/usr/bin/env bash

InputFolder=/mnt/raid1/sambashare/photos/JPG
SubFolder=/Marik

ls $InputFolder$SubFolder/ | grep " " | while read File; do mv $InputFolder$SubFolder/$File  $(echo $InputFolder$SubFolder/$File | tr " " "_" ); done

FileList=$(ls $InputFolder$SubFolder/ | grep -vE '^[[:digit:]]{4}\.??\.??\.'| grep ".NEF$\|.jpg\|jpeg\|JPG")
FilesAmount=$(echo $FileList | wc -w)
FileCounter=0
for i in $FileList
  do
  	echo "$i"
    mv $InputFolder$SubFolder/$i $InputFolder$SubFolder/$(exiftool -DateTimeOriginal $InputFolder$SubFolder/$i | awk '{print $4"."$5"_"}'|tr ":" ".")$i
    let "FileCounter = FileCounter + 1"
    let "ToGo = FilesAmount - FileCounter"
    if (( $ToGo > 0 ))
      then 
        echo "$FileCounter $(if (( $FileCounter > 1 )); then echo "files are"; else echo "file is "; fi ) done, $ToGo to go."
      else
      	echo "$FileCounter $(if (( $FileCounter > 1 )); then echo "files are"; else echo "file is "; fi ) done."
    fi
done

echo "DONE"