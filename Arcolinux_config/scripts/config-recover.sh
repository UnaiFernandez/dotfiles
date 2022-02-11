#!/bin/bash

############################################################################
##### THIS SCRIPT COPIES THE OLD CONFIGURATION FILES TO .config FOLDER #####
############################################################################


#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"


trap ctrl_c INT

function ctrl_c(){
    echo -e "\n${yellowColour}[*] ${endColour}${yellowColour}Exiting...${endColour}"
	exit 0
}


function helpfunc(){
    echo -e "\n${redColour}[!] ${endColour}${grayColour}Use: config-recover.sh${endColour}"
    for i in $(seq 1 80); do echo -ne "${grayColour}-"; done; echo -ne "${endColour}"
    echo -e "\n\n\t${grayColour}[-f]${endColour} ${yellowColour}Config folder:${endColour}${grayColour}\tSelect the folder where backup files are stored${endColour}"
    echo -e "\n\t${grayColour}[-h]${endColour} ${yellowColour}Help:${endColour}${grayColour}\t\tPrints this scripts usage${endColour}"
}



parameter_counter=0; while getopts "f:h:" arg; do
    case $arg in
        f) folder=$OPTARG; let parameter_counter+=1;;
        h) helpfunc;;
    esac
done

if [ $parameter_counter -eq 0 ]; then
    helpfunc
else
    echo -e "${yellowColour}[*]${endColour}${blueColour}Copying files...${endColour}"

    ## Copy i3 config ##
    cp $folder/i3/config .config/i3/config

    ## Copy i3blocks config ##
    cp $folder/i3/i3blocks.conf .config/i3/i3blocks.conf

    ## Copy zshrc file ##
    cp .zshrc-backup .zshrc

    ## Copy mimeapps list ##
    cp $folder/mimeapps.list .config/mimeapps.list

    ## Copy gtk 3.0 settings ##
    cp $folder/gtk-3.0/settings.ini .config/gtk-3.0/settings.ini

    ## Copy opnebox config
    cp -r $folder/openbox/* .config/openbox

    ## Copy rofi config
    cp $folder/rofi/* .config/rofi

    ## Copy tint2 config
    cp $folder/tint2/* .config/tint2


    echo -e "${yellowColour}[*]${endColour}${blueColour}DONE!!${endColour}"
fi
