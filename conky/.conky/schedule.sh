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
echo $(pwd)

cd "${RUNDIR}/calendar"
conky -d -c calendar.rc 

cd "${RUNDIR}/todo"
conky -d -c todo.rc 

#Bit of a resource hog. Disabled for Eee machine.
#cd "${RUNDIR}/air_clock"
#conky -d -c air_clock.rc

exit 0
