#!/bin/bash

WEBHOOK=$(cat ~/.pts/WEBHOOK.txt)

function curl_webhook() {
    curl -s \
      -F "payload_json={\"username\": \"scanner\", \"content\": \"$COMMAND --- $(date)\"}" \
      -F "file1=@$TEMP_FILE" \
      $WEBHOOK > /dev/null
}

while [ $# -gt 0 ]; do
    case $1 in
        --share=*)
            TEMP_FILE=$(echo $1 | awk -F'=' '{print $2}')
            curl_webhook
            echo -e "File sended !"
            exit 0
        ;;
        *)
            COMMAND="$@"
            TEMP_FILE=$(mktemp --suffix=.txt)
            RESULT=$($@ > $TEMP_FILE)
            cat $TEMP_FILE
            curl_webhook
            rm $TEMP_FILE
            break
        ;;
    esac
done
