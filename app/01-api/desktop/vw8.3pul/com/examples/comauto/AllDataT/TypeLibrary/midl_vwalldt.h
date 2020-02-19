

/* this ALWAYS GENERATED file contains the definitions for the interfaces */


 /* File created by MIDL compiler version 7.00.0555 */
/* at Fri Sep 26 13:30:07 2014
 */
/* Compiler settings for vwalldt.idl:
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

#ifndef __midl_vwalldt_h__
#define __midl_vwalldt_h__

#if defined(_MSC_VER) && (_MSC_VER >= 1020)
#pragma once
#endif

/* Forward Declarations */ 

#ifndef __IAllDataTypesDisp_FWD_DEFINED__
#define __IAllDataTypesDisp_FWD_DEFINED__
typedef interface IAllDataTypesDisp IAllDataTypesDisp;
#endif 	/* __IAllDataTypesDisp_FWD_DEFINED__ */


#ifndef __IAllDataTypesAuto_FWD_DEFINED__
#define __IAllDataTypesAuto_FWD_DEFINED__
typedef interface IAllDataTypesAuto IAllDataTypesAuto;
#endif 	/* __IAllDataTypesAuto_FWD_DEFINED__ */


#ifndef __VWAllDataTypesAuto_FWD_DEFINED__
#define __VWAllDataTypesAuto_FWD_DEFINED__

#ifdef __cplusplus
typedef class VWAllDataTypesAuto VWAllDataTypesAuto;
#else
typedef struct VWAllDataTypesAuto VWAllDataTypesAuto;
#endif /* __cplusplus */

#endif 	/* __VWAllDataTypesAuto_FWD_DEFINED__ */


#ifndef __VWAllDataTypes_FWD_DEFINED__
#define __VWAllDataTypes_FWD_DEFINED__

#ifdef __cplusplus
typedef class VWAllDataTypes VWAllDataTypes;
#else
typedef struct VWAllDataTypes VWAllDataTypes;
#endif /* __cplusplus */

#endif 	/* __VWAllDataTypes_FWD_DEFINED__ */


/* header files for imported files */
#include "oaidl.h"

