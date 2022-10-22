FROM containerssh/agent AS agent

FROM nvidia/cuda:11.8.0-runtime-rockylinux8
COPY --from=agent /usr/bin/containerssh-agent /usr/bin/containerssh-agent

WORKDIR /app

RUN dnf install epel-release -y

RUN dnf groupinstall "Development Tools" -y
RUN dnf install htop vim tmux git nano wget zsh -y

RUN wget -O .zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

RUN wget https://hashcat.net/files/hashcat-6.2.6.tar.gz
RUN tar xvf hashcat-6.2.6.tar.gz

WORKDIR /app/hashcat-6.2.6/
RUN make
RUN make install

ENTRYPOINT [ "/usr/bin/zsh" ]