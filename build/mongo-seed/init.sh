#!/bin/bash

if test -z "$MONGOUSER" || test -z "$MONGOPASS" || test -z "$MONGODBNAME"; then
	echo "environment variable(s) missing"
	exit 1
fi

until nc -z mongo 27017
do
	echo "waiting for MongoDB"
	sleep 1
done

mongo --host mongo --eval "
	db = db.getSiblingDB(\"${MONGODBNAME}\");
	db.createUser({
		user: \"${MONGOUSER}\",
		pwd: \"${MONGOPASS}\",
		roles: [ 
			'readWrite'
		]})"

