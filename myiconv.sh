#########################################################################
# File Name: myiconv.sh
# Author: cc
# mail: huangchen1989@gmail.com
# Created Time: 2014年04月12日 22时37分15秒 CST
#########################################################################
#!/bin/bash

foreachd()
{
	for file in $1/*	
	do
		if [ -d "$file" ]
		then 
			echo "进入$file"
			foreachd "$file"
		elif [ -f "$file" ]
		then
			#过滤掉一些不需要转换的文件
			want_file="`echo $file | sed -n \"/.*\.\(tar\|gz\|z\|bz2\|gzip\|so\|o\|a\)$/p\"`"
			echo $want_file
			if [ -z  $want_file ] && [ ! -x $file ]
			then
				echo "转换$file"
				iconv -f $source_type -t $dest_type $file -o $file.b
				if [ $? -eq 0 ]
				then
					rm "$file"
					mv "$file.b" "$file"
				else
					echo "$file转换失败"
				fi
			fi
		fi
	done
}
if [ "$1" == "-f" ]
then
	if [ -n "$2" ]  #测试-f的指定源文件编码不为空
	then
		source_type="$2";
	else
		echo -e "源文件编码为空\n"
	fi
else
	echo -e "需要-f选项\n"
fi

if [ "$3" == "-t" ]
then
	if [ -n "$4" ]  #测试-f的目标文件编码不为空
	then
		dest_type="$4";
	else
		echo -e "目标文件编码为空\n"
	fi
else
	echo -e "需要-t选项\n"
fi

#目录或者文件路径
if [ -n "$5" ]
then
	path="$5"
else
	echo -e "目录或文件路径为空"
fi

echo "$source_type$dest_type$path"
path="`echo $path | sed -e \"s/\(.*\)\/$/\1/\"`"  #去掉路径最后的/
echo $path
foreachd $path
