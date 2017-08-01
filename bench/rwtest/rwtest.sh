#!/bin/bash
#
#   rwtest: data compare test
#####################################################

set -e

CURDIR=`dirname $0`
ARCH=`uname -m`
if [ \"x86_64_ARCH\" = \"${ARCH}_ARCH\" ]; then
        echo "rwtest need ia32-libs package support"
	echo "install it:apt-get install ia32-libs"
fi

echo -e "\e[1;31mUsage: for instance: 
$ dd if=/dev/zero of=./tmp0/dddd bs=1M count=128
$ ./rwtest
Source      : ./tmp0 # a mount dir at tdfs,exist a file 
Destination : ./tmp1 # a dir at localhost,it's empty
Times       : 5
Log File    : ./log
------------------------------------------
[5,1] ./tmp0 ---> ./tmp1        [ OK ]
[5,1] ./tmp1 ---> ./tmp0        [ OK ]
[5,2] ./tmp0 ---> ./tmp1        [ OK ]
[5,2] ./tmp1 ---> ./tmp0        [ OK ]
[5,3] ./tmp0 ---> ./tmp1        [ OK ]
[5,3] ./tmp1 ---> ./tmp0        [ OK ]
[5,4] ./tmp0 ---> ./tmp1        [ OK ]
[5,4] ./tmp1 ---> ./tmp0        [ OK ]
[5,5] ./tmp0 ---> ./tmp1        [ OK ]
[5,5] ./tmp1 ---> ./tmp0        [ OK ]
\e[0m"
echo -e "\e[1;31m------------------------------------------\e[0m\n"
echo -n
${CURDIR}/rwtest 
exit 0
