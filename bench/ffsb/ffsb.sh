#!/bin/bash
#
#   FFSB test: ./ffsb.sh ${TESTPATH}
#   Example  : ./ffsb.sh /mnt/ceph
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
EOF

if [ ! -d "$TESTDIR" ]; then
	mkdir -p $TESTDIR
fi

ARCH=$(uname -m)
if [ \"x86_64_ARCH\" = \"${ARCH}_ARCH\" ]; then
	FFSB=ffsb_x86_64
else
	FFSB=ffsb_x86
fi

chmod +x $CURDIR/config/slash.py
for CONF in `ls $CURDIR/config/*.ffsb`
do
	TIME=`date '+%G%m%d%H%M'`
	if [ -n "${TESTDIR}" ]; then
		rm -rf $TESTDIR/*
	fi
	echo "=============== FFSB $CONF =================="  | tee -a $CONF.log
	$CURDIR/config/slash.py $CURDIR/config/rules.bm $CONF $CONF.new
    	$CURDIR/${FFSB} $CONF.new | tee -a  $CONF.log
	rm -rf $CONF.new
	cp -rf $CONF.log  $TSBMPATH/logs
done
exit 0







