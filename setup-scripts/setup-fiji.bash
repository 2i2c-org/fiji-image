#!/bin/bash
set -euo pipefail

cd /tmp
curl -sSL https://downloads.micron.ox.ac.uk/fiji_update/mirrors/fiji-latest/fiji-linux64.zip -o fiji.zip
unzip fiji.zip
mv Fiji.app /opt/Fiji.app
rm fiji.zip