#ifdef __cplusplus
extern "C"{
#endif 


/* interface __MIDL_itf_vwalldt_0000_0000 */
/* [local] */ 

//+-------------------------------------------------------------------------
//
//  VisualWorks Automation: All Data Types Example
//  Created by Gary Gregory
//  Copyright (C) ParcPlace-Digitalk, 1997.
//
//--------------------------------------------------------------------------


extern RPC_IF_HANDLE __MIDL_itf_vwalldt_0000_0000_v0_0_c_ifspec;
extern RPC_IF_HANDLE __MIDL_itf_vwalldt_0000_0000_v0_0_s_ifspec;

#ifndef __IAllDataTypesDisp_INTERFACE_DEFINED__
#define __IAllDataTypesDisp_INTERFACE_DEFINED__

/* interface IAllDataTypesDisp */
/* [oleautomation][dual][unique][helpstring][uuid][object] */ 


EXTERN_C const IID IID_IAllDataTypesDisp;

#if defined(__cplusplus) && !defined(CINTERFACE)
    
    MIDL_INTERFACE("DB5DE8E2-AD1F-11d0-ACBE-5E86B1000000")
    IAllDataTypesDisp : public IDispatch
    {
    public:
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_LONGValue( 
            /* [in] */ LONG Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_LONGValue( 
            /* [retval][out] */ LONG *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_BYTEValue( 
            /* [in] */ BYTE Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_BYTEValue( 
            /* [retval][out] */ BYTE *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_SHORTValue( 
            /* [in] */ SHORT Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_SHORTValue( 
            /* [retval][out] */ SHORT *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_FLOATValue( 
            /* [in] */ FLOAT Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_FLOATValue( 
            /* [retval][out] */ FLOAT *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_DOUBLEValue( 
            /* [in] */ DOUBLE Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_DOUBLEValue( 
            /* [retval][out] */ DOUBLE *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_VARIANT_BOOLValue( 
            /* [in] */ VARIANT_BOOL Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_VARIANT_BOOLValue( 
            /* [retval][out] */ VARIANT_BOOL *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_SCODEValue( 
            /* [in] */ SCODE Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_SCODEValue( 
            /* [retval][out] */ SCODE *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_DATEValue( 
            /* [in] */ DATE Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_DATEValue( 
            /* [retval][out] */ DATE *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_BSTRValue( 
            /* [in] */ BSTR Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_BSTRValue( 
            /* [retval][out] */ BSTR *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_IUnknownReference( 
            /* [in] */ IUnknown *Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_IUnknownReference( 
            /* [retval][out] */ IUnknown **Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_IDispatchReference( 
            /* [in] */ IDispatch *Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_IDispatchReference( 
            /* [retval][out] */ IDispatch **Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_VARIANTValue( 
            /* [in] */ VARIANT Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_VARIANTValue( 
            /* [retval][out] */ VARIANT *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_CURRENCYValue( 
            /* [in] */ CURRENCY Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_CURRENCYValue( 
            /* [retval][out] */ CURRENCY *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_SAFEARRAY_I4Value( 
            /* [in] */ SAFEARRAY * Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_SAFEARRAY_I4Value( 
            /* [retval][out] */ SAFEARRAY * *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_SAFEARRAY_DISPATCHValue( 
            /* [in] */ SAFEARRAY * Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_SAFEARRAY_DISPATCHValue( 
            /* [retval][out] */ SAFEARRAY * *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_SAFEARRAY_UNKNOWNValue( 
            /* [in] */ SAFEARRAY * Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_SAFEARRAY_UNKNOWNValue( 
            /* [retval][out] */ SAFEARRAY * *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_SAFEARRAY_BSTRValue( 
            /* [in] */ SAFEARRAY * Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_SAFEARRAY_BSTRValue( 
            /* [retval][out] */ SAFEARRAY * *Value) = 0;
        
        virtual /* [helpstring][propput] */ HRESULT STDMETHODCALLTYPE put_SAFEARRAY_VARIANTValue( 
            /* [in] */ SAFEARRAY * Value) = 0;
        
        virtual /* [propget] */ HRESULT STDMETHODCALLTYPE get_SAFEARRAY_VARIANTValue( 
            /* [retval][out] */ SAFEARRAY * *Value) = 0;
        
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE Quit( void) = 0;
        
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE Reset( void) = 0;
        
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE ManyArguments( 
            /* [in] */ IDispatch *AnIDispatch,
            /* [in] */ BSTR PropertyName,
            /* [in] */ LONG Number,
            /* [retval][out] */ VARIANT *Value) = 0;
        
        virtual /* [helpstring] */ HRESULT STDMETHODCALLTYPE ManyByRefArguments( 
            /* [out] */ IDispatch **AnIDispatch,
            /* [out] */ BSTR *PropertyName,
            /* [out][in] */ LONG *Number,
            /* [out][in] */ VARIANT *Value) = 0;
        
    };
    
#else 	/* C style interface */

    typedef struct IAllDataTypesDispVtbl
    {
        BEGIN_INTERFACE
        
        HRESULT ( STDMETHODCALLTYPE *QueryInterface )( 
            IAllDataTypesDisp * This,
            /* [in] */ REFIID riid,
            /* [annotation][iid_is][out] */ 
            __RPC__deref_out  void **ppvObject);
        
        ULONG ( STDMETHODCALLTYPE *AddRef )( 
            IAllDataTypesDisp * This);
        
        ULONG ( STDMETHODCALLTYPE *Release )( 
            IAllDataTypesDisp * This);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfoCount )( 
            IAllDataTypesDisp * This,
            /* [out] */ UINT *pctinfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetTypeInfo )( 
            IAllDataTypesDisp * This,
            /* [in] */ UINT iTInfo,
            /* [in] */ LCID lcid,
            /* [out] */ ITypeInfo **ppTInfo);
        
        HRESULT ( STDMETHODCALLTYPE *GetIDsOfNames )( 
            IAllDataTypesDisp * This,
            /* [in] */ REFIID riid,
            /* [size_is][in] */ LPOLESTR *rgszNames,
            /* [range][in] */ UINT cNames,
            /* [in] */ LCID lcid,
            /* [size_is][out] */ DISPID *rgDispId);
        
        /* [local] */ HRESULT ( STDMETHODCALLTYPE *Invoke )( 
            IAllDataTypesDisp * This,
            /* [in] */ DISPID dispIdMember,
            /* [in] */ REFIID riid,
            /* [in] */ LCID lcid,
            /* [in] */ WORD wFlags,
            /* [out][in] */ DISPPARAMS *pDispParams,
            /* [out] */ VARIANT *pVarResult,
            /* [out] */ EXCEPINFO *pExcepInfo,
            /* [out] */ UINT *puArgErr);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_LONGValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ LONG Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_LONGValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ LONG *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BYTEValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ BYTE Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_BYTEValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ BYTE *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SHORTValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ SHORT Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_SHORTValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ SHORT *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_FLOATValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ FLOAT Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_FLOATValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ FLOAT *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DOUBLEValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ DOUBLE Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_DOUBLEValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ DOUBLE *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_VARIANT_BOOLValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ VARIANT_BOOL Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_VARIANT_BOOLValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ VARIANT_BOOL *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SCODEValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ SCODE Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_SCODEValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ SCODE *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_DATEValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ DATE Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_DATEValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ DATE *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_BSTRValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ BSTR Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_BSTRValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ BSTR *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_IUnknownReference )( 
            IAllDataTypesDisp * This,
            /* [in] */ IUnknown *Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_IUnknownReference )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ IUnknown **Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_IDispatchReference )( 
            IAllDataTypesDisp * This,
            /* [in] */ IDispatch *Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_IDispatchReference )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ IDispatch **Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_VARIANTValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ VARIANT Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_VARIANTValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ VARIANT *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_CURRENCYValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ CURRENCY Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_CURRENCYValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ CURRENCY *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SAFEARRAY_I4Value )( 
            IAllDataTypesDisp * This,
            /* [in] */ SAFEARRAY * Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_SAFEARRAY_I4Value )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ SAFEARRAY * *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SAFEARRAY_DISPATCHValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ SAFEARRAY * Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_SAFEARRAY_DISPATCHValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ SAFEARRAY * *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SAFEARRAY_UNKNOWNValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ SAFEARRAY * Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_SAFEARRAY_UNKNOWNValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ SAFEARRAY * *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SAFEARRAY_BSTRValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ SAFEARRAY * Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_SAFEARRAY_BSTRValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ SAFEARRAY * *Value);
        
        /* [helpstring][propput] */ HRESULT ( STDMETHODCALLTYPE *put_SAFEARRAY_VARIANTValue )( 
            IAllDataTypesDisp * This,
            /* [in] */ SAFEARRAY * Value);
        
        /* [propget] */ HRESULT ( STDMETHODCALLTYPE *get_SAFEARRAY_VARIANTValue )( 
            IAllDataTypesDisp * This,
            /* [retval][out] */ SAFEARRAY * *Value);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *Quit )( 
            IAllDataTypesDisp * This);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *Reset )( 
            IAllDataTypesDisp * This);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *ManyArguments )( 
            IAllDataTypesDisp * This,
            /* [in] */ IDispatch *AnIDispatch,
            /* [in] */ BSTR PropertyName,
            /* [in] */ LONG Number,
            /* [retval][out] */ VARIANT *Value);
        
        /* [helpstring] */ HRESULT ( STDMETHODCALLTYPE *ManyByRefArguments )( 
            IAllDataTypesDisp * This,
            /* [out] */ IDispatch **AnIDispatch,
            /* [out] */ BSTR *PropertyName,
            /* [out][in] */ LONG *Number,
            /* [out][in] */ VARIANT *Value);
        
        END_INTERFACE
    } IAllDataTypesDispVtbl;

    interface IAllDataTypesDisp
    {
        CONST_VTBL struct IAllDataTypesDispVtbl *lpVtbl;
    };

    

#ifdef COBJMACROS


#define IAllDataTypesDisp_QueryInterface(This,riid,ppvObject)	\
    ( (This)->lpVtbl -> QueryInterface(This,riid,ppvObject) ) 

#define IAllDataTypesDisp_AddRef(This)	\
    ( (This)->lpVtbl -> AddRef(This) ) 

#define IAllDataTypesDisp_Release(This)	\
    ( (This)->lpVtbl -> Release(This) ) 


#define IAllDataTypesDisp_GetTypeInfoCount(This,pctinfo)	\
    ( (This)->lpVtbl -> GetTypeInfoCount(This,pctinfo) ) 

#define IAllDataTypesDisp_GetTypeInfo(This,iTInfo,lcid,ppTInfo)	\
    ( (This)->lpVtbl -> GetTypeInfo(This,iTInfo,lcid,ppTInfo) ) 

#define IAllDataTypesDisp_GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId)	\
    ( (This)->lpVtbl -> GetIDsOfNames(This,riid,rgszNames,cNames,lcid,rgDispId) ) 

#define IAllDataTypesDisp_Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr)	\
    ( (This)->lpVtbl -> Invoke(This,dispIdMember,riid,lcid,wFlags,pDispParams,pVarResult,pExcepInfo,puArgErr) ) 


#define IAllDataTypesDisp_put_LONGValue(This,Value)	\
    ( (This)->lpVtbl -> put_LONGValue(This,Value) ) 

#define IAllDataTypesDisp_get_LONGValue(This,Value)	\
    ( (This)->lpVtbl -> get_LONGValue(This,Value) ) 

#define IAllDataTypesDisp_put_BYTEValue(This,Value)	\
    ( (This)->lpVtbl -> put_BYTEValue(This,Value) ) 

#define IAllDataTypesDisp_get_BYTEValue(This,Value)	\
    ( (This)->lpVtbl -> get_BYTEValue(This,Value) ) 

#define IAllDataTypesDisp_put_SHORTValue(This,Value)	\
    ( (This)->lpVtbl -> put_SHORTValue(This,Value) ) 

#define IAllDataTypesDisp_get_SHORTValue(This,Value)	\
    ( (This)->lpVtbl -> get_SHORTValue(This,Value) ) 

#define IAllDataTypesDisp_put_FLOATValue(This,Value)	\
    ( (This)->lpVtbl -> put_FLOATValue(This,Value) ) 

#define IAllDataTypesDisp_get_FLOATValue(This,Value)	\
    ( (This)->lpVtbl -> get_FLOATValue(This,Value) ) 

#define IAllDataTypesDisp_put_DOUBLEValue(This,Value)	\
    ( (This)->lpVtbl -> put_DOUBLEValue(This,Value) ) 

#define IAllDataTypesDisp_get_DOUBLEValue(This,Value)	\
    ( (This)->lpVtbl -> get_DOUBLEValue(This,Value) ) 

#define IAllDataTypesDisp_put_VARIANT_BOOLValue(This,Value)	\
    ( (This)->lpVtbl -> put_VARIANT_BOOLValue(This,Value) ) 

#define IAllDataTypesDisp_get_VARIANT_BOOLValue(This,Value)	\
    ( (This)->lpVtbl -> get_VARIANT_BOOLValue(This,Value) ) 

#define IAllDataTypesDisp_put_SCODEValue(This,Value)	\
    ( (This)->lpVtbl -> put_SCODEValue(This,Value) ) 

#define IAllDataTypesDisp_get_SCODEValue(This,Value)	\
    ( (This)->lpVtbl -> get_SCODEValue(This,Value) ) 

#define IAllDataTypesDisp_put_DATEValue(This,Value)	\
    ( (This)->lpVtbl -> put_DATEValue(This,Value) ) 

#define IAllDataTypesDisp_get_DATEValue(This,Value)	\
    ( (This)->lpVtbl -> get_DATEValue(This,Value) ) 

#define IAllDataTypesDisp_put_BSTRValue(This,Value)	\
    ( (This)->lpVtbl -> put_BSTRValue(This,Value) ) 

#define IAllDataTypesDisp_get_BSTRValue(This,Value)	\
    ( (This)->lpVtbl -> get_BSTRValue(This,Value) ) 

#define IAllDataTypesDisp_put_IUnknownReference(This,Value)	\
    ( (This)->lpVtbl -> put_IUnknownReference(This,Value) ) 

#define IAllDataTypesDisp_get_IUnknownReference(This,Value)	\
    ( (This)->lpVtbl -> get_IUnknownReference(This,Value) ) 

#define IAllDataTypesDisp_put_IDispatchReference(This,Value)	\
    ( (This)->lpVtbl -> put_IDispatchReference(This,Value) ) 

#define IAllDataTypesDisp_get_IDispatchReference(This,Value)	\
    ( (This)->lpVtbl -> get_IDispatchReference(This,Value) ) 

#define IAllDataTypesDisp_put_VARIANTValue(This,Value)	\
    ( (This)->lpVtbl -> put_VARIANTValue(This,Value) ) 

#define IAllDataTypesDisp_get_VARIANTValue(This,Value)	\
    ( (This)->lpVtbl -> get_VARIANTValue(This,Value) ) 

#define IAllDataTypesDisp_put_CURRENCYValue(This,Value)	\
    ( (This)->lpVtbl -> put_CURRENCYValue(This,Value) ) 

#define IAllDataTypesDisp_get_CURRENCYValue(This,Value)	\
    ( (This)->lpVtbl -> get_CURRENCYValue(This,Value) ) 

#define IAllDataTypesDisp_put_SAFEARRAY_I4Value(This,Value)	\
    ( (This)->lpVtbl -> put_SAFEARRAY_I4Value(This,Value) ) 

#define IAllDataTypesDisp_get_SAFEARRAY_I4Value(This,Value)	\
    ( (This)->lpVtbl -> get_SAFEARRAY_I4Value(This,Value) ) 

#define IAllDataTypesDisp_put_SAFEARRAY_DISPATCHValue(This,Value)	\
    ( (This)->lpVtbl -> put_SAFEARRAY_DISPATCHValue(This,Value) ) 

#define IAllDataTypesDisp_get_SAFEARRAY_DISPATCHValue(This,Value)	\
    ( (This)->lpVtbl -> get_SAFEARRAY_DISPATCHValue(This,Value) ) 

#define IAllDataTypesDisp_put_SAFEARRAY_UNKNOWNValue(This,Value)	\
    ( (This)->lpVtbl -> put_SAFEARRAY_UNKNOWNValue(This,Value) ) 

#define IAllDataTypesDisp_get_SAFEARRAY_UNKNOWNValue(This,Value)	\
    ( (This)->lpVtbl -> get_SAFEARRAY_UNKNOWNValue(This,Value) ) 

#define IAllDataTypesDisp_put_SAFEARRAY_BSTRValue(This,Value)	\
    ( (This)->lpVtbl -> put_SAFEARRAY_BSTRValue(This,Value) ) 

#define IAllDataTypesDisp_get_SAFEARRAY_BSTRValue(This,Value)	\
    ( (This)->lpVtbl -> get_SAFEARRAY_BSTRValue(This,Value) ) 

#define IAllDataTypesDisp_put_SAFEARRAY_VARIANTValue(This,Value)	\
    ( (This)->lpVtbl -> put_SAFEARRAY_VARIANTValue(This,Value) ) 

#define IAllDataTypesDisp_get_SAFEARRAY_VARIANTValue(This,Value)	\
    ( (This)->lpVtbl -> get_SAFEARRAY_VARIANTValue(This,Value) ) 

#define IAllDataTypesDisp_Quit(This)	\
    ( (This)->lpVtbl -> Quit(This) ) 

#define IAllDataTypesDisp_Reset(This)	\
    ( (This)->lpVtbl -> Reset(This) ) 

#define IAllDataTypesDisp_ManyArguments(This,AnIDispatch,PropertyName,Number,Value)	\
    ( (This)->lpVtbl -> ManyArguments(This,AnIDispatch,PropertyName,Number,Value) ) 

#define IAllDataTypesDisp_ManyByRefArguments(This,AnIDispatch,PropertyName,Number,Value)	\
    ( (This)->lpVtbl -> ManyByRefArguments(This,AnIDispatch,PropertyName,Number,Value) ) 

#endif /* COBJMACROS */


#endif 	/* C style interface */




#endif 	/* __IAllDataTypesDisp_INTERFACE_DEFINED__ */



#ifndef __VWALLDT_LIBRARY_DEFINED__
#define __VWALLDT_LIBRARY_DEFINED__

/* library VWALLDT */
/* [helpstring][version][lcid][uuid] */ 


EXTERN_C const IID LIBID_VWALLDT;

EXTERN_C const CLSID CLSID_VWAllDataTypesAuto;

#ifdef __cplusplus

class DECLSPEC_UUID("DB5DE8E3-AD1F-11d0-ACBE-5E86B1000000")
VWAllDataTypesAuto;
#endif

EXTERN_C const CLSID CLSID_VWAllDataTypes;

#ifdef __cplusplus

class DECLSPEC_UUID("EAD794C6-9658-4C2C-BE97-F86BDA3338FB")
VWAllDataTypes;
#endif
#endif /* __VWALLDT_LIBRARY_DEFINED__ */

/* Additional Prototypes for ALL interfaces */

unsigned long             __RPC_USER  BSTR_UserSize(     unsigned long *, unsigned long            , BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserMarshal(  unsigned long *, unsigned char *, BSTR * ); 
unsigned char * __RPC_USER  BSTR_UserUnmarshal(unsigned long *, unsigned char *, BSTR * ); 
void                      __RPC_USER  BSTR_UserFree(     unsigned long *, BSTR * ); 

unsigned long             __RPC_USER  LPSAFEARRAY_UserSize(     unsigned long *, unsigned long            , LPSAFEARRAY * ); 
unsigned char * __RPC_USER  LPSAFEARRAY_UserMarshal(  unsigned long *, unsigned char *, LPSAFEARRAY * ); 
unsigned char * __RPC_USER  LPSAFEARRAY_UserUnmarshal(unsigned long *, unsigned char *, LPSAFEARRAY * ); 
void                      __RPC_USER  LPSAFEARRAY_UserFree(     unsigned long *, LPSAFEARRAY * ); 

unsigned long             __RPC_USER  VARIANT_UserSize(     unsigned long *, unsigned long            , VARIANT * ); 
unsigned char * __RPC_USER  VARIANT_UserMarshal(  unsigned long *, unsigned char *, VARIANT * ); 
unsigned char * __RPC_USER  VARIANT_UserUnmarshal(unsigned long *, unsigned char *, VARIANT * ); 
void                      __RPC_USER  VARIANT_UserFree(     unsigned long *, VARIANT * ); 

/* end of Additional Prototypes */

#ifdef __cplusplus
}
#endif

#endif


