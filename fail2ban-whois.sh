#!/bin/bash

# 20170313 MK fail2ban-whois
# whois all banned ip's in fail2ban jails

if [ $( id -u ) -ne 0 ]; then echo "$0 needs root to run"; exit 1; fi

BOLD=$( tput bold )
SGR0=$( tput sgr0 )
SMUL=$( tput smul )
RMUL=$( tput rmul )

LIST=0
if [ $( echo $* | grep '\-h' ) ]; then echo -e "\n$0 [-h] help\n$0 [-s] output short listing (default)\n$0 [-l] output long listing\n"; exit 0; fi
if [ $( echo $* | grep '\-s' ) ]; then LIST=0; fi
if [ $( echo $* | grep '\-l' ) ]; then LIST=1; fi
for j in $( fail2ban-client status | grep "Jail list:" | cut -f 3- | sed 's/,//g' ); do 
  for ip in $( fail2ban-client status $j | grep "IP list:" ); do
    if [ "$( echo $ip | grep -E [0-9a-fA-F\.:]{4} )" ]; then
      echo -e "[JAIL] $j [IP] ${BOLD}$ip${SGR0} [WHOIS]\n$( whois $ip | \
        sed '0,/descr:/{s/descr:/descr_1:/}' | \
        grep -E '^((% Abuse contact for|abuse-mailbox:)|(inetnum:|CIDR:|IPv4 Address)|([nN]et[nN]ame:|Service Name|ownerid:)|([cC]ountry:|# KOREAN\(UTF8\))|(descr_1:|Organization Name|owner:))' | \
        sed -e 's/^ *//g' -e 's/  */ /g' | sed -e 's/ - /-/g' \
            -e 's/% Abuse contact for.*is '\''\(.*\)'\''/abuse-c: \1/g' -e "s/\(abuse-c:\|abuse-mailbox:\)/${SMUL}abuse:${RMUL}/g" \
            -e "s/\(inetnum:\|CIDR:\|IPv4 Address :\)/${SMUL}inetnum:${RMUL}/g" -e "s/\([nN]et[nN]ame:\|Service Name :\|ownerid:\)/${SMUL}netname:${RMUL}/g" \
            -e "s/# KOREAN(UTF8)/${SMUL}country:${RMUL} ${BOLD}KR${SGR0}/" -e "s/[cC]ountry: \([a-zA-Z][a-zA-Z]\)\(.*\)/${SMUL}country:${RMUL} ${BOLD}\1${SGR0}\2/g" \
            -e "s/\(Organization Name :\|owner:\)/${SMUL}descr:${RMUL}/g" | \
        sort -f | uniq -i | sed "s/descr_1:/${SMUL}descr:${RMUL}/g"
      )" | ( [ $LIST -eq 0 ] && sed ':a;N;$!ba;s/\n/ /g' || cat )
    fi
  done
done
