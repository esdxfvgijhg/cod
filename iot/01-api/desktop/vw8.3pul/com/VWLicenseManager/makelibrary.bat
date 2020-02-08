REM Build the type library for the 
REM VWLicenseManager
del VWLicenseManager.log
MIDL VWLicenseManager.idl @VWLicenseManager.rsp
start notepad VWLicenseManager.log
