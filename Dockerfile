FROM openjdk:8u282-jre-buster@sha256:b7d3c3cd5b000cefc7843f245e76e317d459b360fcce29d84393e48897934a40

LABEL maintainer=support@securelyshare.com

ARG KAFKA_VERSION_ARG=2.5.1
ARG KAFKA_HOME_ARG=/opt/kafka
ARG CHECKSUM="91f96f28c016bdaa3fe025f87ace188417a1e594c8e32b7d23a104aa390bc25f5db5897e23cccf00ea7ede3ac20b3028c10363ebe99dcbd7db2cf6237ee7553a"
ARG SCALA_VERSION=2.12

ENV KAFKA_VERSION=${KAFKA_VERSION_ARG} \
    KAFKA_HOME=${KAFKA_HOME_ARG}

RUN wget --no-check-certificate -nv --show-progress --progress=bar:force:noscroll \
        -O /tmp/kafka.tgz https://archive.apache.org/dist/kafka/${KAFKA_VERSION}/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
    && echo "${CHECKSUM} /tmp/kafka.tgz" | sha512sum -c - \
    && mkdir -p ${KAFKA_HOME} \
    && tar -xzf /tmp/kafka.tgz -C ${KAFKA_HOME} --strip-components 1 \
    && rm -f /tmp/kafka.tgz \
    && rm -rf /var/lib/apt/lists/*

CMD ["${KAFKA_HOME}/bin/kafka-server-start.sh", "${KAFKA_HOME}/config/server.properties"]
