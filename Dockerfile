FROM nvidia/cuda:11.7.0-cudnn8-devel-rockylinux8


RUN dnf install epel-release -y

RUN dnf groupinstall "Development Tools" -y
RUN dnf install htop vim tmux git nano wget zsh p7zip p7zip-plugins -y

COPY .zshrc /root/

WORKDIR /workspace/
#download hashcat
RUN wget https://hashcat.net/files/hashcat-6.2.6.tar.gz
RUN tar xvf hashcat-6.2.6.tar.gz
RUN rm hashcat-6.2.6.tar.gz
# download hashcat-utils
RUN git clone https://github.com/hashcat/hashcat-utils

WORKDIR /workspace/hashcat-6.2.6/
RUN make
RUN make install

WORKDIR /workspace/hashcat-utils/src
RUN make all
RUN mv *.bin ../bin
RUN cp -a *.pl ../bin

WORKDIR /workspace/wordlists
COPY *.txt /workspace/wordlists/
COPY *.found /workspace/wordlists/
COPY *.rules /workspace/wordlists/

WORKDIR /workspace
ENTRYPOINT [ "/usr/bin/zsh" ]
