#!/bin/bash


echo "give me a bottle of rum!"


echo "DIrsearch Automation for every Subdomain YOu have found"


set -e

bold="\e[1m"
version="1.2.0"
red="\e[1;31m"
green="\e[32m"
blue="\e[34m"
cyan="\e[2;36m"
end="\e[0m"

dirsearch -l /home/pratham/Desktop/hunting/final.txt -e php,html,js,git,jsp,xml,gitignore  -x 301,302,400,401,402,403,404 -o /usr/share/dirsearch/dirs.txt; 
cat /usr/share/dirsearch/dirs.txt | tee finalDirs.txt ;


sort finalDirs.txt | uniq;
