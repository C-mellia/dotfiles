#!/bin/bash

prefix=/wordcount

[[ -z $HADOOP_HOME ]] && {
    echo "HADOOP_HOME is not set"; exit 1
}

$HADOOP_HOME/bin/hadoop fs -cat $prefix/output/*
