FROM maven:3.6.3-jdk-8-slim
MAINTAINER engops@bluemedora.com

ENV YCSB_VERSION=0.17.0 \
    PATH=${PATH}:/usr/bin

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
    python mksh \
    && apt-get clean \
    && cd /opt \
    && eval curl "-Ls https://github.com/BlueMedoraPublic/YCSB/archive/${YCSB_VERSION}.tar.gz" \
    | tar -xzvf -

COPY start.sh sleep.sh /
RUN chmod +x /start.sh /sleep.h

ENV ACTION='' DBTYPE='' WORKLETTER='' DBARGS='' RECNUM='' OPNUM=''

WORKDIR "/opt/YCSB-${YCSB_VERSION}"

ENTRYPOINT ["/sleep.sh"]
