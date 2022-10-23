FROM nvidia/cuda:11.7.0-cudnn8-devel-rockylinux8
# using the nvidia image because it's pre baked. sorry people with slow internet

RUN dnf install epel-release -y

RUN dnf groupinstall "Development Tools" -y
RUN dnf install htop vim tmux nano wget zsh p7zip p7zip-plugins openssl-devel rust cargo -y

# grml-zsh-config
COPY .zshrc /root/

WORKDIR /workspace/
# download hashcat
RUN wget https://hashcat.net/files/hashcat-6.2.6.tar.gz
RUN tar xvf hashcat-6.2.6.tar.gz
RUN rm hashcat-6.2.6.tar.gz
# download hashcat-utils
RUN git clone https://github.com/hashcat/hashcat-utils
# download jumbo john
RUN git clone https://github.com/openwall/john

# build hashcat
WORKDIR /workspace/hashcat-6.2.6/
RUN make -j20
RUN make install

# build hashcat-utils
WORKDIR /workspace/hashcat-utils/src
RUN make -j20 all 
RUN mv *.bin ../bin
RUN cp -a *.pl ../bin

# copy in wordlists
WORKDIR /workspace/wordlists
COPY *.txt /workspace/wordlists/
COPY *.found /workspace/wordlists/
COPY *.rules /workspace/wordlists/

# build john
WORKDIR /workspace/john/src
RUN ./configure
RUN make -j20 
RUN make install 

# install lsdeluxe
RUN cargo install lsd

# reset us back into the workspace dir. I'm assuming this is where people will be working so they have easy access to tools.
# maybe we should use a different dir?
WORKDIR /workspace
ENTRYPOINT [ "/usr/bin/zsh" ]
