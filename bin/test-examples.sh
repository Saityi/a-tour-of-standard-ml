#!/bin/bash

set -e
for f in examples/*.sml; do
  trap "echo failure in $f" ERR
  expect bin/sml-expect.exp $f &>/dev/null
done
exit 0
