FROM alpine:edge

RUN apk update && apk --no-cache add \
    bcc

