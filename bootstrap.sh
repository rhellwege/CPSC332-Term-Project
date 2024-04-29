#!/bin/bash

# remove 
while true; do
read -p "Wipe current directory and download project files? (y/n): " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

# wipe directory
echo ''
echo "Wiping directory..."
echo ''
find . ! -name 'bootstrap.sh' -exec rm -rf {} +
# download the tarball
echo "Downloading project archive..."
wget --no-check-certificate https://github.com/rhellwege/CPSC332-Term-Project/archive/master.tar.gz

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
mv ./CPSC332-Term-Project-main/* .
rm -rf ./CPSC332-Term-Project-main/


echo ""
while true; do
read -p "Run sql DROP commands? (Only needed if run before.) (y/n): " yn
    case $yn in
        [Yy]* ) # Dropping tables
echo "Dropping tables...";
mysql -h mariadb -u cs332e7 -p2wJ3Nbfa < ./sql/drop.sql;
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
mysql -h mariadb -u cs332e7 -p2wJ3Nbfa < ./sql/schema.sql;
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
mysql -h mariadb -u cs332e7 -p2wJ3Nbfa < ./sql/insert.sql;
break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
