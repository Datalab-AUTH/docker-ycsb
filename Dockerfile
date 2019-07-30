FROM maven:3.6.1-jdk-8-slim
MAINTAINER engops@bluemedora.com

ENV YCSB_VERSION=0.17.0-SNAPSHOT \
    PATH=${PATH}:/usr/bin

RUN apt-get update; \
    apt-get install -y --no-install-recommends \
    python mksh \
    && cd /opt \
    && eval curl "-Ls https://github.com/BlueMedoraPublic/YCSB/archive/${YCSB_VERSION}.tar.gz" \
    | tar -xzvf -

COPY start.sh /start.sh
RUN chmod +x /start.sh

ENV ACTION='' DBTYPE='' WORKLETTER='' DBARGS='' RECNUM='' OPNUM=''

WORKDIR "/opt/YCSB-${YCSB_VERSION}"

ENTRYPOINT ["/start.sh"]
