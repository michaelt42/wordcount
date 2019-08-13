#!/bin/bash
if [[ 'consumer' == "${MODE}" ]]
then
    kafka-console-consumer.sh --bootstrap-server "${BROKER}" --topic "${COUNT_TOPIC}"
    exit 0
fi
if [[ 'counter' == "${MODE}" ]]
then
    while true
    do
        raw="$(kafka-console-consumer.sh --bootstrap-server "${BROKER}" --isolation-level read_committed --max-messages 1 --topic "${TWEET_TOPIC}")"
        a="$(echo $raw | csvtool -t ',' col 2 - | sed 's/^"//;s/"$//')"
        c="$(echo $raw | csvtool -t ',' col 6 - | sed 's/\(.*\)/\L\1/;s/[\t !"(),.?]/\n/g' | sed '/^$/d' | sort | uniq -c | sed 's/\n/\\n/g' | sed 's/^"//;s/"$//')"
        l="$(echo $raw | csvtool -t ',' col 8 - | sed 's/^"//;s/"$//')"
        if [[ -z "${l}" ]]
        then
            l="Unknown location"
        fi
        n="$(echo $raw | csvtool -t ',' col 4 - | sed 's/^"//;s/"$//')"
        echo -e "${n} from ${l} on ${a}\n${c}\n" | kafka-console-producer.sh --broker-list "${BROKER}" --topic "${COUNT_TOPIC}"
    done
    exit 0
fi
if [[ 'producer' == "${MODE}" ]]
then
    while true
    do
        shuf -n1 /usr/wc/tweets.csv | kafka-console-producer.sh --broker-list "${BROKER}" --topic "${TWEET_TOPIC}"
        sleep $RODUCER_INTERVAL
    done
    exit 0
fi

echo "Environment Variables"
echo
echo "BROKER=<Kafka Broker> (broker:29092)"
echo "COUNT_TOPIC=<Topic Name> (wc-counts)"
echo "MODE=consumer|counter|producer"
echo "PRODUCER_INTERVAL=<Delay in seconds between tweets> (15)"
echo "TWEET_TOPIC=<Topic Name> (wc-tweets)"