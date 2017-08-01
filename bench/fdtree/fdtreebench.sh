#!/bin/bash
#
#  fdtree: metadata test
#####################################################

set -e

if [ $# != 1 ] ; then
        echo "Usage: $0 <test path> "
        exit 0
fi

CURDIR=`dirname $0`
TESTDIR=$1

if [ ! -d "$TESTDIR" ]; then
        mkdir -p ${TESTDIR}
fi

#Small Files - Shallow Directory Structure
${CURDIR}/fdtree.bash -d 20 -f 40 -s 1 -l 3 -o ${TESTDIR}
if [ -n "${TESTDIR}" ]; then
        rm -rf ${TESTDIR}/*
fi
#Medium Files - Shallow Directory Structure
${CURDIR}/fdtree.bash -d 20 -f 10 -s 100 -l 2 -o ${TESTDIR}
if [ -n "${TESTDIR}" ]; then
        rm -rf ${TESTDIR}/*
fi

exit 0
