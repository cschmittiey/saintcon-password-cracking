#!/bin/sh

wget -N https://www.hashmob.net/api/v2/downloads/research/official/hashmob.net_2022-10-16.found.7z
wget -N https://www.hashmob.net/api/v2/downloads/research/official/hashmob.net_2022-10-16.user.found.7z
wget -N https://www.hashmob.net/api/v2/downloads/research/official/hashmob.net_2022-10-16.tiny.found.7z
wget -N https://www.hashmob.net/api/v2/downloads/research/wordlists/rockyou.txt
wgen -N https://crackstation.net/files/crackstation-human-only.txt.gz

7z e *.7z
gunzip crackstation-human-only.txt.gz