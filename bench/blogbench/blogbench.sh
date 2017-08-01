#!/bin/bash
#
#   blogbench test: ./blogbench.sh ${TESTPATH}
#   Example  : ./blogbench.sh /mnt/ceph
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
	BLOGBENCH=blogbench_x86_64
else
	BLOGBENCH=blogbench_x86
fi
if [ -n "${TESTDIR}" ]; then
	rm -rf ${TESTDIR}/*
fi
${CURDIR}/${BLOGBENCH} -d ${TESTDIR}  -c 200 -i 200 -r 200 -w 200 -W 200
if [ -n "${TESTDIR}" ]; then
	rm -rf ${TESTDIR}/*
fi
exit 0
