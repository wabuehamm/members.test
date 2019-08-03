#!/usr/bin/bash

if [ "X${MEMBERS_TEST_ADMIN_USERNAME}X" == "XX" ]
then

    echo -n "Admin Username: "
    read MEMBERS_TEST_ADMIN_USERNAME
    echo -n "Admin Password: "
    read -s MEMBERS_TEST_ADMIN_PASSWORD
    echo ""

fi

export MEMBERS_TEST_ADMIN_USERNAME
export MEMBERS_TEST_ADMIN_PASSWORD

echo "Cleaning up..."

rm -rf output &>/dev/null
rm log.html report.html output.xml &>/dev/null
rm screenshots-current/* &>/dev/null

bash prepare.sh

if [ $? -ne 0 ]
then   
    exit $?
fi

. .env
rm -rf output &>/dev/null
mkdir -p output/desktop
mkdir -p output/mobile
MEMBERS_TEST_VIEW_TYPE=desktop pipenv run robot -d output/desktop -P lib test

if [ $? -ne 0 ]
then   
    exit $?
fi


MEMBERS_TEST_VIEW_TYPE=mobile pipenv run robot -d output/mobile -P lib test

if [ $? -ne 0 ]
then   
    exit $?
fi

bash diffimages.sh > output/imagediff.txt

bash destroy.sh

if [ $? -ne 0 ]
then   
    exit $?
fi
