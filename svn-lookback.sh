#!/bin/bash

display_usage() {
	echo "Find an SVN revision that occurred <limit> revisions ago."
	echo "    Usage:"
	echo ""
	echo "    $0 -u <SVN url> -l <limit>"
	echo ""
	echo "    # Example: Find 500 revisions ago from HEAD"
	echo ""
	echo "    $0 -u https://svn/proj/trunk -l 500"
	echo ""
	echo "    # Example: Find 4 revisions before 9871"
	echo ""
	echo "    $0 -u https://svn/proj/trunk@9871 -l 4"
}

if [  $# -le 1 ] 
then 
	display_usage
	exit 1
fi 

while [[ $# > 1 ]]
do

	key="$1"

	case $key in
		-l|--limit)
		REV_COUNT="$2"
		shift
		;;
		-u|--url)
		SVN_URL="$2"
		shift
		;;
		*)
		
		;;
	esac
shift
done

# echo "Looking back ${REV_COUNT} revisions in ${SVN_URL}"

FIRST_REV=`svn log ${SVN_URL} -rHEAD:1 --limit=${REV_COUNT} | tac | grep -m 1 '^\(r\)[0-9]\{1,\}' | cut -f 1 -d " " | tail -c +2`

echo ${FIRST_REV}