#!/usr/bin/bash

rm -r screenshots-diff
mkdir screenshots-diff

for IMAGE in $(cd screenshots-current && ls -1 *.png)
do
    echo -n Comparing ${IMAGE}: 
    pipenv run python -m diffimg screenshots-baseline/${IMAGE} screenshots-current/${IMAGE} -f screenshots-diff/${IMAGE}
done
