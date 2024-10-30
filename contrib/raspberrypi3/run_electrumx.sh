#!/bin/sh
###############
# run_electrumz
###############

# configure electrumz
export COIN=Bitcoin
export DAEMON_URL=http://rpcuser:rpcpassword@127.0.0.1
export NET=mainnet
export CACHE_MB=400
export DB_DIRECTORY=/home/username/.electrumz/db
export SSL_CERTFILE=/home/username/.electrumz/certfile.crt
export SSL_KEYFILE=/home/username/.electrumz/keyfile.key
export BANNER_FILE=/home/username/.electrumz/banner
export DONATION_ADDRESS=your-donation-address

# connectivity
export HOST=
export TCP_PORT=50001
export SSL_PORT=50002

# visibility
export REPORT_HOST=hostname.com
export RPC_PORT=8000

# run electrumz
ulimit -n 10000
/usr/local/bin/electrumz_server 2>> /home/username/.electrumz/electrumz.log >> /home/username/.electrumz/electrumz.log &

######################
# auto-start electrumz
######################

# add this line to crontab -e
# @reboot /path/to/run_electrumz.sh
