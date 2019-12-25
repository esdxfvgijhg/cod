

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 7.00.0555 */
/* at Fri Sep 26 13:30:35 2014
 */
/* Compiler settings for VWLicenseManager.idl:
    Oicf, W1, Zp8, env=Win32 (32b run), target_arch=X86 7.00.0555 
    protocol : dce , ms_ext, c_ext, robust
    error checks: allocation ref bounds_check enum stub_data 
    VC __declspec() decoration level: 
         __declspec(uuid()), __declspec(selectany), __declspec(novtable)
         DECLSPEC_UUID(), MIDL_INTERFACE()
*/
/* @@MIDL_FILE_HEADING(  ) */

#pragma warning( disable: 4049 )  /* more than 64k source lines */


/* verify that the <rpcndr.h> version is high enough to compile this file*/
#ifndef __REQUIRED_RPCNDR_H_VERSION__
#define __REQUIRED_RPCNDR_H_VERSION__ 475
#endif

#include "rpc.h"
#include "rpcndr.h"

#ifndef __RPCNDR_H_VERSION__
#error this stub requires an updated version of <rpcndr.h>
#endif // __RPCNDR_H_VERSION__

#ifndef COM_NO_WINDOWS_H
#include "windows.h"
#include "ole2.h"
#endif /*COM_NO_WINDOWS_H*/

#ifndef __midl_VWLicenseManager_h__
#define __midl_VWLicenseManager_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __ILicenseManager_FWD_DEFINED__
#define __ILicenseManager_FWD_DEFINED__
typedef interface ILicenseManager ILicenseManager;
#endif 	/* __ILicenseManager_FWD_DEFINED__ */


#ifndef __VWLicenseManager_FWD_DEFINED__
#define __VWLicenseManager_FWD_DEFINED__

#ifdef __cplusplus
typedef class VWLicenseManager VWLicenseManager;
#else
typedef struct VWLicenseManager VWLicenseManager;
#endif /* __cplusplus */

#endif 	/* __VWLicenseManager_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"

#ifdef __cplusplus
extern "C"{
#endif 


/* interface __MIDL_itf_VWLicenseManager_0000_0000 */
/* [local] */ 

//+-------------------------------------------------------------------------
//
//  VisualWorks: License Manager
//  Copyright (C) Cincom Systems, 2014.
//
//--------------------------------------------------------------------------


extern RPC_IF_HANDLE __MIDL_itf_VWLicenseManager_0000_0000_v0_0_c_ifspec;
extern RPC_IF_HANDLE __MIDL_itf_VWLicenseManager_0000_0000_v0_0_s_ifspec;

#ifndef __ILicenseManager_INTERFACE_DEFINED__
#define __ILicenseManager_INTERFACE_DEFINED__

/* interface ILicenseManager */
/* [unique][helpstring][uuid][object][oleautomation] */ 


EXTERN_C const IID IID_ILicenseManager;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("13467F22-554A-4C51-9ADB-1718AF5E9600")
    ILicenseManager : public IUnknown
    {
    public:
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE IsDevelopment( 
            /* [in] */ CLSID *clsid,
            /* [retval][out] */ BOOL *result) = 0;
        
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE CreateInstance( 
            /* [in] */ CLSID *class,
            /* [in] */ IUnknown *pUnkOuter,
            /* [in] */ REFIID riid,
            /* [in] */ BSTR license,
            /* [iid_is][retval][out] */ IUnknown **ppvObject) = 0;
        
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE QueryLicenseKey( 
            /* [in] */ CLSID *class,
            /* [retval][out] */ BSTR *result) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct ILicenseManagerVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            ILicenseManager * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            ILicenseManager * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            ILicenseManager * This);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *IsDevelopment )( 
            ILicenseManager * This,
            /* [in] */ CLSID *clsid,
            /* [retval][out] */ BOOL *result);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *CreateInstance )( 
            ILicenseManager * This,
            /* [in] */ CLSID *class,
            /* [in] */ IUnknown *pUnkOuter,
            /* [in] */ REFIID riid,
            /* [in] */ BSTR license,
            /* [iid_is][retval][out] */ IUnknown **ppvObject);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *QueryLicenseKey )( 
            ILicenseManager * This,
            /* [in] */ CLSID *class,
            /* [retval][out] */ BSTR *result);
        
        END_INTERFACE
    } ILicenseManagerVtbl;

    interface ILicenseManager
    {
        CONST_VTBL struct ILicenseManagerVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define ILicenseManager_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define ILicenseManager_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define ILicenseManager_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define ILicenseManager_IsDevelopment(This,clsid,result)	\
    ( (This)->lpVtbl -> IsDevelopment(This,clsid,result) ) 

#define ILicenseManager_CreateInstance(This,class,pUnkOuter,riid,license,ppvObject)	\
    ( (This)->lpVtbl -> CreateInstance(This,class,pUnkOuter,riid,license,ppvObject) ) 

#define ILicenseManager_QueryLicenseKey(This,class,result)	\
    ( (This)->lpVtbl -> QueryLicenseKey(This,class,result) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __ILicenseManager_INTERFACE_DEFINED__ */



#ifndef __VWLicenseManager_LIBRARY_DEFINED__
#define __VWLicenseManager_LIBRARY_DEFINED__

/* library VWLicenseManager */
/* [helpstring][version][lcid][uuid] */ 


EXTERN_C const IID LIBID_VWLicenseManager;

EXTERN_C const CLSID CLSID_VWLicenseManager;

#ifdef __cplusplus

class DECLSPEC_UUID("377410CF-6550-43B7-9DA0-C079B0D67E15")
VWLicenseManager;
#endif
#endif /* __VWLicenseManager_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

unsigned long             __RPC_USER  BSTR_UserSize(     unsigned long *, unsigned long            , BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserMarshal(  unsigned long *, unsigned char *, BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserUnmarshal(unsigned long *, unsigned char *, BSTR * ); 
void                      __RPC_USER  BSTR_UserFree(     unsigned long *, BSTR * ); 

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


