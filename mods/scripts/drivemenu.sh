#!/bin/bash

# ANSI color codes
RED="\033[0;31m"
GREEN="\033[0;32m"
BLUE="\033[0;34m"
NC="\033[0m" # No color

# Function to check if MergerFS is installed
check_mergerfs_status() {
    if command -v mergerfs &> /dev/null; then
        MERGERFS_STATUS="${GREEN}Installed${NC}"
        MERGERFS_INSTALLED=true
    else
        MERGERFS_STATUS="${RED}Not Installed${NC}"
        MERGERFS_INSTALLED=false
    fi
}

# Function to install MergerFS
install_mergerfs() {
    clear
    local install_code=$(printf "%04d" $((RANDOM % 10000)))  # Generate a 4-digit code
    while true; do
        read -p "$(echo -e "To install MergerFS, type [${GREEN}${install_code}${NC}] to proceed or [${RED}exit${NC}] to cancel: ")" input_code
        if [[ "$input_code" == "$install_code" ]]; then
            echo "Installing MergerFS..."
            sudo apt-get update && sudo apt-get install -y mergerfs
            break
        elif [[ "${input_code,,}" == "exit" ]]; then
            echo "Operation cancelled."
            return
        else
            echo -e "${RED}Invalid response.${NC} Please type [${GREEN}${install_code}${NC}] or [${RED}exit${NC}]."
        fi
    done
}

# Function to uninstall MergerFS
uninstall_mergerfs() {
    clear
    if $MERGERFS_INSTALLED; then
        local uninstall_code=$(printf "%04d" $((RANDOM % 10000)))  # Generate a 4-digit code
        while true; do
            read -p "$(echo -e "To uninstall MergerFS, type [${GREEN}${uninstall_code}${NC}] to proceed or [${RED}exit${NC}] to cancel: ")" input_code
            if [[ "$input_code" == "$uninstall_code" ]]; then
                echo "Uninstalling MergerFS..."
                sudo apt-get remove -y mergerfs
                break
            elif [[ "${input_code,,}" == "exit" ]]; then
                echo "Operation cancelled."
                return
            else
                echo -e "${RED}Invalid response.${NC} Please type [${GREEN}${uninstall_code}${NC}] or [${RED}exit${NC}]."
            fi
        done
    else
        echo -e "${RED}Cannot uninstall since MergerFS is not installed.${NC}"
        read -p "Press Enter to return to the menu..."
    fi
}

# Function for the main menu
main_menu() {
  while true; do
    clear
    check_mergerfs_status
    echo -e "${BLUE}PG: Drive Management${NC} - MergerFS Status: $MERGERFS_STATUS"
    echo ""  # Space for separation
    echo "V) View Drives"
    echo "M) Manage Drives"
    echo "A) Add a Drive"
    echo "F) Format a Drive"
    echo "I) Install MergerFS"
    echo "U) Uninstall MergerFS"
    echo "Z) Exit"
    echo ""  # Space between options and input prompt

    # Prompt the user for input
    read -p "Enter your choice [V/M/A/F/I/U/Z]: " choice

    case ${choice,,} in  # Convert input to lowercase for v/V, m/M, a/A, f/F, i/I, u/U, z/Z handling
      v)
        /pg/scripts/hd_detection.sh
        ;;
      m|a|f)
        if $MERGERFS_INSTALLED; then
            echo "Executing option..."
            # Implement your Manage/Add/Format drive functionality here
        else
            echo -e "${RED}MergerFS is not installed. Install MergerFS before proceeding.${NC}"
            read -p "Press Enter to return to the menu..."
        fi
        ;;
      i)
        install_mergerfs
        ;;
      u)
        uninstall_mergerfs
        ;;
      z)
        exit 0
        ;;
      *)
        echo "Invalid option, please try again."
        read -p "Press Enter to continue..."
        ;;
    esac

  done
}

# Call the main menu function
main_menu
