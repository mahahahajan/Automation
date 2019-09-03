#!/bin/bash

bold=$(tput bold)
normal=$(tput sgr0)

alias d='documents '
alias doc='documents '
alias Documents='documents '  

alias sshConfig="ssh_config"
alias internetTest="speedtest-cli"
alias speed="speedtest-cli"
alias itest="speedtest-cli"
alias k="ssh kamek"

function cmds(){
  echo "${bold} br ${normal}        - reloads bash profile"
  echo "${bold} documents ${normal} - opens documents"
  echo "${bold} doc ${normal}       - opens documents"
  echo "${bold} cl ${normal}        - cd into folder, and shows ls"
  echo "${bold} profile ${normal}   - opens bash_profile in vscode"
  echo "${bold} serve ${normal}     - live reload server on default 8000 or port specified "
  echo "${bold} website ${normal}   - create website files with boilerplate, and ${bold}serve${normal} on either 8000 or specified port "
  echo "${bold} create ${normal}    - walks through creation of new project"
  echo "${bold} download ${normal}  - download given url"
  echo "${bold} cmds ${normal}      - lists all cmds"
  echo "${bold} ssh_config ${normal}- (or sshConfig) opens ssh_config"
  echo "${bold} speed ${normal}     - (or internetTest or itest) tests internet speed"
}

function br(){
  if [[ $SHELL == "/bin/zsh" ]]
  then 
    source ~/.zshrc
    clear
    echo ".zshrc reloaded"
    pwd
  else
    source ~/.bash_profile
    clear
    echo "bash profile reloaded"
    pwd
  fi
}

function documents() {
  cd
  cd Documents
}
function cl(){
  cd $1 
  ls
}

function profile(){
  code ~/.bash_profile
}
function ssh_config(){
  code ~/.ssh/config
}

function serve(){
  export LOCAL_IP=`ipconfig getifaddr en0`
  if [ -z "$1" ]
    then
    browser-sync start -s -f . --no-notify --host $LOCAL_IP --port 8000 
  else
    browser-sync start -s -f . --no-notify --host $LOCAL_IP --port $1 
  fi
}
function website() {
  touch index.html
  touch style.css
  touch main.js
  cat > index.html << 'EOF'
  <!doctype html>
  <html lang="en">
    <head>
      <!-- Required meta tags -->
      <meta charset="utf-8">
      <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
      <meta name="author" content="Pulkit Mahajan"/>
      <meta name="copyright" content="Copyright (c) 2019 Pulkit Mahajan"/>
      <meta name="description" content="Hello, world!">
      <!-- Bootstrap CSS -->
      <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T" crossorigin="anonymous">
      <link rel="stylesheet" href="https://fonts.googleapis.com/icon?family=Material+Icons">
      <link href="https://fonts.googleapis.com/css?family=Oxygen|Roboto|Rubik|Ubuntu|Source+Sans+Pro&display=swap" rel="stylesheet">
      <title>Hello, world!</title>
    </head>
    <body>
      <h1>Hello, world!</h1>

      <!-- Optional JavaScript -->
      <!-- jQuery first, then Popper.js, then Bootstrap JS -->
      <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
      <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
      <script defer src="https://code.getmdl.io/1.3.0/material.min.js"></script>
    </body>
  </html>
EOF
  code -n .
  serve $1  
}
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