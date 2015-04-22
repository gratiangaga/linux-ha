Linux - High Availability (Routing technique)
---------------------------------------------

HA for optenet1/optenet2 and squid1/squid2

Open in RAW to be visible:

vpn1       optenet1    squid1
+---+      +---+      +---+
|   |------|   |------|   |
+---+      +---+      +---+
      \/          \ /
      /\          / \
+---+      +---+      +---+
|   |------|   |------|   |
+---+      +---+      +---+
vpn2       optenet2    squid2


---------------------------------------------

To run the script in a cron, every 5 seconds, add the next lines to the root's crontab file:

$ crontab -e

* * * * * /root/check.sh
* * * * * sleep 5; /root/check.sh
* * * * * sleep 10; /root/check.sh
* * * * * sleep 15; /root/check.sh
* * * * * sleep 20; /root/check.sh
* * * * * sleep 25; /root/check.sh
* * * * * sleep 30; /root/check.sh
* * * * * sleep 35; /root/check.sh
* * * * * sleep 40; /root/check.sh
* * * * * sleep 45; /root/check.sh
* * * * * sleep 50; /root/check.sh
* * * * * sleep 55; /root/check.sh


