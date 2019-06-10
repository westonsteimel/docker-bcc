# Usage:
# docker run --rm -it \
#	--privileged \
#	-v /lib/modules:/lib/modules:ro \
#	-v /usr/src:/usr/src:ro \
#	-v /etc/localtime:/etc/localtime:ro \
#	r.j3ss.co/bcc-tools
#
FROM alpine

ENV PATH /usr/share/bcc/tools:$PATH

RUN apk update && apk --no-cache add \
    ca-certificates \
	clang \
	curl \
	git \
    build-base \
    bash

# Install dependencies for libbcc
# FROM: https://github.com/iovisor/bcc/blob/master/INSTALL.md#install-build-dependencies
RUN apk update && apk --no-cache add \
	cmake \
	linux-headers \
    llvm5-dev \
    llvm5-libs \
	clang-dev \
    clang-libs \
    clang-static \
	libelf-dev \
	bison \
	flex \
	libedit-dev \
	python3 \
	luajit-dev \
	arping \
	iperf3 \
	ethtool \
    llvm5-static \
    zlib-dev

# Build libbcc
ENV BCC_VERSION v0.10.0
RUN git clone --depth 1 --branch "$BCC_VERSION" https://github.com/iovisor/bcc.git /usr/src/bcc \
	&& ( \
		cd /usr/src/bcc \
		&& mkdir build \
		&& cd build \
		&& cmake .. -DCMAKE_INSTALL_PREFIX=/usr \
		&& make \
		&& make install \
	) \
	&& rm -rf /usr/src/bcc

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]
