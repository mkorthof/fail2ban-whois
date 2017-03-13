# fail2ban-whois
## whois all banned ip's in fail2ban jails

Does a <code>fail2ban-client status</code> to get Banned IP List and runs whois and outputs "abuse contact", "country", "inetnum" etc.

<pre>
./fail2ban-whois.sh [-h] help
                    [-s] output short listing (default)
                    [-l] output long listing
</pre>
