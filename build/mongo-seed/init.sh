#!/bin/bash

if test -z "$MONGOUSER" || test -z "$MONGOPASS" || test -z "$MONGODBNAME"; then
	echo "environment variable(s) missing"
	exit 1
fi


mongo --host thumbsniper-mongo.docker --eval "
	db = db.getSiblingDB(\"${MONGODBNAME}\");
	db.createUser({
		user: \"${MONGOUSER}\",
		pwd: \"${MONGOPASS}\",
		roles: [ 
			'readWrite'
		]})"

