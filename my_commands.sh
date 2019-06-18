#!/bin/bash
# prints the input
function new_folder () {
  echo "Enter folder name: "
  read newFolderName
  mkdir $newFolderName
  cd $newFolderName
  echo "Git?"
  read gitAns
  if [ $gitAns == "yes" ] || [ $gitAns == "y" ]  || [ $gitAns == "Yes" ]
  then
      #do git stuff
    python /Users/pulkitmahajan/Documents/Python/createGitRepo.py $newFolderName
    gitSetup $newFolderName
    echo "Set up git repo"
  fi
}

function gitSetup () {
  git init
  git remote add origin git@github.com:mahahahajan/$1.git
  touch README.md
  git add .
  git commit -m "Initial commit"
  git push -u origin master
  code .
}


function create() {
  cd /Users/pulkitmahajan/Documents/
  echo "Do I already have a folder where I can put this?"
  read folderExists
  if [ $folderExists == "yes" ] || [ $folderExists == "y" ]  || [ $folderExists == "Yes" ]
  then
   echo "Which language / type of project is it?"
   read projType
   if [ -d /Users/pulkitmahajan/Documents/$projType ]
   then
    cd $projType
    echo "Create a new folder?"
    read newFolder
      if [ $newFolder == "yes" ] || [ $newFolder == "y" ]  || [ $newFolder == "Yes" ]
      then
          new_folder
      else
        echo "Enter filename: "
        read newFileName
        touch $newFileName
      fi
   else
    echo "how'd you screwn up your own script u fuck"
    fi
  else
    echo "create new folder?"
    read createNewFolder
    if [ $createNewFolder == "yes" ] || [ $createNewFolder == "y" ]  || [ $createNewFolder == "Yes" ]
    then
      #create new folder for this 
      new_folder
      echo "Path is now " $(pwd)
    else
      echo "fuck u 2 then"
    fi
  fi  
  #python /Users/pulkitmahajan/Documents/Python/youtubeDownloader.py $1
}

function download() {

  if [ -z "$2" ] #check if we have a second argument
  then 
    if [ -z "$1" ]
      then #at this point we dont have anything 
        echo "Enter URL: "
        read url
        echo "mp3 or mp4?"
        read typeFile
        echo " " $url " " $typeFile
    else
      echo "mp3 or mp4? "  #we have the url but not the type
      read typeFile
      url=$1
      echo " " $url " " $typeFile
    fi
  else
    url=$1
    typeFile=$2
    echo " " $url " " $typeFile  #we have a second arugment so assuming we have a first lmao 
  fi
  #python /Users/pulkitmahajan/Documents/Python/youtubeDownloader.py $url $typeFile
  #need to check if downloading mp3 vs mp4
  if [ $typeFile == "mp4" ] || [ $typeFile == "4" ]
  then
    cd /Users/pulkitmahajan/Documents/Videos
    youtube-dl --embed-thumbnail -o '%(title)s.%(ext)s' -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/best[ext=mp4]/best' $url 
    echo "Done"
  else
    cd /Users/pulkitmahajan/Documents/Videos/DownloadedMP3s
    youtube-dl -o '%(title)s.%(ext)s' -x --embed-thumbnail --audio-format mp3  $url
  fi 
}