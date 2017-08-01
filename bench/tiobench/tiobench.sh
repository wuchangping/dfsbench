#!/bin/bash
#
#   tiobench test: ./tiobm.sh ${TESTDIR} ${FILESIZE(MB)}
#   Example  : ./tioben.sh /mnt/ceph 
#####################################################

if [ $# != 1 ] ; then
	echo "Usage: $0 <test path> "
	exit 0
fi

CURDIR=`dirname $0`
TESTDIR=$1
#FILESIZE=10   

if [ ! -d "$TESTDIR" ]; then
	mkdir -p ${TESTDIR}
fi

ARCH=`uname -m`
if [ \"x86_64_ARCH\" = \"${ARCH}_ARCH\" ]; then
	TIOTEST=tiotest_x86_64 
else
	TIOTEST=tiotest_x86
fi


#for i in 32 64 128
#do
#	if [ -n "${TESTDIR}" ]; then
#		rm -rf $TESTDIR/*
#	fi
#	TIME=`date '+%G%m%d%H%M'`
#	rdnum=`expr $i \* 100`
#	FILE=`expr $i \* $FILESIZE`
#	$CURDIR/tiobench.pl --size $FILE --dir $TESTDIR --random $rdnum --block 4096  --block 8192 --block 16384 --block 32768 --block 65536 --block 131072 --thread $i | tee -a $CURDIR/tiobench.$i.${TIME}.log
#done

while echo `date` ;do $CURDIR/${TIOTEST} -f 5 -t 30 -d ${TESTDIR} -T -D 20 -r 10 ; done
if [ -n "${TESTDIR}" ]; then
	rm -rf $TESTDIR/*
fi
#cp -rf $CURDIR/*.log $TSBMPATH/logs
exit 0

