#!/usr/bin/bash
# -*- coding: utf-8 -*-

# NOTE 
# This won't work if the scripts
# need to be compiled too!
# Do not use if you do no know
# what you are doing as it could
# damage your system.
#
# Sudo is used here, don't enter
# a password if you have not checked
# this script before or you when you
# are wondering right now why you
# are having this script.

# Define Variables
# FOLDER:  String of path to scripts to install.
# FILES: Array of script names.
# NUM_OF_FILES: Number of files to install.
FOLDER="tools/*"
FILES=()

for filename in $FOLDER; do
	filename=${filename#tools/}	# Cut away Path's name.
	FILES+=($filename)
done

NUM_OF_FILES=${#FILES[@]}

# Check if FOLDER and FILES are the same.
# If they are the same, there are no files
# in the fold, so nothing to do.
if [[ $FOLDER == ${FILES[@]} ]]; then
	printf "\n\n[!] Nothing to install.\n\n"
	exit 0
fi


# Give information about number of Scripts
# to install and their names.
if [[ NUM_OF_FILES -gt 1 ]]; then
	printf "\n[+] Found $NUM_OF_FILES scripts to install.\n"
fi

# Print out the scripts which will be installed.
printf "[+] Scripts to install:\n"
for file in ${FILES[@]}; do
	printf "$file\n"
done


# Then check if "/usr/local/bin" is available.
# If yes we make the files executable and move
# them to there.
for ((  i=0; i<NUM_OF_FILES; i++ )); do
	# Check first to which directory we can
	# install to.
	if [[ -e "/usr/local/bin" ]]; then
		TARGET="/usr/local/bin/"
	else
		TARGET="/home/$USER/.local/bin/"
	fi

	file=${FILES[i]}
	sudo chmod +x $file
	sudo cp $file $TARGET
done

printf "\n[+] Installed to "$TARGET"."
printf "\n\n[+] Installation finished.\n\n"

