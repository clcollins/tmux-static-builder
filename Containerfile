FROM registry.fedoraproject.org/fedora:36

RUN dnf install --assumeyes gcc git automake autoconf python

COPY build.sh /
RUN bash -x build.sh
RUN ./tmux -V

