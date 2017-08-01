#!/bin/bash
#
#   bonnie++ test: ./bonnie.sh ${TESTPATH} ${FILESIZE(Mb)}
#   Example  : ./bonnie.sh /mnt/ceph 4096 
#   Note: test file size should be > 2*amount of memory in the client,
#         example: 2G memory , use 4G test file 
#####################################################

set -e
if [ $# != 2 ] ; then
	echo "Usage: $0 <test path> <file size(Mb)>"
	exit 0
fi

TIME=`date '+%G%m%d%H%M'`
CURDIR=`dirname $0`
TESTDIR=$1
FILESIZE=$2

if [ ! -d "$TESTDIR" ]; then
	mkdir -p ${TESTDIR}
fi

ARCH=`uname -m`
if [ \"x86_64_ARCH\" = \"${ARCH}_ARCH\" ]; then
	BONNIE=bonnie++_x86_64
else
	BONNIE=bonnie++_x86
fi
if [ -n "${TESTDIR}" ]; then
	rm -rf $TESTDIR/*
fi
$CURDIR/${BONNIE} -b -d $TESTDIR -u root -r 512 -s $FILESIZE -x 1 | tee -a $CURDIR/bonnie.${TIME}.log
cp -rf $CURDIR/*.log $TSBMPATH/logs
exit 0
