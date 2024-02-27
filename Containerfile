FROM registry.fedoraproject.org/fedora:39

RUN dnf install --assumeyes gcc git automake autoconf python

ARG GIT_HASH="xxxxxxxx"
LABEL tmux_static_builder_version=${GIT_HASH}
ENV   tmux_static_builder_version=${GIT_HASH}

COPY build.sh /
RUN bash -x build.sh
RUN ./tmux -V


