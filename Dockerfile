FROM containerssh/agent AS agent

FROM fedora:latest
COPY --from=agent /usr/bin/containerssh-agent /usr/bin/containerssh-agent

WORKDIR /app

RUN dnf groupinstall "C Development Tools and Libraries" -y
RUN dnf install htop vim tmux git nano wget zsh -y

RUN wget -O .zshrc https://git.grml.org/f/grml-etc-core/etc/zsh/zshrc

RUN wget https://hashcat.net/files/hashcat-6.2.6.tar.gz
RUN tar xvf hashcat-6.2.6.tar.gz

WORKDIR /app/hashcat-6.2.6/
RUN make
RUN make install

ENTRYPOINT [ "/usr/bin/zsh" ]