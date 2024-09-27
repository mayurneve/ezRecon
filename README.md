# ezRecon

AutoReconTool is a Bash-based automated reconnaissance tool that gathers information about domains, performs subdomain enumeration, DNS analysis, port scanning, email enumeration, and more.

## Features:
- Domain WHOIS Information
- DNS Record Enumeration
- Subdomain Enumeration (Sublist3r)
- Port Scanning (Nmap)
- Web Technology Detection (WhatWeb)
- SSL/TLS Information (sslscan)
- Email/Username Enumeration (theHarvester)
- Google Dorking

![image](https://github.com/user-attachments/assets/e1dd4110-d185-4ba1-b429-4a1a26020c93)

## Requirements:

#- install the requirements with root privileges !

- **Nmap**: `sudo apt install nmap`
- **Whois**: `sudo apt install whois`
- **DNS Utilities**: `sudo apt install dnsutils`
- **WhatWeb**: `sudo apt install whatweb`
- **sslscan**: `sudo apt install sslscan`
- **Sublist3r**: `pip3 install sublist3r`
- **theHarvester**: `pip3 install theHarvester`


## Installation:
1. Clone this repository:
   ```bash
   git clone https://github.com/mayurneve/ezRecon.git
2. Navigate into the tool directory
   `cd ezRecon`
3. Make the script executable
   `chmod +x ezRecon.sh`
4. Run the script
   `./ezRecon.sh <target-domain>`

   - Example :   ./ezRecon.sh instagram.com

#Output:

The script outputs all results to a recon_results directory, which contains:

- whois.txt: Domain WHOIS information
- dns_records.txt: DNS records
- subdomains.txt: Enumerated subdomains
- nmap_scan.txt: Nmap port scan results
- web_tech.txt: Web technologies detected
- ssl_info.txt: SSL/TLS scan results
- harvester_results.txt: Email/user enumeration
- google_dorking.txt: Google Dorking URLs
