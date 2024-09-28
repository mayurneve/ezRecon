#!/bin/bash

#ezRecon tool

# Automated Reconnaissance Tool
# This tool performs DNS lookup, subdomain enumeration (via subfinder), port scanning, WHOIS lookup, and web server info gathering, SSL/TLS information, email & username information 

# Checking if domain is provided as an argument

if [ -z "$1" ]; then
  echo "Usage: $0 <domain>"
  exit 1
fi

DOMAIN=$1

# Create a directory for saving the results
mkdir -p recon_results_$DOMAIN
cd recon_results_$DOMAIN

# Step 1: WHOIS Lookup
echo "[*] Running WHOIS lookup for $DOMAIN..."
whois $DOMAIN > whois.txt
echo "[*] WHOIS lookup completed and saved to whois.txt"

# Step 2: DNS Lookup
echo "[*] Performing DNS lookup for $DOMAIN..."
dig $DOMAIN +noall +answer > dns.txt
echo "[*] DNS lookup completed and saved to dns.txt"

# Step 3: Subdomain Enumeration using Subfinder
echo "[*] Enumerating subdomains using Subfinder for $DOMAIN..."
subfinder -d $DOMAIN -silent -o subfinder_subdomains.txt
echo "[*] Subdomain enumeration completed and saved to subfinder_subdomains.txt"

# Step 4: Port Scanning using Nmap
echo "[*] Scanning for open ports on $DOMAIN..."
nmap -Pn -sS -T4 $DOMAIN > ports.txt
echo "[*] Nmap port scanning completed and saved to ports.txt"

# Step 5: Web Server Information using curl
echo "[*] Fetching web server headers for $DOMAIN..."
curl -I $DOMAIN > server_headers.txt
echo "[*] Web server headers saved to server_headers.txt"

# Step 6: SSL/TLS Information (sslscan)
echo "[*] Gathering SSL/TLS Information for $DOMAIN..."
sslscan $DOMAIN > ssl_info.txt
echo "[*] SSL/TLS Information saved in ssl_info.txt"

# Step 7: Harvest Email/Username Enumeration (theHarvester)
echo "[*] Enumerating Emails and Usernames for $DOMAIN..."
theHarvester -d $DOMAIN -l 500 -b all > harvester.txt
echo "[*] Emails and Usernames saved in harvester.txt"

# Step 8: Web Technology Finding (Whatweb)
echo "[*] Finding Web Technology for $DOMAIN..."
whatweb $DOMAIN> web_tech.txt
echo "[*] Web Techonolgies saved in web_tech.txt"


# Summary of actions
echo "[*] Reconnaissance completed for $DOMAIN. Results saved in recon_results_$DOMAIN directory."
echo "   - WHOIS information (WHOIS): whois.txt"
echo "   - DNS lookup results (dig): dns.txt"
echo "   - Subdomain enumeration (Subfinder): subfinder_subdomains.txt"
echo "   - Open ports (Nmap scan): ports.txt"
echo "   - Web server headers (cURL): server_headers.txt"
echo "   - SSL/TLS Informations (sslscan): ssl_info.txt"
echo "   - Emails & usernames results (theHarvester): harvester.txt"
echo "	 - Web Technology results (whatweb): web_tech.txt"
