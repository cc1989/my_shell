#!/bin/sh
vsearchName=`ps aux | grep com.taobao.vsearch.server.RunMain | awk -F ' ' '$13 != "grep"  {print $12}' | awk -F '=' '{print $2}'`
for name in $vsearchName
do
	vesion=`ls $name/lib-run/ | grep vsearch-core`
	content=`cat $name/conf/schema.xml | grep '<field name.*/>' | wc -l`
	echo  "$name : $vesion : $name/conf/schema.xml : $content"
done
