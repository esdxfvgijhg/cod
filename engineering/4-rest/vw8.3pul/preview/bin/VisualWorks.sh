#!/bin/sh
# vim: set filetype=sh:
##############################################################################
# Start a VisualWorks image.
#
# $Id$
##############################################################################
case `uname` in
	IRIX64)	_XPG=1;;
	HP-UX)	UNIX95=1;;
	SunOS)	PATH=/usr/xpg4/bin:$PATH
			VMGREP=/usr/bin/fgrep;;
	CYGWIN*) EXE='.exe';;
esac
: ${EXE:=''}

if [ "${LINENO:+set}" != set ] || (eval "i=$((1 + 0))"; test $? -ne 0)
then
	#echo "Warning: current shell is not POSIX shell...retrying" >&2
	[ -x /bin/ksh ] && eval 'exec /bin/ksh $0 "$@"'
	[ -x /bin/bash ] && eval 'exec /bin/bash $0 "$@"'
	echo "Could not find POSIX shell.  Rerun script using the command:" >&2
	echo "    posix_shell $0 $@" >&2
	exit 1
fi
##############################################################################
##############################################################################

MAXHOPS=30

RelToAbs () {
	for RelPath
	do
		Dir=`dirname "$RelPath"`
		Dir=`cd $Dir; pwd`
		# Work around for SOLARIS 2.5 ksh93 bug ("cd" prints new directory)
		Dir=`echo "$Dir" | sed q`
		case "$RelPath" in
			*/)	Base=`basename \`echo "$RelPath"\` | sed 's:/[/]*$::'`;;
			*)	Base=`basename "$RelPath"`;;
		esac
		echo "$Dir/$Base"
	done
}

Resolve () {
	for SymLink
	do
		L=`RelToAbs "$SymLink"`
		Ref="$L"
		HopCount=0
		(
		while [ -h "$L" ]
		do
			ParentDir=`dirname "$L"`
			if [ -z "$ParentDir" -o ! -d "$ParentDir" ] ; then
				echo "could not determine parent directory for $L" >&2
				return
			fi
			cd "$ParentDir"
			BaseName=`basename "$L"`
			if [ -z "$BaseName" ] ; then
				echo "could not determine basename for $L" >&2
				return
			fi

			# This will break for filenames with spaces...
			Ref=`ls -ld "$BaseName" | awk '{print $NF}'`
			if [ -n "$Ref" ]
			then
				if [ "$L" != "$Ref" ]
				then
					L="$Ref"
				else				# direct loop (i.e. "a -> a")
					echo "! loop detected - $Ref (`pwd`)" >&2
					return
				fi
			else
				echo "could not list link $L - should not occur" >&2
				return
			fi

			HopCount=`expr $HopCount + 1`
			if [ ${HopCount:=0} -gt $MAXHOPS ]
			then
				echo "! too many links (more than $MAXHOPS): $Ref (`pwd`)" >&2
				return
			fi
		done

		# Ref contains the last (relative) path of the symbolical
		# link chain
		if [ X`ls -d "$Ref" 2>/dev/null` != X ]
		then
			RelToAbs $Ref
		fi
		)
	done
}

getVISig() {
	v=`dd if="$1" bs=1 skip=68 count=4 2>/dev/null | od -b | sed -e 's/^[0-7]*[ ]*//'`
	vp=`for o in $v; do printf "%d:" "0$o"; done`
	echo "${vp%:}"
}

resolved=`Resolve "$0"`
iniFile=
IniNames() {
	bn="${1##*/}"
	dn="${1%/*}"
	for f in "$1.ini" "$dn/${bn%.*}.ini" "$dn/VisualWorks.ini"
	do
		[ -f "$f" ] && echo "$f"
	done
}
iniFile=`IniNames "$resolved" | head -n 1`

printVMOnly=no
createEntries=no
for o
do
	case "$o" in
		-=*) imageFile="${o#-=}" ;;
		-n)  printVMOnly=yes ;;
		-ne) createEntries=yes ;;
		-*)	;;
		*)   imageFile="$o" ;;
	esac
	[ -n "$imageFile" ] && break
done
[ -z "$imageFile" ] && { echo "Error: No image file found on command line." >&2; exit 1; }

