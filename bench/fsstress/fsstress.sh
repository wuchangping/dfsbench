#!/bin/bash
#
#   fsstress of LTP test: ./fsstress.sh ${TESTPATH}
#   Example  : ./fsstress.sh /mnt/ceph/fstest
#####################################################

set -e
if [ $# != 1 ] ; then
	echo "Usage: $0 <test path> "
	exit 0
fi

TIME=`date '+%G%m%d%H%M'`
CURDIR=`dirname $0`
TESTDIR=$1

if [ ! -d "$TESTDIR" ]; then
	mkdir -p ${TESTDIR}
fi

ARCH=`uname -m`
if [ \"x86_64_ARCH\" = \"${ARCH}_ARCH\" ]; then
	FSSTRESS=fsstress_x86_64
else
	FSSTRESS=fsstress_x86
fi
if [ -n "${TESTDIR}" ]; then
	rm -rf ${TESTDIR}/*
fi
${CURDIR}/${FSSTRESS} -d ${TESTDIR}/mdstest  -f write=freq -l 100 -n 10000 -p 30 -v -S  
if [ -n "${TESTDIR}" ]; then
	rm -rf ${TESTDIR}/*
fi
exit 0
