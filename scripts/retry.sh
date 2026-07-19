#!/bin/bash

retry(){

attempt=1

until "$@"

do

if [ $attempt -ge $MAX_RETRIES ]
then

log_error "Maximum retries reached."

return 1

fi

log_warn "Retry $attempt..."

sleep $((RETRY_DELAY*attempt))

attempt=$((attempt+1))

done

}