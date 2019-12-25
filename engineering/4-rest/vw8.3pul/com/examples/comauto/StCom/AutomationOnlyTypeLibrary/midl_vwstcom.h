

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 7.00.0555 */
/* at Fri Sep 26 13:29:36 2014
 */
/* Compiler settings for vwstcom.idl:
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

#ifndef __midl_vwstcom_h__
#define __midl_vwstcom_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __ISmalltalkCommanderDispVtbl_FWD_DEFINED__
#define __ISmalltalkCommanderDispVtbl_FWD_DEFINED__
typedef interface ISmalltalkCommanderDispVtbl ISmalltalkCommanderDispVtbl;
#endif 	/* __ISmalltalkCommanderDispVtbl_FWD_DEFINED__ */


#ifndef __ISmalltalkCommanderDisp_FWD_DEFINED__
#define __ISmalltalkCommanderDisp_FWD_DEFINED__
typedef interface ISmalltalkCommanderDisp ISmalltalkCommanderDisp;
#endif 	/* __ISmalltalkCommanderDisp_FWD_DEFINED__ */


#ifndef __VWSmalltalkCommander_FWD_DEFINED__
#define __VWSmalltalkCommander_FWD_DEFINED__

#ifdef __cplusplus
typedef class VWSmalltalkCommander VWSmalltalkCommander;
#else
typedef struct VWSmalltalkCommander VWSmalltalkCommander;
#endif /* __cplusplus */

#endif 	/* __VWSmalltalkCommander_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"

