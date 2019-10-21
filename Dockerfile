FROM alpine:edge

RUN apk update && apk --no-cache add \
    bcc-tools \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip

