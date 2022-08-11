FROM registry.fedoraproject.org/fedora:36

RUN dnf install --assumeyes gcc git automake autoconf python

ENV GIST_URL https://gist.githubusercontent.com/zenofile/d2acef1a0423e5081e74162cd5a0ae2d/raw/5e2454e597e774316dc32d65784475cdf60a9d55/build.sh

RUN curl -sSL $GIST_URL -o - | bash -x
RUN ./tmux -V

