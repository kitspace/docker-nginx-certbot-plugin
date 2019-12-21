#!/usr/bin/env bash

# When we get killed, kill all our children
trap "exit" INT TERM
trap "kill 0" EXIT

nginx -g "daemon off;" &

if [ "$RUN_CERTBOT" == "true" ]; then 
   # check for undefined variables
   set -u 
   # Run certbot which should get certificates and modify your nginx config
   certbot --nginx --domains ${CERTBOT_DOMAINS} --email ${CERTBOT_EMAIL} --agree-tos --redirect --reinstall --non-interactive;
else
echo "Not requesting certificates through certbot, set RUN_CERTBOT=true to run."
fi

while [ true ]; do
    echo "Running certbot renew"
    certbot renew --non-interactive
    nginx -s reload

    # Sleep for 1 week
    sleep 604810 &
    SLEEP_PID=$!

    # Wait on sleep so that when we get ctrl-c'ed it kills everything due to our trap
    wait "$SLEEP_PID"
done
