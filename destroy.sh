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
. venv/bin/activate

env MEMBERS_TEST_VIEW_TYPE=desktop robot -P lib tasks/Destroy.robot

if [ $? -eq 0 ] 
then
    rm log.html output.xml report.html
fi