# fail2ban-whois
### Whois all banned IP's in fail2ban Jails

Does a <code>fail2ban-client status</code> to get Banned IP List and runs whois and outputs "abuse contact", "country", "inetnum" etc.

<pre>
./fail2ban-whois.sh [-h] help
                    [-s] output short listing (default)
                    [-l] output long listing
</pre>

### Example

```# ./fail2ban-whois.sh```

[JAIL] ssh [IP] **123.123.123.123** [WHOIS] _abuse:_ abuse@mail.cn _country:_ **CN** _inetnum:_ 123.123.0.0-123.123.255.255 _netname:_ EXAMPLENET _descr:_ Example network
