FROM nvidia/cuda:11.7.0-cudnn8-devel-rockylinux8
# using the nvidia image because it's pre baked. sorry people with slow internet

# thank god for fedora packagers. shoutout to them. 
RUN dnf install epel-release -y

# C development tools. this definitely pulls in way too much stuff. it's not as small as the fedora C Dev Tools group but i don't know what to use instead
RUN dnf groupinstall "Development Tools" -y

# various tools and helpful dingles
RUN dnf install htop vim tmux nano wget zsh p7zip p7zip-plugins openssl-devel -y

# install rust
RUN curl https://sh.rustup.rs -sSf | sh -s -- --profile minimal --default-toolchain beta -y

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
RUN make -j2
RUN make install

# build hashcat-utils
WORKDIR /workspace/hashcat-utils/src
RUN make -j2 all 
RUN mv *.bin ../bin
RUN cp -a *.pl ../bin

# build john
WORKDIR /workspace/john/src
RUN ./configure
RUN make -j2
RUN make install 

# install lsdeluxe
RUN /root/.cargo/bin/cargo install lsd

# install python and ipython using a modern version because rocky's version is like 3.6 by default. if only the module system made sense.
RUN dnf module install python39 -y
RUN alternatives --set python /usr/bin/python3.9
RUN pip3.9 install ipython

# install openssh server
RUN dnf install openssh-server iproute util-linux-user passwd -y
RUN ssh-keygen -A
RUN rm /run/nologin
RUN echo "root:cracktheplanet" | chpasswd

# grab mdxfind
WORKDIR /workspace/bin/
RUN wget https://www.techsolvency.com/pub/bin/mdxfind/mdxfind.static
RUN mv mdxfind.static mdxfind
RUN chmod +x mdxfind

# grab the python3 fork of PACK
WORKDIR /workspace/pack/
run git clone https://github.com/Hydraze/pack

# copy in wordlists
WORKDIR /workspace/wordlists
COPY *.txt /workspace/wordlists/
COPY *.found /workspace/wordlists/
COPY *.rules /workspace/wordlists/

COPY ./challenges/ /workspace/challenges/

EXPOSE 22
RUN chsh -s /usr/bin/zsh
# reset us back into the workspace dir. I'm assuming this is where people will be working so they have easy access to tools.
# maybe we should use a different dir?
WORKDIR /workspace
ENTRYPOINT [ "/usr/bin/zsh" ]
