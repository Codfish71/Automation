#!/bin/bash


echo "give me a bottle of rum!"


if [ $# -gt 2 ]; then 
	echo "Usage :  ./script.sh domain"
	echo "Example :  ./script.sh yahoo.com"

fi

if [ ! -d "thirdLevels" ]; then
	mkdir thirdLevels
fi


if [ ! -d "scans" ]; then 
	mkdir scans

fi

if [ ! -d "eyewitness" ]; then
	mkdir eyewitness
fi

pwd=$(pwd)

echo "Gathering subdomains with sublist3r ..."

sublist3r -d $1 -o final.txt

echo $1 >> final.txt

echo "Compiling third Level domains"
cat final.txt | grep -Po "(\w+\.\w+\.\w+)$" | sort -u >> third-levels.txt

echo "Gathering Full 3rd level subdomains wiht sublist3r"
for domain in $(cat third-levels.txt); do sublist3r -d domain -o thirdLevels/$domain.txt | sort -u final.txt;done

if [ $# -eq 2 ];
then
	echo "Probing for alive third-levels"
	cat final.txt | sort -u | grep -v $2 | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ":443" > probed.txt

else   
	echo "Probing for alive third-levels"
		cat final.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ":443" > probed.txt	

fi


echo ""
echo ""

echo "Getting all Urls ..."
cat probed.txt | gau -v -o urls.txt


echo "Dirsearch For all the subdomains"
dirsearch -l /home/pratham/Desktop/hunting/final.txt -e php,html,js,git,jsp,xml,gitignore  -x 301,302,400,401,402,403,404 -o /usr/share/dirsearch/dirs.txt; 
cat /usr/share/dirsearch/dirs.txt | tee finalDirs.txt ;


sort finalDirs.txt | uniq;


