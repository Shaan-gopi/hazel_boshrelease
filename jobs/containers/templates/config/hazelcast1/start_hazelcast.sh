#!/bin/sh


if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

#. $BUILD_HOME/currentbuild.sh
cd $BUILD_HOME
unzip -o alcatraz_cache_*.zip -d $CACHE_HOME
echo $CACHE_HOME|cut -c2-| xargs tar -C / -xvf sdet_conf.tar
cd $CACHE_HOME/bin
cp $CACHE_HOME/zookeeper.cfg $CACHE_HOME/conf/
cp $CACHE_HOME/product-build.info $CACHE_HOME/conf/
cp /home/apcuser/hazelcast*.jar $CACHE_HOME/lib/
./start.sh
