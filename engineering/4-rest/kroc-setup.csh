if ( $?PATH ) then
	setenv PATH "/usr/local/bin:$PATH"
else
	setenv PATH "/usr/local/bin"
endif
if ( $?MANPATH ) then
	setenv MANPATH ":/usr/local/share/man:$MANPATH"
else
	setenv MANPATH ":/usr/local/share/man"
endif
if ( $?LD_LIBRARY_PATH ) then
	setenv LD_LIBRARY_PATH "/usr/local/lib:$LD_LIBRARY_PATH"
else
	setenv LD_LIBRARY_PATH "/usr/local/lib"
endif
if ( $?PKG_CONFIG_PATH ) then
	setenv PKG_CONFIG_PATH "/usr/local/lib/pkgconfig:$PKG_CONFIG_PATH"
else
	setenv PKG_CONFIG_PATH "/usr/local/lib/pkgconfig"
endif
if ( $?ACLOCAL ) then
	setenv ACLOCAL "$ACLOCAL -I /usr/local/share/aclocal"
else
	setenv ACLOCAL "aclocal -I /usr/local/share/aclocal"
endif
