# common functions

# print a ERROR message
printERROR() {
	echo "ERROR: $@" >&2
}

# print a WARNING message
printWARNING() {
	echo "WARNING: $@" >&2
}

# print a USEAGE message
printUSAGE() {
	echo "USAGE: $@"
	exit 1
}

# prompt for a YESNO answer
promptYESNO() {
	if [ $# -lt 1 ]; then
		printERROR "More Arguements Required."
		retrun 1
	fi

	DEF_ARG=''
	YESNO=''

	case "$2" in
		[Yy]|[Yy][Ee][Ss])
		DEF_ARG='y';;
		[Nn]|[Nn][Oo])
		DEF_ARG='n';;
	esac

	while :; do
		printf "$1 (y/n)? "
		if [ -n "$DEF_ARG" ]; then
			printf "[$DEF_ARG]"
		fi
		read YESNO
		if [ -z "$YESNO" ]; then
			YESNO="$DEF_ARG"
		fi
		case "$YESNO" in
			[Yy]|[Yy][Ee][Ss])
			YESNO=y; break;;
			[Nn]|[Nn][Oo])
			YESNO=n; break;;
			*)
			YESNO='';;
		esac
	done

	export YESNO
	unset DEF_ARG
}

# prompt for user input
promptRESPONSE() {
	if [ $# -lt 1 ]; then
		printERROR "More Arguements Required."
		retrun 1
	fi

	RESPONSE=''
	DEF_ARG="$2"

	while :; do
		printf "$1? "
		if [ -n "$DEF_ARG" ]; then
			printf "$DEF_ARG"
		fi
		read RESPONSE

		if [ -n "$RESPONSE" ]; then
			break;
		elif [ -z "$RESPONSE" -a -n "$DEF_ARG" ]; then
			RESPONSE="$DEF_ARG"
			break;
		fi
	done

	export RESPONSE
	unset DEF_ARG
}

# check disk free space
getSpaceFree() {
	if [ $# -lt 1 ]; then
		printERROR "More Arguements Required."
		return 1
	fi
	if [ ! -d "$1" ]; then
		printERROR "$1 is not a directory."
		return 1
	fi
	df -k "$1" | awk 'NR!=1{print $4;}'
}

# check directory space used
getSpaceUsed() {
	if [ $# -lt 1 ]; then
		printERROR "More Arguements Required."
		return 1
	fi
	if [ ! -d "$1" ]; then
		printERROR "$1 is not a directory."
		return 1
	fi
	du -sk "$1" | awk '{print $1;}'
}
#get user id via user name
getUID() {
	id $1 | sed 's/.*uid=\([0-9][0-9]*\)[^0-9].*$/\1/'
}

# get OS Name
getOSName() {
	case "`uname -s`" in
		*BSD) echo bsd;;
		SunOS)
			case "`uname -r`" in
				5.*) echo solaris;;
				*)   echo sunos;;

			esac
		;;
		Linux) echo linux;;
		HP-UX) echo hpux;;
		AIX)   echo aix;;
		SCO*)  echo sco;;
		*)     echo unknown;;
	esac
}

# check OS Type
isOS() {
	if [ $# -ne 1 ]; then
		echo 'There must be 1 argument.' >&2
		exit 1
	fi
	if [ "`echo $1|tr '[:upper:]' '[:lower:]'`" = "`getOSName`" ]; then
		return 0
	fi
	return 1
}
# get process id via process name
getPID() {
	if [ $# -lt 1 ]; then
		printERROR "More Arguements Required."
		return 1
	fi
	case "`getOSName`" in
		bsd|sunos)
		ps -aux | grep "$1" | grep -v grep | awk '{print $2;}';;
		*)
		ps -ef | grep "$1" | grep -v grep | awk '{print $2;}';;
	esac
}

