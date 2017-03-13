# fail2ban-whois
### Whois all banned IP's in fail2ban Jails

Does a <code>fail2ban-client status</code> to get Banned IP List and runs whois and outputs "abuse contact", "country", "inetnum" etc.

<pre>
./fail2ban-whois.sh [-h] help
                    [-s] output short listing (default)
                    [-l] output long listing
</pre>

### Example

<pre>
# ./fail2ban-whois.sh
[JAIL] ssh [IP] <b>123.123.123.123</b> [WHOIS] abuse: abuse@mail.cn country: <b>CN</b> inetnum: 123.123.0.0-123.123.255.255 netname: EXAMPLENET descr: Example network
</pre>
