ARG UBUNTU_VERSION=22.04
FROM ubuntu:${UBUNTU_VERSION} AS linux_base

WORKDIR /build

RUN apt-get update -y && apt-get install -y \
        git \
        moreutils \
    && apt-get clean

RUN git clone https://github.com/prometheus-community/node-exporter-textfile-collector-scripts.git

WORKDIR /app

RUN cp /build/node-exporter-textfile-collector-scripts/fstab-check.sh .

RUN mkdir output

#CMD ["sh node-exporter-textfile-collector-scripts/fstab-check.sh | sponge /app/output"]
#CMD ["sh", "node-exporter-textfile-collector-scripts/fstab-check.sh", "|", "sponge", "output/output.prom"]
CMD ["sleep", "10000"]
