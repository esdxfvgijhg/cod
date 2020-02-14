PATH="/usr/local/bin:$PATH"
if [ "x$LD_LIBRARY_PATH" = "x" ] ; then
	LD_LIBRARY_PATH="/usr/local/lib"
else
	LD_LIBRARY_PATH="/usr/local/lib:$LD_LIBRARY_PATH"
fi
export LD_LIBRARY_PATH
PKG_CONFIG_PATH="/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"; export PKG_CONFIG_PATH
MANPATH=":/usr/local/share/man:$MANPATH"; export MANPATH
ACLOCAL="${ACLOCAL:-aclocal} -I /usr/local/share/aclocal"; export ACLOCAL

