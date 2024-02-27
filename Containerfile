FROM registry.fedoraproject.org/fedora:39

RUN dnf install --assumeyes gcc git automake autoconf python

ARG GIT_HASH="xxxxxxxx"

COPY build.sh /
RUN bash -x build.sh
RUN ./tmux -V

RUN echo $GIT_HASH > tmux_static_builder_version

