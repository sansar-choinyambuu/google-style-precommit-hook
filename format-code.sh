#!/usr/bin/env sh

GOOGLE_JAVA_FORMAT_VERSION="1.7"

usage() { echo "Usage: $0 [-v <version>]" 1>&2; exit 1; }
while getopts ':v:' o; do
  case $o in
    v) GOOGLE_JAVA_FORMAT_VERSION=$OPTARG ;;
    *) usage ;;
  esac
done

mkdir -p .cache
cd .cache
if [ ! -f google-java-format-${GOOGLE_JAVA_FORMAT_VERSION}-all-deps.jar ]
then
    curl -LJO "https://github.com/google/google-java-format/releases/download/v${GOOGLE_JAVA_FORMAT_VERSION}/google-java-format-${GOOGLE_JAVA_FORMAT_VERSION}-all-deps.jar"
    chmod 755 google-java-format-${GOOGLE_JAVA_FORMAT_VERSION}-all-deps.jar
fi
cd ..

changed_java_files=$(git diff --cached --name-only --diff-filter=ACMR | grep ".*java$" )
echo $changed_java_files
java -jar .cache/google-java-format-${GOOGLE_JAVA_FORMAT_VERSION}-all-deps.jar --replace $changed_java_files
