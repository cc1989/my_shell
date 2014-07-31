#!/bin/bash

for((i = 0; i < 32; i++))
do
	if (($i < 10))
	then
		echo "<entry key=\"CAINIAO_WAYBILL_000${i}_GROUP\">"
	else
		echo "<entry key=\"CAINIAO_WAYBILL_00${i}_GROUP\">"
	fi
	echo "   <bean class=\"com.taobao.vdump.full.dataprovider.TDDLSimpleNameList\" init-method=\"init\" parent=\"tableNames\">"
	echo "	     <property name=\"seqStart\" value=\"$(($i * 128))\" />"
	echo "   </bean>"
	echo "</entry>"

done
