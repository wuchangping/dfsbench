#!/bin/bash
#
#   iozone test: ./iozone.sh ${TESTPATH} ${FILESIZE(Mb)}
#   Example  : ./iozone.sh /mnt/ceph 200 4096
#   Note: test file size should be > 2* amount of  memory in the client,
#         example: 2G memory , use 4G test file 
#####################################################

set -e
if [ $# != 3 ] ; then
	echo "Usage: $0 < test path> < min file size(MB)> <max file size(MB)>"
	exit 0
fi

TIME=`date '+%G%m%d%H%M'`
CURDIR=`dirname $0`
TESTDIR=$1
MIN_SIZE=$2
MAX_SIZE=$3

if [ ! -d "$TESTDIR" ]; then
	mkdir -p ${TESTDIR}
fi

ARCH=`uname -m`
if [ \"x86_64_ARCH\" = \"${ARCH}_ARCH\" ]; then
	IOZONE=iozone_x86_64
else
	IOZONE=iozone_x86
fi
if [ -n "${TESTDIR}" ]; then
	rm -rf $TESTDIR/*
fi
# 4k~16M
#${CURDIR}/${IOZONE} -z -c -e -a -n ${MIN_SIZE}M -g ${MAX_SIZE}M -i 0 -i 1 -i 2 -f ${TESTDIR}/fio -Rb ${CURDIR}/iozone.${TIME}.xls | tee -a ${CURDIR}/iozone.${TIME}.log
#cp -rf $CURDIR/*.xls $TSBMPATH/logs
# 32k ~ 256k
for i in 32 64 128 256
do
$CURDIR/${IOZONE} -r ${i}k -t 10 -s ${MAX_SIZE}M -i 0 -i 1 -i 2  -F ${TESTDIR}/F1 ${TESTDIR}/F2 ${TESTDIR}/F3 ${TESTDIR}/F4 ${TESTDIR}/F5 ${TESTDIR}/F6 ${TESTDIR}/F7 ${TESTDIR}/F8 ${TESTDIR}/F9 ${TESTDIR}/F10 | tee -a $CURDIR/iozone.${TIME}.log
if [ -n "${TESTDIR}" ]; then
	rm -rf ${TESTDIR}/F*
fi
done
cp -rf $CURDIR/*.log $TSBMPATH/logs/
exit 0
