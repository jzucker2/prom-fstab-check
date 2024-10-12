FROM debian AS linux_base

WORKDIR /app

RUN apt-get update -y && apt-get install -y \
        git \
        moreutils \
    && apt-get clean

RUN git clone https://github.com/prometheus-community/node-exporter-textfile-collector-scripts.git

RUN mkdir output

#CMD ["sh node-exporter-textfile-collector-scripts/fstab-check.sh | sponge /app/output"]
CMD ["sh", "node-exporter-textfile-collector-scripts/fstab-check.sh", "|", "sponge", "output"]
