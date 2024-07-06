#!/bin/bash
GREEN="\e[92m"
YELLOW="\e[93m"
CYAN="\e[96m"
DEFAULT="\e[0m"

if [ "$EUID" -ne 0 ]
  then echo "ERROR: You need to run this script as root!"
  exit
fi

echo -e "${CYAN}Script started.${DEFAULT}"
echo -e "${YELLOW}Installing modules and headers...${DEFAULT}"
cp -fr lib /
cp -fr include /usr
echo -e "${GREEN}Installing modules and headers finished.${DEFAULT}"
echo -e "${CYAN}Script finished. To install the kernel, set the path as shown here: https://learn.microsoft.com/en-us/windows/wsl/wsl-config#example-wslconfig-file${DEFAULT}"
