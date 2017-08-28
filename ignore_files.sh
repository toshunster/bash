#!/usr/bin/env bash

for file in `svn status | fgrep "?" | sed '1,3d' | sed -e 's/\?[ ]*//g' | egrep "GNUMakefile|test.incl.sh"`; do
    dir=`dirname $file`
    file_ignore=`basename $file`
    cd $dir
    props=$(svn propget svn:ignore ./)
    props="$props"$'\n'"$file_ignore"
    echo "$file_ignore ==== $dir === $props"
    svn propset svn:ignore "$props" .
    cd -
done
