#/bin/bash
#
#   dbench test: ./dbench.sh ${TESTPATH}
#   Example  : ./dbench.sh /mnt/ceph
#####################################################

if [ $# != 1 ] ; then
	echo "Usage: $0 <test path> "
	exit 0
fi

CURDIR=`dirname $0`
TESTDIR=$1
CLIENTNUM=$2

if [ ! -d "$TESTDIR" ]; then
	mkdir -p ${TESTDIR}
fi

ARCH=`uname -m`
if [ \"x86_64_ARCH\" = \"${ARCH}_ARCH\" ]; then
	DBENCH=dbench_x86_64
else
	DBENCH=dbench_x86
fi

tar zxvf $CURDIR/config/client.tgz -C $CURDIR
# 60 seconds
for c in 1 4 8 16 32 64 128 256 512
do
if [ -n "$TESTDIR" ]; then
	rm -rf $TESTDIR/*
fi
TIME=`date '+%G%m%d%H%M'`
$CURDIR/${DBENCH} -c $CURDIR/client.txt -D $TESTDIR -t 60 $c | tee -a $CURDIR/dbench.$c.${TIME}.log
done
cp -rf $CURDIR/*.log $TSBMPATH/logs
rm -rf $CURDIR/client.txt
exit 0

