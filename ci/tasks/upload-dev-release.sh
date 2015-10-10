#!/bin/bash

if [[ "${bosh_target}X" == "X" ]]; then
  echo 'Require $bosh_target, $bosh_username, $bosh_password'
  exit 1
fi

cat > ~/.bosh_config << EOF
---
aliases:
  target:
    bosh-lite: ${bosh_target}
auth:
  ${bosh_target}:
    username: ${bosh_username}
    password: ${bosh_password}
EOF

cd boshrelease
bosh target ${bosh_target}

bosh create release
bosh -n upload release --rebase
