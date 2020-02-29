REM Build the type library for the VisualWorks OLESmalltalkCommander class
del vwstcom.log
MIDL Dual_vwstcom.idl @vwstcom.rsp
start notepad vwstcom.log

