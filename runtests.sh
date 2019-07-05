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

bash prepare.sh

if [ $? -ne 0 ]
then   
    exit $?
fi

. venv/bin/activate
. .env
rm -rf output &>/dev/null
mkdir -p output/desktop
mkdir -p output/mobile
MEMBERS_TEST_VIEW_TYPE=desktop robot -d output/desktop -P lib test

if [ $? -ne 0 ]
then   
    exit $?
fi


MEMBERS_TEST_VIEW_TYPE=mobile robot -d output/mobile -P lib test

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
