# Saintcon Password Cracking: Docker Workspace

This is a docker image that provides a ready to use password cracking experience with a good shell, wordlists, and other tools.

## Prerequisites

You will need a linux host (maybe WSL2?? If it works for you, let us know!) with the nvidia-cuda libraries, a recent NVIDIA driver, and nvidia-container-runtime.

## Tools included:

- nvidia cuda libraries for hashcat (your host will need `nvidia-container-runtime`)
- zsh and grml-zsh-config (because i like it better ok)
- hashcat (can't really crack passwords without it, can we)
- wordlists (add these yourselves, just drop some .txt files in this directory. a script is provided to download some with no guarantees of it working)
- hashcat-utils
- micro editor (like nano i guess?)
- john the ripper (jumbo edition)


## Tools soon to be included:
- PACK
- cewl
- mdxfind
- better zsh prompt maybe?
- mcfly (for better CTRL-R)
- python and ipython
- veracrypt
- openSSH server

## How to use this container
- download your wordlists, rules, and txt files into the same directory as this readme.

- `docker compose build`

- `docker compose run workspace`