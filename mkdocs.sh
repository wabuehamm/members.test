#!/usr/bin/bash

rm -rf docs
mkdir -p docs/pages

python -m robot.testdoc test docs/test.html

for FILE in $(find pages -name "*.robot")         
do
    LIBFILE=$(basename ${FILE})
    python -m robot.libdoc ${FILE} docs/pages/${LIBFILE}.html
done