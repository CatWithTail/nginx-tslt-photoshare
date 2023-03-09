#!/usr/bin/env bash

InputFolder=/mnt/raid1/sambashare/photos/DCIM
SubFolder=/Marik
OutputFolder=/mnt/raid1/sambashare/photos/JPG
PreviewFolder=/mnt/raid1/sambashare/photos/JPG.PREVIEWS

#convert /mnt/raid1/sambashare/photos/DCIM/странное/DSC_0555.NEF /mnt/raid1/sambashare/photos/JPG/странное/DSC_0555.NEF.jpeg

DirectoryCreation () {
  echo "Workfolder for input is $InputFolder$SubFolder"
  if [ ! -d "$OutputFolder$SubFolder" ]
    then
      mkdir -p "$OutputFolder$SubFolder"
    else
      echo "The subfolder is already exists"
  fi
  echo "Workfolder for output is $OutputFolder$SubFolder"
  if [ ! -d "$PreviewFolder$SubFolder" ]
    then
      mkdir -p "$PreviewFolder$SubFolder"
    else
      echo "The subfolder is already exists"
  fi
  echo "Workfolder for previews is $PreviewFolder$SubFolder"
}

FileConversion () {
  FileList=$(ls $InputFolder$SubFolder/ | grep ".NEF$")
  FilesAmount=$(echo $FileList | wc -w)
  echo "This action has to convert $FilesAmount file$(if (( $FilesAmount > 1 )); then echo "s"; fi )"
  FileCounter=0
  for i in $FileList
    do
      echo "Converting file $i"
      if [ ! -f "$OutputFolder$SubFolder/$i.jpg" ]
        then
          convert "$InputFolder$SubFolder/$i" "$OutputFolder$SubFolder/$i.jpg" && echo "$i is done"
        else
          echo "$OutputFolder$SubFolder/$i.jpg is alredy exists"
      fi
    let "FileCounter = FileCounter + 1"
    let "ToGo = FilesAmount - FileCounter"
    if (( $ToGo > 0 ))
      then 
        echo "$FileCounter $(if (( $FileCounter > 1 )); then echo "files are"; else echo "file is "; fi ) done, $ToGo to go."
      else
      	echo "$FileCounter $(if (( $FileCounter > 1 )); then echo "files are"; else echo "file is "; fi ) done."
    fi
    echo " "
  done
  echo "We are done with NEF->JPG conversion."
  echo " " 
}

MakingPreview () {
  FileList=$(ls $OutputFolder$SubFolder/ | grep ".jpg$")
  FilesAmount=$(echo $FileList | wc -w)
  echo "This action has to MakingPreview $FilesAmount file$(if (( $FilesAmount > 1 )); then echo "s"; fi )"
  FileCounter=0
    for i in $FileList
    do
      echo "Converting file $i"
      if [ ! -f "$PreviewFolder$SubFolder/$i.800x800.jpg" ]
        then
          convert "$OutputFolder$SubFolder/$i"  -resize 800x800 "$PreviewFolder$SubFolder/$i.800x800.jpg" && echo "$i is done"
        else
          echo "$PreviewFolder$SubFolder/$i.800x800.jpg is alredy exists"
      fi
    let "FileCounter = FileCounter + 1"
    let "ToGo = FilesAmount - FileCounter"
    if (( $ToGo > 0 ))
      then 
        echo "$FileCounter $(if (( $FileCounter > 1 )); then echo "files are"; else echo "file is "; fi ) done, $ToGo to go."
      else
      	echo "$FileCounter $(if (( $FileCounter > 1 )); then echo "files are"; else echo "file is "; fi ) done."
    fi
    echo " "
  done
  echo "We are done with 800X800 preview."
  echo " " 


}

DirectoryCreation
FileConversion
MakingPreview