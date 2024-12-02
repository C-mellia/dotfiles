#!/bin/bash

[[ -z $HADOOP_HOME ]] && {
    echo "HADOOP_HOME is not set"; exit 1
}

jarfile=$HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming*.jar
mapper=mapper
reducer=reducer
prefix=/wordcount

$HADOOP_HOME/bin/hadoop jar $jarfile\
    -files $mapper,$reducer\
    -mapper $mapper\
    -reducer $reducer\
    -input $prefix/input\
    -output $prefix/output\
    > /dev/null 2>&1 || {
    echo "Failed to run hadoop jar"; exit 1
}
