#!/bin/bash
if [[ 'consumer' == $MODE ]]
then
    echo "Execute consumer against ${KAFKA}:${PORT}"
    #kafka-console-consumer.sh --bootstrap-server $KAFKA:$PORT --topic wc-counts
    exit 0
fi
if [[ 'counter' == $MODE ]]
then
    echo "Execute counter against ${KAFKA}:${PORT}"
    #while true
    #do
    #    raw="$(kafka-console-consumer.sh --bootstrap-server $KAFKA:$PORT --isolation-level read_committed --max-messages 1 --topic wc-tweets)"
    #    a="$(echo $raw | csvtool -t ',' col 2 - | sed 's/^"//;s/"$//')"
    #    c="$(echo $raw | csvtool -t ',' col 6 - | sed 's/\(.*\)/\L\1/;s/[\t !"(),.?]/\n/g' | sed '/^$/d' | sort | uniq -c | sed 's/\n/\\n/g' | sed 's/^"//;s/"$//')"
    #    l="$(echo $raw | csvtool -t ',' col 8 - | sed 's/^"//;s/"$//')"
    #    if [[ -z "${l}" ]]
    #    then
    #        l="Unknown location"
    #    fi
    #    n="$(echo $raw | csvtool -t ',' col 4 - | sed 's/^"//;s/"$//')"
    #    echo -e "${n} from ${l} on ${a}\n${c}\n" | kafka-console-producer.sh --broker-list $KAFKA:$PORT --topic wc-counts
    #done
    exit 0
fi
if [[ 'producer' == $MODE ]]
then
    echo "Execute producer against ${KAFKA}:${PORT}"
    #while true
    #do
    #    shuf -n1 /usr/wc/Tweets.csv | kafka-console-producer.sh --broker-list $KAFKA:$PORT --topic wc-tweets
    #    sleep 15
    #done
    exit 0
fi
echo "Mode '${MODE}' is not recognized"
