#!/bin/bash
#
#   FFSB test: ./postmark.sh ${TESTPATH}
#   Example  : ./postmark.sh /mnt/ceph
######################################

set -e
if [ $# != 1 ] ; then
	echo "Usage: $0 <test path>"
	exit 0
fi

CURDIR=`dirname $0`
TESTDIR=$1

cat>$CURDIR/config/rules.bm<<-EOF
	%TESTPATH%=${TESTDIR}
	%CURPATH%=${CURDIR}
EOF
if [ ! -d "$TESTDIR" ]; then
	mkdir -p $TESTDIR
fi

ARCH=`uname -m`
if [ \"x86_64_ARCH\" = \"${ARCH}_ARCH\" ]; then
	POSTMARK=postmark_x86_64
else
	POSTMARK=postmark_x86
fi


chmod +x $CURDIR/config/slash.py
for CONF in $CURDIR/config/*.cfg
do
	if [ -n "$TESTDIR" ]; then
		rm -rf $TESTDIR/*
	fi
	TIME=`date '+%G%m%d%H%M'`
	$CURDIR/config/slash.py $CURDIR/config/rules.bm $CONF $CONF.new
    	$CURDIR/${POSTMARK} $CONF.new | tee -a $CURDIR/postmark.$CONF.${TIME}.log
	rm -rf $CONF.new
done
cp -rf $CURDIR/*.log $TSBMPATH/logs
exit 0

