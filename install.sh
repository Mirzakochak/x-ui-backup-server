#!/bin/bash

# ---------------------------------------------
# XUI Google Drive Backup Installer by Mr.Ali
# ---------------------------------------------

APP_NAME="XUI Backup System"
DEVELOPER="Mr.Ali"
INSTALL_DIR="/root/gdrive-backup"
SCRIPT_NAME="gdrive_backup.py"
REQUIREMENTS_FILE="requirements.txt"
CRON_JOB="0 3 * * * /usr/bin/python3 $INSTALL_DIR/$SCRIPT_NAME >> /var/log/xui_gdrive_backup.log 2>&1"

# Colors
GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
NC="\033[0m" # No Color

function show_header() {
  clear
  echo -e "${BLUE}==============================="
  echo -e "${GREEN}  $APP_NAME"
  echo -e "  Developed by $DEVELOPER"
  echo -e "${BLUE}===============================${NC}"
}

function install() {
  echo -e "\n${YELLOW}📦 Installing dependencies...${NC}"
  apt update && apt install -y python3 python3-pip cron
  pip3 install --upgrade pip

  echo -e "\n${YELLOW}📁 Creating install directory...${NC}"
  mkdir -p "$INSTALL_DIR"
  cp "$SCRIPT_NAME" "$INSTALL_DIR/"
  cp "$REQUIREMENTS_FILE" "$INSTALL_DIR/"

  echo -e "\n${YELLOW}🐍 Installing Python packages...${NC}"
  pip3 install -r "$INSTALL_DIR/$REQUIREMENTS_FILE"

  echo -e "\n${YELLOW}📄 Checking for credentials.json...${NC}"
  if [ ! -f "$INSTALL_DIR/credentials.json" ]; then
    echo -e "${RED}❌ credentials.json not found in $INSTALL_DIR! Please upload it first.${NC}"
    exit 1
  fi

  echo -e "\n${YELLOW}🚀 Starting authorization process...${NC}"
  python3 "$INSTALL_DIR/$SCRIPT_NAME"

  echo -e "\n${YELLOW}🕒 Setting up daily cron job at 3:00 AM...${NC}"
  (crontab -l 2>/dev/null; echo "$CRON_JOB") | crontab -

  echo -e "\n${GREEN}✅ Installation complete! Your backups will run daily at 3:00 AM.${NC}"
}

function uninstall() {
  echo -e "\n${YELLOW}🧹 Removing backup system...${NC}"
  rm -rf "$INSTALL_DIR"
  crontab -l | grep -v "$SCRIPT_NAME" | crontab -
  echo -e "${GREEN}✅ Uninstalled successfully.${NC}"
}

function main_menu() {
  while true; do
    show_header
    echo -e "${BLUE}1) Install${NC}"
    echo -e "${BLUE}2) Uninstall${NC}"
    echo -e "${BLUE}3) Exit${NC}"
    read -p $'\nChoose an option [1-3]: ' choice
    case $choice in
      1) install;;
      2) uninstall;;
      3) echo -e "${YELLOW}👋 Exiting...${NC}"; exit 0;;
      *) echo -e "${RED}❌ Invalid choice. Try again.${NC}"; sleep 1;;
    esac
  done
}

main_menu
