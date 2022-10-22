# Saintcon Password Cracking: Docker Workspace

This is a docker image that provides a ready to use password cracking experience with a good shell, wordlists, and other tools.

Tools included:
===============
- nvidia drivers (your host will need `nvidia-container-runtime`)
- zsh and grml-zsh-config (because i like it better ok)
- hashcat (can't really crack passwords without it, can we)
- wordlists (add these yourselves, just drop some .txt files in this directory. a script is provided to download some with no guarantees of it working)
- hashcat-utils

Tools soon to be included:
===============
- john the ripper (jumbo edition)
- PACK
- cewl
- mdxfind

## How to use this container
- download your wordlists, rules, and txt files

- `docker compose build`

- `docker compose run workspace`