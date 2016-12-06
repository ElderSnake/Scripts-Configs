#!/bin/bash

# PDF Compression Script

# Text Colors
txtylw=$(tput setaf 3) #Yellow text modifier
txtgrn=$(tput setaf 2)    # Green
txtrst=$(tput sgr0)       # Text reset


echo ${txtgrn}"Welcome to PDF Compression, please enter quality level."${txtrst}
echo
echo ${txtylw}"Quality levels are listed starting from lowest to highest"${txtrst}
select quality in screen ebook printer prepress;
do
      echo
      echo ${txtgrn} "$quality selected" ${txtrst}
      break;
done

echo
echo ${txtylw}"Now please input a name of the output file (what the compressed file will be called) WITHOUT the .pdf which will be appended automatically."${txtrst}
echo
echo -n "Enter:" 
read output


gs -dNOPAUSE -dBATCH -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/$quality -sOutputFile=$output.pdf $1 $2

echo
echo ${txtgrn}"Have a nice day :)"${txtrst}


exit 0
