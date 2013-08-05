#!/bin/bash

#update library link
Update(){
TARGET=`basename $1`
QTPATH=/Users/iori/Qt5.0.2/5.0.2/clang_64/
LIBPATH=$1
CMD1="install_name_tool -id"
CMD2="install_name_tool -change"
ABSPATH1=lib/
ABSPATH2=.framework/Versions/5/
RELPATH1=@executable_path/../Frameworks/
RELPATH2=.framework/Versions/5/

count=1
for arg in $@
do
if [ $count -gt 1 ] ; then
if [ $arg = $TARGET ] ; then
$CMD1 ${RELPATH1}${arg}${RELPATH2}${arg} $LIBPATH
else
$CMD2 ${QTPATH}${ABSPATH1}${arg}${ABSPATH2}${arg} ${RELPATH1}${arg}${RELPATH2}${arg} $LIBPATH 
fi
fi
count=$(($count+1))
done
}

#pickup library name
rel=`otool -L $1 | grep -E '\t/.+Qt' | sed -e "s/(.*)//g"`
OIFS="$IFS"; IFS=' '
name_array=($rel); IFS="$OIFS"

name=""
for arg in ${name_array[@]}
do
name="$name `basename $arg`"
done

#output
echo "`basename $1` :$name"

#update
Update $1 $name

#check
otool -L $1 | grep Qt
