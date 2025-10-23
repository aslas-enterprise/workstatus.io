#!/bin/bash
set -e

# --- Colors ---
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
BOLD="\e[1m"
RESET="\e[0m"

# --- Banner ---
clear
echo -e "\n${BOLD}${BLUE}🚀 Workstatus Uninstaller${RESET}"
echo -e "${BLUE}-------------------------------------------${RESET}"
echo -e "🔧 Uninstallation starting...\n"

# Step 1: Remove Workstatus Package
echo -e "${YELLOW}📦 Step 1: Removing Workstatus package...${RESET}"
if dpkg -l | grep -q "workstatus"; then
    sudo dpkg -r workstatus && echo -e "${GREEN}✅ Workstatus package removed.${RESET}\n"
else
    echo -e "${RED}❌ Workstatus package not found.${RESET}\n"
fi

# Step 2: Clean Up Dependencies
echo -e "${YELLOW}🧹 Step 2: Cleaning up unused dependencies...${RESET}"
sudo apt-get autoremove -y > /dev/null && echo -e "${GREEN}✅ Dependencies cleaned up.${RESET}\n"

# Step 3: Remove Virtual Environment
VENV_PATH="/tmp/venv"
if [ -d "$VENV_PATH" ]; then
    echo -e "${YELLOW}🗑️  Step 3: Removing virtual environment...${RESET}"
    rm -rf "$VENV_PATH" && echo -e "${GREEN}✅ Virtual environment removed.${RESET}\n"
else
    echo -e "${RED}❌ Virtual environment not found.${RESET}\n"
fi

# Step 4: Remove Downloaded Files
OUTPUT_FILE="workstatus_installer.deb"
if [ -f "$OUTPUT_FILE" ]; then
    echo -e "${YELLOW}🗑️  Step 4: Removing downloaded files...${RESET}"
    rm -f "$OUTPUT_FILE" && echo -e "${GREEN}✅ Downloaded files removed.${RESET}\n"
else
    echo -e "${RED}❌ Downloaded file not found.${RESET}\n"
fi

# Step 5: Remove /home/Workstatus Directory
WORKSTATUS_DIR="/home/Workstatus"
if [ -d "$WORKSTATUS_DIR" ]; then
    echo -e "${YELLOW}🗑️  Step 5: Removing /home/Workstatus directory...${RESET}"
    sudo rm -rf "$WORKSTATUS_DIR" && echo -e "${GREEN}✅ /home/Workstatus directory removed.${RESET}\n"
else
    echo -e "${RED}❌ /home/Workstatus directory not found.${RESET}\n"
fi

# Completion Message
echo -e "\n${GREEN}${BOLD}🎉 Uninstallation complete! Workstatus has been removed.${RESET}"
echo -e "${BLUE}---------------------------------------------------------------${RESET}\n"
