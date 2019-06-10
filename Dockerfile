FROM alpine:edge

RUN apk update && apk --no-cache add \
    --repository http://dl-3.alpinelinux.org/alpine/edge/testing/ \
    bcc

