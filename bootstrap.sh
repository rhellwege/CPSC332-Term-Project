#!/bin/bash

github_username="rhellwege"
github_repo="CPSC332-Term-Project"
mysql_username="cs332e7"
mysql_password="2wJ3Nbfa"

download() {
    # wipe directory
    echo ''
    echo "Wiping directory..."
    echo ''
    find . ! -name 'bootstrap.sh' -exec rm -rf {} +
    # download the tarball
    echo "Downloading project archive..."
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
    mv "./$github_repo/*" .
    rm -rf ./$github_repo/
}

# download from scratch 
while true; do
read -p "Wipe current directory and download project files? (y/n): " yn
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
