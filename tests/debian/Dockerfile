FROM debian:13

RUN apt-get update && apt-get install -y sudo \
 && useradd -m -s /bin/bash tester \
 && echo "tester ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/tester

USER tester

WORKDIR /home/tester

COPY --from=dotfiles --chown=tester ./install-all-debian.sh ./install.sh
COPY --from=dotfiles ./.bashrc .
COPY --from=dotfiles ./.vimrc .

RUN chmod +x ./install.sh

