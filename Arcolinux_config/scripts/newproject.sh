#!/bin/bash


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

#function to print all helpfull advices
function helpfunc(){
    echo -e "\n${redColour}[!] ${endColour}${grayColour}Use: createdoc.sh${endColour}"
    for i in $(seq 1 80); do echo -ne "${grayColour}-"; done; echo -ne "${endColour}"
    echo -e "\n\n\t${grayColour}[-l]${endColour} ${yellowColour}Location:${endColour}${grayColour}\tWrite the location to store your file${endColour}"
    echo -e "\n\t${grayColour}[-p]${endColour} ${yellowColour}Project:${endColour}${grayColour}\tWrite the name for your project${endColour}"
    echo -e "\n\t${grayColour}[-s]${endColour} ${yellowColour}Subject:${endColour}${grayColour}\tSpecify the subject for your project${endColour}"
    echo -e "\n\t${grayColour}[-r]${endColour} ${yellowColour}Remove:${endColour}${grayColour}\tRemove specified project${endColour}"
}

# function to delete the project
function rmproject(){
    location=$(cat /home/unai/.scripts/projects.txt | cut -d" " -f2)
    rm -rf $location
    sed -i "/\b$project\b/Id" /home/unai/.scripts/projects.txt
    echo -e "${yellowColour}[*]${endColour}${blueColour} $project removed${endColour}"
}

#function to create a new project
function createproject(){
    for i in $(seq 1 80); do echo -ne "${grayColour}-"; done; echo -ne "${endColour}\n"
    echo -e "${greenColour}[Location]:${endColour} ${grayColour}\t\t$location${endColour}"
    echo -e "${greenColour}[Project name]:${endColour} ${grayColour}\t$project${endColour}"
    echo -e "${greenColour}[Subject]:${endColour} ${grayColour}\t\t$subject${endColour}"
    for i in $(seq 1 80); do echo -ne "${grayColour}-"; done; echo -ne "${endColour}\n"
    echo -e "${yellowColour}[*]${endColour}${blueColour} Creating files...\n${endColour}"
    mkdir $location/$project
    echo -e "${grayColour}-> Main folder created${endColour}"
    mkdir $location/$project/bin
    echo -e "${grayColour}-> bin created${endColour}"
    mkdir $location/$project/src
    echo -e "${grayColour}-> src created${endColour}"
    mkdir $location/$project/doc
    echo -e "${grayColour}-> doc created${endColour}\n"
    mkdir $location/$project/doc/images
    cp /home/unai/Latex/images/* $location/$project/doc/images
    cp /home/unai/Latex/plantilla_upv.tex $location/$project/doc/$project-doc.tex

    

    sed -i "s/titleforthedocument/$project/g" $location/$project/doc/$project-doc.tex
    sed -i "s/subjectforthedocument/$subject/g" $location/$project/doc/$project-doc.tex
    sed -i "s/authorofthedocument/Unai Fernandez/g" $location/$project/doc/$project-doc.tex

    echo "$project $location/$project" >> /home/unai/.scripts/projects.txt
    echo -e "${yellowColour}[*]${endColour}${blueColour} DONE!${endColour}"
}

parameter_counter=0; remove=0; while getopts "l:p:d:s:r:h:" arg; do
    case $arg in
        l) location=$OPTARG; let parameter_counter+=1;;
        p) project=$OPTARG; let parameter_counter+=1;;
        d) project=$OPTARG; let parameter_counter+=1;;
        s) subject=$OPTARG; let parameter_counter+=1;;
        r) project=$OPTARG; rmproject; let remove+=1;;
        h) helpfunc;;
    esac
done



if [ $parameter_counter -eq 0 ]; then
    if [ $remove -eq 0 ]; then
        helpfunc
    fi
elif [ $parameter_counter -eq 1 ]; then
    helpfunc
elif [ $parameter_counter -eq 2 ]; then
    helpfunc
else
    createproject    
fi

