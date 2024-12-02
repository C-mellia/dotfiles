#!/bin/bash

prefix=/wordcount
input_file=input

[[ -z $HADOOP_HOME ]] && {
    echo "HADOOP_HOME is not set"; exit 1
}

$HADOOP_HOME/bin/hadoop mkdir -p $prefix > /dev/null 2>&1

$HADOOP_HOME/bin/hadoop fs -rm -r $prefix/input/* > /dev/null 2>&1
$HADOOP_HOME/bin/hadoop fs -rm -r $prefix/output > /dev/null 2>&1

$HADOOP_HOME/bin/hadoop fs -put $input_file $prefix/input
