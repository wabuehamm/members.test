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

. .env

env MEMBERS_TEST_VIEW_TYPE=desktop pipenv run robot -P lib tasks/Prepare.robot

if [ $? -eq 0 ] 
then
    rm log.html output.xml report.html
fi