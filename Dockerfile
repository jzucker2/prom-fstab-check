#ARG UBUNTU_VERSION=22.04
#FROM ubuntu:${UBUNTU_VERSION} AS linux_base
FROM alpine:3.17 AS linux_base

WORKDIR /build

RUN set -x \
    && apk update  \
    && apk add --no-cache  \
      bash \
      supercronic  \
      shadow \
      git \
      moreutils \
    && useradd -m app
#USER app


RUN git clone https://github.com/prometheus-community/node-exporter-textfile-collector-scripts.git

WORKDIR /app

RUN cp /build/node-exporter-textfile-collector-scripts/fstab-check.sh .

RUN mkdir output

COPY run_fstab_check.sh .
RUN chmod +x run_fstab_check.sh

COPY crontab .

CMD ["supercronic", "/app/crontab"]

#WORKDIR /build
#
#RUN apt-get update -y && apt-get install -y \
#        git \
#        moreutils \
#        cron \
#    && apt-get clean
#
#RUN git clone https://github.com/prometheus-community/node-exporter-textfile-collector-scripts.git
#
#WORKDIR /app
#
#RUN cp /build/node-exporter-textfile-collector-scripts/fstab-check.sh .
#
#COPY run_fstab_check.sh .
#RUN chmod 0644 run_fstab_check.sh
#
#RUN mkdir output
#
##CMD ["sh node-exporter-textfile-collector-scripts/fstab-check.sh | sponge /app/output"]
##CMD ["sh", "node-exporter-textfile-collector-scripts/fstab-check.sh", "|", "sponge", "output/output.prom"]
##CMD ["sleep", "10000"]
#COPY crontab /etc/cron.d/cron-job
#RUN chmod 0644 /etc/cron.d/cron-job
#RUN crontab /etc/cron.d/cron-job
#RUN touch /var/log/cron.log
#CMD cron -f && tail -f /var/log/cron.log
