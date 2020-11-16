FROM alpine:3.8

# Build stress from source.
RUN \
    apk add --no-cache gzip tar g++ make curl && \
    curl https://src.fedoraproject.org/repo/pkgs/stress/stress-1.0.4.tar.gz/a607afa695a511765b40993a64c6e2f4/stress-1.0.4.tar.gz | tar xz && \
    cd stress-1.0.4 && \
    ./configure && make && make install && \
    apk del --purge gzip tar g++ make curl && rm -rf stress-*

ADD kube-stresscheck /usr/bin/kube-stresscheck
ENTRYPOINT ["/usr/bin/kube-stresscheck"]
