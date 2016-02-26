#!/bin/bash

display_usage() {
	echo "Perform a git svn clone based on the last <limit> revisions of the SVN repo."
	echo "    Usage:"
	echo ""
	echo "    $0 -u <SVN url> -l <limit>"
	echo ""
	echo "    # Example: Clone just the last 500 revisions from the SVN HEAD"
	echo ""
	echo "    $0 -u https://svn/proj/trunk -l 500"
	echo ""
	echo "    # Example: Clone starting from 4 revisions before SVN r9871"
	echo ""
	echo "    $0 -u https://svn/proj/trunk@9871 -l 4"
	echo ""
	echo "    # Example: Clone last 20 revisions into mydir"
	echo ""
	echo "    $0 -u https://svn/proj/trunk -l 20 -o mydir --authors-file=svn-auth.txt"
}

if [  $# -le 1 ] 
then 
	display_usage
	exit 1
fi 

while [[ $# > 0 ]]
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
		-o|--output)
		OUTPUT="$2"
		shift
		;;
		*)
		REMAINING="${REMAINING} ${1}"
		;;
	esac
	shift
done

MYDIR="$(dirname "$(realpath "$0")")"

FIRST_REV=$( source ${MYDIR}/svn-lookback.sh -u ${SVN_URL} -l ${REV_COUNT} )

echo "Executing: "
echo "    git svn clone ${REMAINING} -r${FIRST_REV}:HEAD ${SVN_URL} ${OUTPUT}"
git svn clone ${REMAINING} -r${FIRST_REV}:HEAD ${SVN_URL} ${OUTPUT}
