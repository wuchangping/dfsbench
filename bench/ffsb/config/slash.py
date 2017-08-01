#! /usr/bin/python

import os
import sys
import string

# rules file
fn1=sys.argv[1]
# source file
fn2=sys.argv[2]
# dest. file
fn3=sys.argv[3]

f1=open(fn1, mode='r')
f2=open(fn2, mode='r')
f3=open(fn3, mode='w')

i=0
lst=[]
for l in f1:
        l=string.strip(l)
        lst.append(string.split(l,'='))
        i=i+1

for l in f2:
        j=0
        while  j < i:
                l=string.replace(l, lst[j][0], lst[j][1])
                j=j+1
        f3.write(l)

f1.close()
f2.close()
f3.close()
