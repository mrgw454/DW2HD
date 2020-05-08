#!/bin/bash

# find all DSK images and process them

shopt -s nocaseglob
shopt -s globstar
shopt -s nocasematch

counter=1
dskcounter=1
index=1

for i in $PWD/$1/**/*.DSK; do # Whitespace-safe and recursive

		fullfilename="$i"
		filename=$(basename "$fullfilename")
    fname="${filename%.*}"
    filesize=$(stat -c%s "$fullfilename")

    # extract parent folder name from full path
    filepath=$i
    parentname="$(basename "$(dirname "$filepath")")"


# check for copy protected images, etc., and exclude them
if [[ $fullfilename == *"Coco 3"* ]] && [[ $fullfilename != *"OS-9"* ]] || [[ $fullfilename == *"Coco 3"* ]] && [[ $fullfilename != *"OS9"* ]] || [[ $fullfilename == *"Coco 3"* ]] && [[ $fullfilename != *"Burke"* ]] || [[ $fullfilename == *"Coco 3"* ]] && [[ $fullfilename != *"Disto"* ]] ; then


	if [ $filesize -lt 161281 ]; then

			if [ $counter -lt 257 ]; then
    
    			echo $counter,\""$fullfilename\"",\""$parentname\"",\""$filename\"",\""$fname\"",$filesize | grep -E '.DSK|.dsk' >> $1$dskcounter.TXT
    			echo $counter,\""$fullfilename\"",\""$parentname\"",\""$filename\"",\""$fname\"",$filesize | grep -E '.DSK|.dsk'
					counter=$((counter+1))
				
			else
		
					echo
					echo 256 disk limit per partition reached - creating next index file...
					echo
					counter=1
					dskcounter=$((dskcounter+1))

    			echo $counter,\""$fullfilename\"",\""$parentname\"",\""$filename\"",\""$fname\"",$filesize | grep -E '.DSK|.dsk' >> $1$dskcounter.TXT
    			echo $counter,\""$fullfilename\"",\""$parentname\"",\""$filename\"",\""$fname\"",$filesize | grep -E '.DSK|.dsk'
					counter=$((counter+1))
				
			fi			

    			echo $index,\""$fullfilename\"",\""$parentname\"",\""$filename\"",\""$fname\"",$filesize | grep -E '.DSK|.dsk' >> $1-ALL.TXT
					index=$((index+1))


	else

    	echo Disk size greater than 161,280 - skipping...

	fi


fi


done

unix2dos $1*.TXT

shopt -u nocaseglob
shopt -u globstar
shopt -u nocasematch

