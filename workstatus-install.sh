#!/bin/bash
set -e

# ==============================================================
# 🌟 Workstatus Installer - Beautiful CLI Experience
# ==============================================================

# --- Colors ---
GREEN="\e[32m"
RED="\e[31m"
YELLOW="\e[33m"
BLUE="\e[34m"
BOLD="\e[1m"
RESET="\e[0m"

# --- Simple progress spinner ---
spinner() {
    local pid=$!
    local delay=0.1
    local spinstr='|/-\'
    while ps a | awk '{print $1}' | grep -q "$pid"; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# --- Banner ---
clear
echo -e "\n${BOLD}${BLUE}🚀 Workstatus Automated Installer${RESET}"
echo -e "${BLUE}-------------------------------------------${RESET}"
echo -e "🔧 Environment setup starting...\n"

# --- Env setup ---
export DEBIAN_FRONTEND=noninteractive
export TZ=Asia/Karachi

# ==============================================================
# STEP 1: Install Required Packages
# ==============================================================
echo -e "${YELLOW}📦 Step 1: Installing required system packages...${RESET}"
{
    sudo apt-get update -qq && sudo apt-get install -y python3-pip python3-venv python3-pynput curl wget nano file unzip > /dev/null
} & spinner
echo -e "${GREEN}✅ Packages installed successfully.${RESET}\n"

# ==============================================================
# STEP 2: Create Virtual Environment
# ==============================================================
VENV_PATH="/tmp/venv"
if [ ! -d "$VENV_PATH" ]; then
    echo -e "${YELLOW}🧩 Step 2: Creating virtual environment...${RESET}"
    {
        python3 -m venv $VENV_PATH
    } & spinner
    echo -e "${GREEN}✅ Virtual environment created.${RESET}\n"
else
    echo -e "${GREEN}ℹ️ Virtual environment already exists.${RESET}\n"
fi

# Activate venv
source $VENV_PATH/bin/activate

# ==============================================================
# STEP 3: Install Python Packages
# ==============================================================
echo -e "${YELLOW}🐍 Step 3: Installing required Python packages (gdown & pynput)...${RESET}"
{
    pip install --upgrade pip > /dev/null
    pip install -q gdown pynput
} & spinner
echo -e "${GREEN}✅ Python packages installed successfully.${RESET}\n"

# ==============================================================
# STEP 4: Download Workstatus File
# ==============================================================
FILE_ID="1lFy9JDDe54NIL3aqOv8-pS-rg6PcY38n"
OUTPUT_FILE="workstatus_installer.deb"

echo -e "${YELLOW}⬇️  Step 4: Downloading Workstatus .deb file from Google Drive...${RESET}"
{
    python -m gdown --id "$FILE_ID" -O "$OUTPUT_FILE" > /dev/null 2>&1
} & spinner

if [ -f "$OUTPUT_FILE" ]; then
    echo -e "${GREEN}✅ File downloaded successfully:${RESET} ${BOLD}$OUTPUT_FILE${RESET}\n"
else
    echo -e "${RED}❌ Download failed. File not found.${RESET}"
    deactivate 2>/dev/null || true
    exit 1
fi

# ==============================================================
# STEP 5: Install Workstatus (.deb) with PEP 668 Override
# ==============================================================
echo -e "${YELLOW}⚙️  Step 5: Installing Workstatus .deb package...${RESET}"
{
    sudo env PIP_BREAK_SYSTEM_PACKAGES=1 dpkg -i "$OUTPUT_FILE" > /dev/null 2>&1 || sudo apt-get -f install -y > /dev/null
} & spinner
echo -e "${GREEN}✅ Workstatus installed successfully.${RESET}\n"

# ==============================================================
# STEP 6: Create Workstatus Directories and Download Files
# ==============================================================
WORKSTATUS_HOME="/home/$USER/Workstatus"
SCRIPT_FOLDER="$WORKSTATUS_HOME/script"
SNAP_LIBRARY_FOLDER="$WORKSTATUS_HOME/snap_library"

echo -e "${YELLOW}📂 Step 6: Setting up Workstatus directories...${RESET}"
{
    mkdir -p "$SCRIPT_FOLDER"
    mkdir -p "$SNAP_LIBRARY_FOLDER"
} & spinner
echo -e "${GREEN}✅ Directories created:${RESET}"
echo -e "   - $SCRIPT_FOLDER"
echo -e "   - $SNAP_LIBRARY_FOLDER\n"

echo -e "${YELLOW}⬇️  Step 6.1: Downloading Event_logger and Libsnap.zip from GitHub...${RESET}"
{
    wget -q -O "$SCRIPT_FOLDER/event_logger.py" "https://raw.githubusercontent.com/aslas-enterprise/workstatus.io/master/Script/event_logger.py"
    wget -q -O "$SNAP_LIBRARY_FOLDER/libsnap.so" "https://raw.githubusercontent.com/aslas-enterprise/workstatus.io/master/Snap_library/libsnap.so"
} & spinner

if [ -f "$SCRIPT_FOLDER/event_logger.py" ] && [ -f "$SNAP_LIBRARY_FOLDER/libsnap.so" ]; then
    echo -e "${GREEN}✅ Files downloaded and placed successfully:${RESET}"
    echo -e "   - $SCRIPT_FOLDER/event_logger.py"
    echo -e "   - $SNAP_LIBRARY_FOLDER/libsnap.so\n"
else
    echo -e "${RED}❌ File download failed. Please check the URLs.${RESET}"
    deactivate 2>/dev/null || true
    exit 1
fi

# ==============================================================
# STEP 7: Restart Workstatus App
# ==============================================================
echo -e "${YELLOW}🔄 Step 7: Restarting Workstatus app...${RESET}"
{
    pkill -f workstatus || true
    nohup workstatus > /dev/null 2>&1 &
} & spinner
echo -e "${GREEN}✅ Workstatus restarted successfully.${RESET}\n"

# ==============================================================
# DONE
# ==============================================================
echo -e "\n${GREEN}${BOLD}🎉 All done! Workstatus is now installed and ready.${RESET}"
echo -e "💡 Tip: Run ${BOLD}dpkg -l | grep workstatus${RESET} to verify installation."
echo -e "${BLUE}---------------------------------------------------------------${RESET}\n"
