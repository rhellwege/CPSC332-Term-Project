#!/bin/bash

github_username="rhellwege"
github_repo="CPSC332-Term-Project"
mysql_username=""
mysql_password=""
#
# Check if the variable is empty
if [ -z "$github_username" ]; then
    echo "Please enter a value for github_username:"
    read github_username
fi

if [ -z "$github_repo" ]; then
    echo "Please enter a value for github_repo:"
    read github_username
fi

if [ -z "$mysql_username" ]; then
    echo "Please enter a value for mysql_username:"
    read mysql_username
fi

if [ -z "$mysql_password" ]; then
    echo "Please enter a value for mysql_password:"
    read mysql_password
fi
download() {
    # wipe directory
    echo ''
    echo "Removing old repo..."
    echo ''
    rm "./$github_repo"
    echo ''
    echo "Downloading archive..."
    echo ''
    wget --no-check-certificate "https://github.com/$github_username/$github_repo/archive/master.tar.gz"

    # extracting the tarball
    echo ''
    echo "Extracting archive..."
    echo ''
    tar -zxvf ./master.tar.gz
    mv "./$github_repo-main" "./$github_repo"

    # cleaning up
    echo ''
    echo "cleaning up..."
    echo ''
    rm ./master.tar.gz


    echo ''
    echo "Setting up homepage directory..."
    echo ''
    rm -rf ./homepage
    cp -r "./$github_repo/homepage" .
}

replace() {
    echo ''
    echo "Replacing username and password..."
    echo ''
    sed -i "s/USERNAME/$username/g" $(grep -rl 'USERNAME' .)
    sed -i "s/PASSWORD/$password/g" $(grep -rl 'PASSWORD' .)
}

# download from scratch
while true; do
read -p "remove old repo/homepage or download from scratch? (y/n): " yn
    case $yn in
        [Yy]* ) download; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

while true; do
read -p "replace all occurances of USERNAME and PASSWORD with actual username and password? (y/n): " yn
    case $yn in
        [Yy]* ) replace; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo ""
while true; do
read -p "Run sql DROP commands? (Only needed if run before.) (y/n): " yn
    case $yn in
        [Yy]* ) # Dropping tables
echo "Dropping tables...";
mysql -h mariadb -u $mysql_username -p$mysql_password < "./$github_repo/sql/drop.sql";
break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo ""
while true; do
read -p "Run sql CREATE commands? (Only needed if all tables are dropped or first time.) (y/n): " yn
    case $yn in
        [Yy]* ) # Dropping tables
echo "Generating tables...";
mysql -h mariadb -u $mysql_username -p$mysql_password <  "./$github_repo/sql/schema.sql";
break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

echo ""
while true; do
read -p "Run sql INSERT commands? (Only needed if all tables are dropped or first time.) (y/n): " yn
    case $yn in
        [Yy]* ) # Dropping tables
echo "Inserting data...";
mysql -h mariadb -u $mysql_username -p$mysql_password < "./$github_repo/sql/insert.sql";
break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
