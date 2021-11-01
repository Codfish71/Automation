#!/bin/bash

echo "give me a bottle of rum!"

amass enum -d $1 -o subdomains.txt

sort -u subdomains.txt | httprobe > uniq.txt

eyewitness --web -f uniq.txt -d /screenshot

for I in $(ls); do 
        echo "$I" >> index.html;
        echo "<img src=$I><br>" >> index.html;
done

python3 /home/pratham/Desktop/tools/ParamSpider/paramspider.py -d $1 > param.txt

dalfox -b hahwul.xss.ht file param.txt
