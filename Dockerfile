FROM nvidia/cuda:11.7.0-cudnn8-devel-rockylinux8

WORKDIR /app

RUN dnf install epel-release -y

RUN dnf groupinstall "Development Tools" -y
RUN dnf install htop vim tmux git nano wget zsh -y

WORKDIR /root
RUN wget -O .zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

WORKDIR /app/
RUN wget https://hashcat.net/files/hashcat-6.2.6.tar.gz
RUN tar xvf hashcat-6.2.6.tar.gz

WORKDIR /app/hashcat-6.2.6/
RUN make
RUN make install

WORKDIR /workspace/wordlists
RUN wget 

ENTRYPOINT [ "/usr/bin/zsh" ]
