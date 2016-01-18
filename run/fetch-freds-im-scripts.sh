#!/bin/bash

# This script downloads two ImageMagick scripts from
#
# http://www.fmwconcepts.com/imagemagick/
#
# Please visit this web page and honor the license requirements
# before you start using these scripts.
#
# At Nov 30 2015 the following information was available there:
#
# <snip>
#
# Licensing:
# Copyright © Fred Weinhaus
# My scripts are available free of charge for non-commercial use, ONLY.
# For use of my scripts in commercial (for-profit) environments or non-free applications,
# please contact me (Fred Weinhaus) for licensing arrangements. My email address is fmw at alink dot net.
#
# If you: 
# 1) redistribute, 
# 2) incorporate any of these scripts into other free applications or 
# 3) reprogram them in another scripting language, 
#
# then you must contact me for permission, especially if the result might be used in a commercial or for-profit environment.
#
# Usage, whether stated or not in the script, is restricted to the above licensing arrangements.
# It is also subject, in a subordinate manner, to the ImageMagick license, 
# which can be found at: http://www.imagemagick.org/script/license.php
#
# </snip>


ROTATE_URL='http://www.fmwconcepts.com/imagemagick/downloadcounter.php?scriptname=3Drotate&dirname=3Drotate'
REFLECTION_URL='http://www.fmwconcepts.com/imagemagick/downloadcounter.php?scriptname=3Dreflection&dirname=3Dreflection'

ROTATE_BIN='3Drotate'
REFLECTION_LEFTTORIGHT_BIN='3Dreflection'
REFLECTION_RIGHTTOLEFT_BIN='3Dreflection_rightToLeft'

# download 3Drotate
curl "${ROTATE_URL}" | sed -e 's/^dir=\"\.\"/dir=\"\/tmp\"/' > ${ROTATE_BIN}

# download 3Dreflection (fade left to right)
curl "${REFLECTION_URL}" \
	| sed -e 's/^dir=\"\.\"/dir=\"\/tmp\"/' \
	| sed -e 's/^3Drotate/\$\{PROGDIR\}\/3Drotate/' \
	> ${REFLECTION_LEFTTORIGHT_BIN}

# duplicate and modify 3Dreflection (fade right to left)
cat "${REFLECTION_LEFTTORIGHT_BIN}" \
	| sed -e 's/^rotate=\([0-9]*\)\(.*#.*\)$/rotate=-\1\2/' \
	| sed -e 's/^xoff=.*/xoff=\`convert xc: -format \"%\[fx:$ww\/2\]\" info:\`/' \
	| sed -e 's/^3Drotate/\$\{PROGDIR\}\/3Drotate/' \
	> ${REFLECTION_RIGHTTOLEFT_BIN}

# make scripts executable
chmod 755 ${ROTATE_BIN}
chmod 755 ${REFLECTION_LEFTTORIGHT_BIN}
chmod 755 ${REFLECTION_RIGHTTOLEFT_BIN}

