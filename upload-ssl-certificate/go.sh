#!/bin/bash -e

# brew install python
# pip3 install beluga_py

# awk script replaces newline with \n
CERT=`cat ../../domains_and_tls/tls/certs/www.danstutzman.com/cert.pem | awk '{printf "%s\\\\n", $0}'`
CHAIN=`cat ../../domains_and_tls/tls/certs/www.danstutzman.com/chain.pem | awk '{printf "%s\\\\n", $0}'`
PRIVKEY=`cat ../../domains_and_tls/tls/certs/www.danstutzman.com/privkey.pem | awk '{printf "%s\\\\n", $0}'`

beluga \
  --username dtstutz@gmail.com \
  --password `cat BELUGA_PASSWORD` \
  --path ssl-certificates/www.danstutzman.com \
  --method DELETE || true

beluga \
  --username dtstutz@gmail.com \
  --password `cat BELUGA_PASSWORD` \
  --path ssl-certificates \
  --method POST \
  --body "{\"certificate\": \"$CERT\", \"key\": \"$PRIVKEY\", \"chain\": \"$CHAIN\", \"site\": \"www.danstutzman.com\"}"
