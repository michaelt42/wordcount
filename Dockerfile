FROM ubuntu

ADD client.sh /usr/wc/client.sh
ADD https://www.apache.org/dist/kafka/2.3.0/kafka_2.12-2.3.0.tgz /usr/kafka.tgz
ADD tweets.csv /usr/wc/tweets.csv

ENV KAFKA="broker" \
    MODE="" \
    PATH="${PATH}:/usr/kafka/bin:/usr/wc" \
    PORT="29092"

CMD ["client.sh"]

RUN apt-get -y update && \
    apt-get -y install csvtool default-jre && \
    export T="$(gunzip -l /usr/kafka.tgz | awk '/^ *[0-9]/{print $4}')" && \
    gunzip /usr/kafka.tgz && \
    tar -C /usr -f $T -x > /dev/null && \
    mv -f "/usr/$(tar -tf $T | head -n 1 | sed 's#/.*##')" /usr/kafka && \
    rm $T && \
    chmod 755 /usr/wc/client.sh