#ifdef __cplusplus
extern "C"{
#endif 


/* interface __MIDL_itf_vwstcom_0000_0000 */
/* [local] */ 

//+-------------------------------------------------------------------------
//
//  VisualWorks Automation: Smalltalk Commander Example
//  Created by Gary Gregory
//  Copyright (C) ParcPlace-Digitalk, 1997.
//
//--------------------------------------------------------------------------


extern RPC_IF_HANDLE __MIDL_itf_vwstcom_0000_0000_v0_0_c_ifspec;
extern RPC_IF_HANDLE __MIDL_itf_vwstcom_0000_0000_v0_0_s_ifspec;

#ifndef __ISmalltalkCommanderDispVtbl_INTERFACE_DEFINED__
#define __ISmalltalkCommanderDispVtbl_INTERFACE_DEFINED__

/* interface ISmalltalkCommanderDispVtbl */
/* [oleautomation][unique][helpstring][uuid][object] */ 


EXTERN_C const IID IID_ISmalltalkCommanderDispVtbl;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("C9594220-F715-11d0-A791-00A024CD45B2")
    ISmalltalkCommanderDispVtbl : public IDispatch
    {
    public:
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE Evaluate( 
            /* [in] */ BSTR Expression,
            /* [retval][out] */ VARIANT *retval) = 0;
        
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE EvaluateAsString( 
            /* [in] */ BSTR Expression,
            /* [retval][out] */ BSTR *retval) = 0;
        
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE Quit( void) = 0;
        
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE GetLastError( 
            /* [retval][out] */ BSTR *retval) = 0;
        
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE GetLastErrorStack( 
            /* [retval][out] */ BSTR *retval) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_AnswerErrors( 
            /* [in] */ VARIANT_BOOL Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_AnswerErrors( 
            /* [retval][out] */ VARIANT_BOOL *Value) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct ISmalltalkCommanderDispVtblVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            ISmalltalkCommanderDispVtbl * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            ISmalltalkCommanderDispVtbl * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            ISmalltalkCommanderDispVtbl * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            ISmalltalkCommanderDispVtbl * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            ISmalltalkCommanderDispVtbl * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            ISmalltalkCommanderDispVtbl * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            ISmalltalkCommanderDispVtbl * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *Evaluate )( 
            ISmalltalkCommanderDispVtbl * This,
            /* [in] */ BSTR Expression,
            /* [retval][out] */ VARIANT *retval);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *EvaluateAsString )( 
            ISmalltalkCommanderDispVtbl * This,
            /* [in] */ BSTR Expression,
            /* [retval][out] */ BSTR *retval);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *Quit )( 
            ISmalltalkCommanderDispVtbl * This);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *GetLastError )( 
            ISmalltalkCommanderDispVtbl * This,
            /* [retval][out] */ BSTR *retval);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *GetLastErrorStack )( 
            ISmalltalkCommanderDispVtbl * This,
            /* [retval][out] */ BSTR *retval);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_AnswerErrors )( 
            ISmalltalkCommanderDispVtbl * This,
            /* [in] */ VARIANT_BOOL Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_AnswerErrors )( 
            ISmalltalkCommanderDispVtbl * This,
            /* [retval][out] */ VARIANT_BOOL *Value);
        
        END_INTERFACE
    } ISmalltalkCommanderDispVtblVtbl;

    interface ISmalltalkCommanderDispVtbl
    {
        CONST_VTBL struct ISmalltalkCommanderDispVtblVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define ISmalltalkCommanderDispVtbl_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define ISmalltalkCommanderDispVtbl_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define ISmalltalkCommanderDispVtbl_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define ISmalltalkCommanderDispVtbl_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define ISmalltalkCommanderDispVtbl_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define ISmalltalkCommanderDispVtbl_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define ISmalltalkCommanderDispVtbl_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define ISmalltalkCommanderDispVtbl_Evaluate(This,Expression,retval)	\
    ( (This)->lpVtbl -> Evaluate(This,Expression,retval) ) 

#define ISmalltalkCommanderDispVtbl_EvaluateAsString(This,Expression,retval)	\
    ( (This)->lpVtbl -> EvaluateAsString(This,Expression,retval) ) 

#define ISmalltalkCommanderDispVtbl_Quit(This)	\
    ( (This)->lpVtbl -> Quit(This) ) 

#define ISmalltalkCommanderDispVtbl_GetLastError(This,retval)	\
    ( (This)->lpVtbl -> GetLastError(This,retval) ) 

#define ISmalltalkCommanderDispVtbl_GetLastErrorStack(This,retval)	\
    ( (This)->lpVtbl -> GetLastErrorStack(This,retval) ) 

#define ISmalltalkCommanderDispVtbl_put_AnswerErrors(This,Value)	\
    ( (This)->lpVtbl -> put_AnswerErrors(This,Value) ) 

#define ISmalltalkCommanderDispVtbl_get_AnswerErrors(This,Value)	\
    ( (This)->lpVtbl -> get_AnswerErrors(This,Value) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __ISmalltalkCommanderDispVtbl_INTERFACE_DEFINED__ */



#ifndef __VWSTCOM_LIBRARY_DEFINED__
#define __VWSTCOM_LIBRARY_DEFINED__

/* library VWSTCOM */
/* [helpstring][version][lcid][uuid] */ 


EXTERN_C const IID LIBID_VWSTCOM;

EXTERN_C const CLSID CLSID_VWSmalltalkCommander;

#ifdef __cplusplus

class DECLSPEC_UUID("5FD2D2B1-95A8-11d0-ACAB-E80467000000")
VWSmalltalkCommander;
#endif
#endif /* __VWSTCOM_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

unsigned long             __RPC_USER  BSTR_UserSize(     unsigned long *, unsigned long            , BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserMarshal(  unsigned long *, unsigned char *, BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserUnmarshal(unsigned long *, unsigned char *, BSTR * ); 
void                      __RPC_USER  BSTR_UserFree(     unsigned long *, BSTR * ); 

unsigned long             __RPC_USER  VARIANT_UserSize(     unsigned long *, unsigned long            , VARIANT * ); 
unsigned char * __RPC_USER  VARIANT_UserMarshal(  unsigned long *, unsigned char *, VARIANT * ); 
unsigned char * __RPC_USER  VARIANT_UserUnmarshal(unsigned long *, unsigned char *, VARIANT * ); 
void                      __RPC_USER  VARIANT_UserFree(     unsigned long *, VARIANT * ); 

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


