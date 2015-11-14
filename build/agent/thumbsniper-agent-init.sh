#!/bin/bash

if [ $# -ne 1 ]; then
	echo "release missing"
	exit 1
fi

BUILDDIR=$(realpath $(dirname $0))
RELEASE="$1"


echo "* pull remote repository"

if [ -d ${BUILDDIR}/thumbsniper/.git ]; then
        git -C ${BUILDDIR}/thumbsniper pull origin master
	git -C ${BUILDDIR}/thumbsniper checkout $RELEASE
else
	git clone ssh://git@github.com/cupracer/thumbsniper-agent.git ${BUILDDIR}/thumbsniper
        git -C ${BUILDDIR}/thumbsniper checkout $RELEASE
fi

echo $RELEASE > ${BUILDDIR}/thumbsniper/RELEASE.txt

echo "* run composer update"
composer --working-dir=${BUILDDIR}/thumbsniper update

