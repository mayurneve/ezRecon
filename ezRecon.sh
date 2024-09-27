#!/bin/bash

# Automated Reconnaissance Tool

# Ensure required tools are installed
function check_tools() {
    tools=("whois" "dig" "nmap" "whatweb" "sslscan" "sublist3r" "theharvester")
    for tool in "${tools[@]}"; do
        if ! command -v $tool &> /dev/null; then
            echo "Error: $tool is not installed. Install it before running the script."
            exit 1
        fi
    done
}

# Domain Information (Whois)
function domain_info() {
    echo "[+] Gathering Whois Information for $1"
    whois $1 > recon_results/whois.txt
}

# DNS Records Information (A, MX, NS, etc.)
function dns_info() {
    echo "[+] Gathering DNS Records for $1"
    dig $1 +noall +answer > recon_results/dns_records.txt
}

# Subdomain Enumeration (Sublist3r)
function subdomain_enum() {
    echo "[+] Enumerating Subdomains for $1"
    python3 sublist3r.py -d $1 -o recon_results/subdomains.txt
}

# Subdomain Enumeration (Sublist3r)
function subdomain_enum() {
    echo "[+] Enumerating Subdomains for $1"
    sublist3r -d $1 -o recon_results/subdomains.txt
}
# Port Scanning (Nmap)
function port_scan() {
    echo "[+] Performing Port Scan for $1"
    nmap -A -sV -p- $1 > recon_results/nmap_scan.txt
}

# Web Technology Detection (WhatWeb)
function web_tech() {
    echo "[+] Detecting Web Technologies on $1"
    whatweb $1 > recon_results/web_tech.txt
}

# SSL/TLS Information (sslscan)
function ssl_info() {
    echo "[+] Gathering SSL/TLS Information for $1"
    sslscan $1 > recon_results/ssl_info.txt
}

# Harvest Email/Username Enumeration (theHarvester)
function email_enum() {
    echo "[+] Enumerating Emails and Usernames for $1"
    theHarvester -d $1 -l 500 -b all > recon_results/harvester_results.txt
}


# Google Dorking Example
function google_dorking() {
    echo "[+] Performing Google Dorking for $1"
    echo "Results may vary due to Google's CAPTCHA or rate-limiting"
    search_queries=("site:$1 admin" "site:$1 login" "site:$1 inurl:/wp-admin" "site:$1 inurl:/admin")
    for query in "${search_queries[@]}"; do
        echo "Dorking with: $query"
        echo "https://www.google.com/search?q=$query" >> recon_results/google_dorking.txt
    done
}

# Create results directory
function setup_env() {
    mkdir -p recon_results
    echo "Created directory for results: recon_results"
}

# Main Execution Function
function run_recon() {
    target=$1

    # Check if target domain is provided
    if [ -z "$target" ]; then
        echo "Usage: $0 <target-domain>"
        exit 1
    fi

    setup_env
    domain_info $target
    dns_info $target
    subdomain_enum $target
    port_scan $target
    web_tech $target
    ssl_info $target
    email_enum $target
    google_dorking $target

    echo "[+] Reconnaissance Completed. Results saved in the recon_results/ directory."
}

# Check for required tools
check_tools

# Run the reconnaissance with target domain as input
run_recon $1
