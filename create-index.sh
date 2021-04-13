#!/bin/bash

# find all DSK images and process them

shopt -s nocaseglob
shopt -s globstar
shopt -s nocasematch

counter=1
dskcounter=1
index=1


# create INDEX folder if necessary
if [ ! -d "INDEX" ]; then
	mkdir "INDEX"
fi

# remove existing index file(s) in INDEX folder
if [ -e "INDEX/$1-ALL.TXT" ]; then
	rm "INDEX/$1*.TXT"
fi

# remove existing DW2HD.DSK image
if [ -e "DW2HD.DSK" ]; then
	rm "DW2HD.DSK"
fi


# create new DW2HD.DSK image
decb dskini "DW2HD.DSK"
decb copy -0 -a -t -r "DW2HD32.BAS" "DW2HD.DSK","DW2HD32.BAS"
decb copy -0 -a -t -r "DW2HD80.BAS" "DW2HD.DSK","DW2HD80.BAS"
decb copy -0 -a -t -r "FORMAT.BAS" "DW2HD.DSK","FORMAT.BAS"


for i in $PWD/$1/**/*.DSK; do # Whitespace-safe and recursive

	fullfilename="$i"
	filename=$(basename "$fullfilename")
	fname="${filename%.*}"
	filesize=$(stat -c%s "$fullfilename")

	# extract parent folder name from full path
	filepath=$i
	parentname="$(basename "$(dirname "$filepath")")"


	# check for copy protected images, etc., and exclude them
	if [[ $fullfilename != *"protected"* ]] && [[ $fullfilename != *"OS-9"* ]] && [[ $fullfilename != *"Disto"* ]] && [[ $fullfilename != *"SDC"* ]] && [[ $fullfilename != *"OS9"* ]] && [[ $fullfilename != *"Burke"* ]] && [[ $fullfilename != *"Bible"* ]] && [[ $fullfilename != *"CoCoVGA"* ]] && [[ $fullfilename != *"French"* ]] && [[ $fullfilename != *"Portuguese"* ]] ; then

		if [ $filesize -lt 161281 ]; then

			if [ $counter -lt 257 ]; then

				echo $counter,\""$fullfilename\"",\""$parentname\"",\""$filename\"",\""$fname\"",$filesize | grep -E '.DSK|.dsk' >> INDEX/$1$dskcounter.TXT
				echo $counter,\""$fullfilename\"",\""$parentname\"",\""$filename\"",\""$fname\"",$filesize | grep -E '.DSK|.dsk'
				counter=$((counter+1))

				else

				echo
				echo 256 disk limit per partition reached - creating next index file...
				echo
				counter=1
				dskcounter=$((dskcounter+1))

	    			echo $counter,\""$fullfilename\"",\""$parentname\"",\""$filename\"",\""$fname\"",$filesize | grep -E '.DSK|.dsk' >> INDEX/$1$dskcounter.TXT
    				echo $counter,\""$fullfilename\"",\""$parentname\"",\""$filename\"",\""$fname\"",$filesize | grep -E '.DSK|.dsk'
				counter=$((counter+1))

			fi

    				echo $index,\""$fullfilename\"",\""$parentname\"",\""$filename\"",\""$fname\"",$filesize | grep -E '.DSK|.dsk' >> INDEX/$1-ALL.TXT
				index=$((index+1))

		else

			echo Disk size greater than 161,280 - skipping...

		fi

	fi


done


unix2dos INDEX/$1*.TXT


# copy INDEX file(s) to DW2HD.DSK image

cd INDEX
for i in $1*.TXT*; do
	decb copy -1 -a -r "$i" "../DW2HD.DSK","$i"
done

cd ..

shopt -u nocaseglob
shopt -u globstar
shopt -u nocasematch

