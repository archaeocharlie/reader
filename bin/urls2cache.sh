#!/usr/bin/env bash

# urls2cache.sh - give a file listing a set of urls, initialize a study carrel, cache content, and build the carrel

# Eric Lease Morgan <emorgan@nd.edu>
# (c) University of Notre Dame and distributed under a GNU Public License

# July  8, 2018 - first cut
# July 14, 2018 - more investigation


# configure
CACHE='cache';
CARRELS='./carrels'
HOME='/afs/crc.nd.edu/user/e/emorgan/local/reader'
INITIALIZECARREL='./bin/initialize-carrel.sh'
MAKE='./bin/make.sh'
TMP='./tmp'
URL2CACHE='./bin/urls2cache.pl'

# validate input
if [[ -z $1 ]]; then

	echo "Usage: $0 <file>" >&2
	exit

fi

# get the input
FILE=$1

# make sane
cd $HOME

# initialize (a random) name
NAME=$( cat /dev/urandom | tr -cd 'a-zA-Z' | head -c 7 )

# create a study carrel
$INITIALIZECARREL $NAME

# process each line from input; create the cache
while read URL; do

    # debug and do the work
    echo "$URL" >&2
    $URL2CACHE $URL "$CARRELS/$NAME/$CACHE"
    sleep 1
    
done < "$TMP/$FILE"

# build the carrel
$MAKE $NAME

# done
echo $
exit