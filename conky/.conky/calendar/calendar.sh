#!/bin/sh

##############################################################################
# Get the real directory, where is located executable file
case `uname` in
"FreeBSD" )
	if [ $( readlink ${0} ) ]; then
		RUNDIR=$( realpath $( dirname $( readlink ${0} ) ) )
	else
		RUNDIR=$( realpath $( dirname ${0} ) )
	fi
;;
"Linux" )
	RUNDIR=$( dirname $( readlink -f ${0} ) )
;;
esac
##############################################################################

INTERVAL=${1:-20}

cd ${RUNDIR}

sleep ${INTERVAL}

conky -c calendar.rc &

exit 0
