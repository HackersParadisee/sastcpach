
# **sastcpach**

### **Overview**
sastcpach is a bash-based brute-forcing tool designed to automate attacks using Hydra and CrackMapExec. It supports a wide range of services, such as SSH, HTTP, SMB, RDP, SQL, and more. sastcpach offers an interactive interface, colorful design, and easy wordlist management for brute-forcing usernames and passwords.

### **Features**
- Brute-force attacks for various services: SSH, HTTP/HTTPS, SMB, RDP, SQL, and custom ports.
- Integration with Hydra and CrackMapExec for username and password brute-forcing and pass-the-hash attacks.
- Interactive selection of wordlists for both usernames and passwords from preloaded Kali Linux wordlists or user-defined paths.
- Real-time attack output displayed in the terminal, with the option to save results to a file.
- Colorful and user-friendly interface.

### **Contributors**
- **Yash Pawar** - yashpawar1199@gmail.com
- **Siddhanth Gaikwad** - siddhanthgaikwad7@gmail.com
- **Om Navale** - omnavale930@gmail.com

### **Requirements**
- **Kali Linux** or a Linux environment with the following tools installed:
  - **Hydra**: A fast and flexible login cracker.
  - **CrackMapExec**: A Swiss army knife for pentesting Windows/Active Directory environments.

To install Hydra and CrackMapExec on Kali Linux:
```bash
sudo apt update
sudo apt install hydra crackmapexec
```

### **Installation**
1. Clone the sastcpach repository:
   ```bash
   git clone https://github.com/HackersParadise/fastcracksastcpach.sh
   cd sastcpach
   ```
2. Make the `sastcpach.sh` script executable:
   ```bash
   chmod +x aastcpach.sh
   ```

### **Usage**
Run the tool by executing the script:
```bash
./sastcpach.sh
```

### **Main Menu**
Upon starting, the user can select from the following options:
1. **Brute-force using Hydra** - Attack supported services like SSH, HTTP, SMB, etc.
2. **Pass-the-hash attack using CrackMapExec** - Perform a pass-the-hash attack on SMB services.
3. **Exit** - Quit the tool.

### **Wordlist Management**
sastcpach lists all available wordlists from `/usr/share/wordlists`. You can select wordlists for both usernames and passwords interactively or provide a custom path to your own wordlist.

### **Supported Services**
- **SSH** (port 22)
- **FTP** (port 21)
- **HTTP/HTTPS** (port 80/443)
- **SMB** (port 445)
- **RDP** (port 3389)
- **SQL** (default: MySQL on port 3306)
- **Custom Ports**

### **Saving Results**
After performing an attack, FastCrack provides the option to save the results to a file for later review.

### **Disclaimer**
sastcp is intended for educational purposes only. Do not use this tool on systems you do not have explicit permission to test.