viSig=`getVISig "$imageFile"`
v0=`expr $viSig : '\([0-9]*\):[0-9]*:[0-9]*:[0-9]*$'`
v1=`expr $viSig : '[0-9]*:\([0-9]*\):[0-9]*:[0-9]*$'`
v2=`expr $viSig : '[0-9]*:[0-9]*:\([0-9]*\):[0-9]*$'`
v3=`expr $viSig : '[0-9]*:[0-9]*:[0-9]*:\([0-9]*\)$'`

if [ $v1 -ge 128 ] ; then
	vi64bit=yes
	v1_32=`expr $v1 - 128`
	v1_64=$v1
	v1_alt=$v1_32
else
	vi64bit=no
	v1_32=$v1
	v1_64=`expr $v1 + 128`
	v1_alt=$v1_64
fi

if [ -f "$iniFile" ] ; then
entries=$(
	awk -v v0=$v0 -v v1=$v1 -v v1a=$v1_alt -v v2=$v2 -v v3=$v3 '
		$1 != v0 { next }
		$2 != v1 && $2 != v1a { next }
		$3 == v2 && $4 == v3 { $1=$2=$3=$4=""; print }
		v2 == 0 && v3 == 0 && $3 !~ /^[0-9]+$/ {$1=$2=""; print }
	' "$iniFile"
)
#	awk -v v0=$v0 -v v1=$v1 -v v2=$v2 -v v3=$v3 '
#		$1 == v0 && $2 == v1 && $3 == v2 && $4 == v3 { $1=$2=$3=$4=""; print }
#	' "$iniFile"
#
#	if expr $v2 + $v3 == 0 >/dev/null ; then
#		awk -v v0=$v0 -v v1=$v1 '
#			$1 == v0 && $2 == v1 && $3 !~ /^[0-9]+$/ { $1=$2=""; print }
#		' "$iniFile"
#	fi
#)
fi

createEntriesFor() {
	[ $# -eq 0 ] && return
	#echo "Creating entries for: '$1'" >&2
	for f in $1/bin/*/visual $1/bin/unsupported/*/visual
	do
		#echo "   * $f?$1" >&2
		echo "$f${EXE}?$1"
	done
}
if [ "x$entries" = x ] ; then
	vwhome=`expr "$imageFile" : '\(.*\)/image/[^./]*\.im$'`
	entries="`createEntriesFor $vwhome`"
else
	entries=$(
	IFS="
	"
	for entry in $entries
	do
		vm=`expr "$entry" : '[ ]*\([^?]*\)'`
		if [ -d "$vm" -a -f "$vm/image/visual.im" ]
		then
			#echo "  dir:$vm" >&2
			createEntriesFor $vm
		else
			#echo "  def:$vm:$entry" >&2
			echo $entry
		fi
	done
	)
fi

if [ "x$entries" = x ] ; then
	echo "No entries found for VI signature $v0/$v1/$v2/$v3" >&2
	exit 1
fi


oifs="$IFS"
IFS="
"
for entry in $entries
do
	#echo "entry='$entry'"
	vm=`expr "$entry" : '[ ]*\([^?]*\)'`
	VISUALWORKS=`expr "$entry" : '[^?]*[?]\(.*\)$'`
	[ -x "$vm" ] || continue
	#echo "vm='$vm'"
	# This is questionable because the SGI VM contains
	# both the 64-bit and 32-bit strings...
	vm64bit=yes
	${VMGREP:=fgrep} 'The VM is 32-bit' "$vm" >/dev/null  && vm64bit=no

	[ -d "$VISUALWORKS" ] && export VISUALWORKS
	if [ $createEntries = yes ]
	then
		v1_arg=$v1_32
		[ $vm64bit = yes ] && v1_arg=$v1_64
		printf "%d %02d %02d %02d %s\n" $v0 $v1_arg $v2 $v3 "$entry"
		continue
	fi
	[ $vi64bit = $vm64bit ] || continue
	( exec "$vm" -v ) >/dev/null 2>&1 || continue
	if [ $printVMOnly = yes ] ; then
		echo "$vm"
		exit 0
	fi
	exec "$vm" "$@"
done

exit 10

