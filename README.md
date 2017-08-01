# dfsbench
dfsbench is a distributed file system performance and stress test package.


1."dfsbench" is BenchMark Interface. 
  It use to do file system performance and stress test,which 
  include "ffsb bonnie++ iozone dbench postmark tiobench" etc. 
  Usage :dfsbench <command> <test path> #(except rwtest)
  Type "dfsbench -h" or "dfsbench --help" to list help info.
  For instance :
  "./dfsbench testall /mnt/ceph" 
  "./dfsbench iozone /mnt/ceph" 
  "./dfsbench rwtest" 
  "./dfsbench -h"

2.Options:

2.1 <command>

testall  : ffsb dbench iozone postmark tiobench test
ffsb     : file system perfmance tester 
bonnie   : R/W perfmance and stress tester 
iozone   : R/W perfmance and stress tester 
dbench   : file server perfmance tester 
postmark : create/delete folder perfmance tester 
tiobench : thread i/o tester 
fsstress : file system mds stress test tool
blogbench: file system performance test tool
rwtest   : data compare(cmp) test tool
fdtree   : mds data  test tool
--help   : list help page 
-h       : list help page 

2.2 <test path>

<test path> is the folder that you want to do test.

3. MIN_FILE_SIZE MAX_FILE_SIZE

MIN_FILE_SIZE use only for iozone ,MAX_FILE_SIZE is the test file 
image size ,to get the normal test result data,need set it to 
> 2 * amount of host memory size.As default ,MAX_FILE_SIZE is set 
to "4096" MB at "tsbm" script,you can modify it with host memory size.




