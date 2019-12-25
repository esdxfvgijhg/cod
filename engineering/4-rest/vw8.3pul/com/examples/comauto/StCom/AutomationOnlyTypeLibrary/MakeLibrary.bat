REM Build the type library for the VisualWorks OLESmalltalkCommander class
del vwstcom.log
MIDL vwstcom.idl @vwstcom.rsp
start notepad vwstcom.log

