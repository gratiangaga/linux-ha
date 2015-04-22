Linux - High Availability (Routing technique)
---------------------------------------------

HA for optenet1/optenet2 and squid1/squid2

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
