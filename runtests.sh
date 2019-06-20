#!/usr/bin/bash

. venv/bin/activate
. .env
rm -rf output &>/dev/null
mkdir -p output/desktop
mkdir -p output/mobile
MEMBERS_TEST_VIEW_TYPE=desktop robot -d output/desktop -P lib test
MEMBERS_TEST_VIEW_TYPE=mobile robot -d output/mobile -P lib test

bash diffimages.sh > output/imagediff.txt