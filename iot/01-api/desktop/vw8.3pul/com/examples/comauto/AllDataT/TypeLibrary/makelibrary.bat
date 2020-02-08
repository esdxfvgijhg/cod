REM Build the type library for the 
REM VisualWorks COMAutomationAllDataTypes class with a dual interface
del vwalldt.log
MIDL vwalldt.idl @vwalldt.rsp
start notepad vwalldt.log
