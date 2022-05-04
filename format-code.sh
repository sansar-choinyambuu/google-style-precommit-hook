#!/usr/bin/env bash

GOOGLE_JAVA_FORMAT_VERSION="1.15.0"
while getopts 'v:' o; do
  case $o in
    v) GOOGLE_JAVA_FORMAT_VERSION=$OPTARG ;;
  esac
done

mkdir -p .cache
cd .cache

URL="https://github.com/google/google-java-format/releases/download/v${GOOGLE_JAVA_FORMAT_VERSION}/google-java-format-${GOOGLE_JAVA_FORMAT_VERSION}-all-deps.jar"
MAJOR_VERSION=${GOOGLE_JAVA_FORMAT_VERSION%%.*}
PATCH_VERSION=${GOOGLE_JAVA_FORMAT_VERSION##*.}
MINOR_VERSION=${GOOGLE_JAVA_FORMAT_VERSION##$MAJOR_VERSION.}
MINOR_VERSION=${MINOR_VERSION%%.$PATCH_VERSION}

if [ $MAJOR_VERSION -eq 1 ] && [ $PATCH_VERSION -le 9 ] && [ $MINOR_VERSION -eq $PATCH_VERSION ] ; then
  # download link was different before release 1.9
  echo "using older download link"
  URL="https://github.com/google/google-java-format/releases/download/google-java-format-${GOOGLE_JAVA_FORMAT_VERSION}/google-java-format-${GOOGLE_JAVA_FORMAT_VERSION}-all-deps.jar"
fi

if [ ! -f google-java-format-${GOOGLE_JAVA_FORMAT_VERSION}-all-deps.jar ]
then
    curl -LJO ${URL}
    chmod 755 google-java-format-${GOOGLE_JAVA_FORMAT_VERSION}-all-deps.jar
fi
cd ..

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" )
echo $changed_java_files
java -jar .cache/google-java-format-${GOOGLE_JAVA_FORMAT_VERSION}-all-deps.jar --replace $changed_java_files
