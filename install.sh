#!/bin/bash
GREEN="\e[92m"
YELLOW="\e[93m"
CYAN="\e[96m"
DEFAULT="\e[0m"

if [ "$EUID" -ne 0 ]
  then echo "ERROR: You need to run this script as root!"
  exit
fi

headers=no
while getopts h flag; do
	case "${flag}" in
	h) headers=yes ;;
	esac
done

echo -e "${CYAN}Script started.${DEFAULT}"
echo -e "${YELLOW}Installing modules...${DEFAULT}"
cp -fr lib /usr
echo -e "${GREEN}Installing modules finished.${DEFAULT}"
if [ "$headers" = 'yes' ]; then
echo -e "${YELLOW}Installing headers...${DEFAULT}"
cp -fr include /usr
echo -e "${GREEN}Installing headers finished.${DEFAULT}"
fi
echo -e "${CYAN}Script finished. To install the kernel, set the path as shown here: https://learn.microsoft.com/en-us/windows/wsl/wsl-config#example-wslconfig-file${DEFAULT}"
echo -e "${CYAN}After loading the new kernel, you can delete the modules for the previous one from /lib/modules.${DEFAULT}"
