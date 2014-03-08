#!/bin/sh

##
# CONFIGURE THE SCRIPT HERE
##
UNREAL_VERSION=3.2.10.1
UNREAL_USER="set your username here"
ANOPE_VERSION=1.8.8
ANOPE_USER="set your username here"


### DO NOT EDIT BELOW HERE ##
ORIGINAL_DIRECTORY=$PWD
CFLAGS="-fstack-protector-all -fomit-frame-pointer -Os -pipe -falign-functions=64 -falign-loops=32 -fforce-addr -ffast-math"

##
# CREATE USERS
##
adduser $UNREAL_USER
adduser $ANOPE_USER

##
# INSTALL DEPENDENCIES AND REMOVE UNWANTED SHIT
##
apt-get update && apt-get upgrade
apt-get install openssl libssl-dev build-essential

/etc/init.d/apache2 stop
/etc/init.d/sendmail stop

apt-get purge apache2
apt-get purge sendmail
apt-get purge exim


##
# UNREALIRCD SETUP
##
su -l $UNREAL_USER
wget -O - "http://www.unrealircd.com/downloads/Unreal$UNREAL_VERSION.tar.gz" |tar xz
mv Unreal$UNREAL_VERSION Unreal
cd Unreal
./Config
make && make install
cp doc/example.conf ./
mv example.conf unrealircd.conf

## CLOAKING MODULE (PRIVACY!!!!)
cd src/modules
wget http://www.wrongway.org/mods/f_staticcloak.zip
unzip f_staticcloak.zip
cd ..
make custommodule MODULEFILE=f_staticcloak

