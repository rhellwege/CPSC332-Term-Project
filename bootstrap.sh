#!/bin/bash

github_username="rhellwege"
github_repo="CPSC332-Term-Project"
mysql_username="cs332e7"
mysql_password="2wJ3Nbfa"

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

# download from scratch
while true; do
read -p "remove old repo/homepage or download from scratch? (y/n): " yn
    case $yn in
        [Yy]* ) download; break;;
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
mysql -h mariadb -u $mysql_username -p$mysql_password < ./sql/drop.sql;
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
mysql -h mariadb -u $mysql_username -p$mysql_password < ./sql/schema.sql;
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
mysql -h mariadb -u $mysql_username -p$mysql_password < ./sql/insert.sql;
break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
