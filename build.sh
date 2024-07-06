#!/bin/bash
GREEN="\e[92m"
YELLOW="\e[93m"
CYAN="\e[96m"
DEFAULT="\e[0m"

JOBS=$(nproc --all)
CURDIR=$(pwd)

echo -e "${CYAN}Script started.${DEFAULT}"
echo -e "${YELLOW}Cleaning...${DEFAULT}"
rm -rf dist out *.tar.gz
make mrproper && make O=out mrproper
echo -e "${GREEN}Cleaning finished.${DEFAULT}"

echo -e "${YELLOW}Building kernel...${DEFAULT}"
make O=out KCONFIG_CONFIG=arch/x86/configs/config-wsl -j${JOBS}
mkdir dist
cp out/arch/x86/boot/bzImage dist/bzImage
echo -e "${GREEN}Building kernel finished.${DEFAULT}"

echo -e "${YELLOW}Installing modules and headers...${DEFAULT}"
make O=out INSTALL_MOD_PATH=${CURDIR}/dist INSTALL_HDR_PATH=${CURDIR}/dist modules_install headers_install
echo -e "${GREEN}Installing modules and headers finished.${DEFAULT}"

CURDATE=$(date +%Y%m%d-%H%M%S)

echo -e "${YELLOW}Creating archive...${DEFAULT}"
cp install.sh dist/install.sh
tar -czf Kiki-WSL2-${CURDATE}.tar.gz -C dist .
rm -rf out dist
echo -e "${GREEN}Creating archive finished.${DEFAULT}"
echo -e "${CYAN}Script finished.${DEFAULT}"
