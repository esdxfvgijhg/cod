

/* this ALWAYS GENERATED file contains the proxy stub code */


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

#if !defined(_M_IA64) && !defined(_M_AMD64)


#pragma warning( disable: 4049 )  /* more than 64k source lines */
#if _MSC_VER >= 1200
#pragma warning(push)
#endif

#pragma warning( disable: 4211 )  /* redefine extern to static */
#pragma warning( disable: 4232 )  /* dllimport identity*/
#pragma warning( disable: 4024 )  /* array to pointer mapping*/
#pragma warning( disable: 4152 )  /* function/data pointer conversion in expression */
#pragma warning( disable: 4100 ) /* unreferenced arguments in x86 call */

#pragma optimize("", off ) 

#define USE_STUBLESS_PROXY


/* verify that the <rpcproxy.h> version is high enough to compile this file*/
#ifndef __REDQ_RPCPROXY_H_VERSION__
#define __REQUIRED_RPCPROXY_H_VERSION__ 475
#endif


#include "rpcproxy.h"
#ifndef __RPCPROXY_H_VERSION__
#error this stub requires an updated version of <rpcproxy.h>
#endif /* __RPCPROXY_H_VERSION__ */


#include "midl_VWLicenseManager.h"

#define TYPE_FORMAT_STRING_SIZE   113                               
#define PROC_FORMAT_STRING_SIZE   145                               
#define EXPR_FORMAT_STRING_SIZE   1                                 
#define TRANSMIT_AS_TABLE_SIZE    0            
#define WIRE_MARSHAL_TABLE_SIZE   1            

typedef struct _VWLicenseManager_MIDL_TYPE_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ TYPE_FORMAT_STRING_SIZE ];
    } VWLicenseManager_MIDL_TYPE_FORMAT_STRING;

typedef struct _VWLicenseManager_MIDL_PROC_FORMAT_STRING
    {
    short          Pad;
    unsigned char  Format[ PROC_FORMAT_STRING_SIZE ];
    } VWLicenseManager_MIDL_PROC_FORMAT_STRING;

typedef struct _VWLicenseManager_MIDL_EXPR_FORMAT_STRING
    {
    long          Pad;
    unsigned char  Format[ EXPR_FORMAT_STRING_SIZE ];
    } VWLicenseManager_MIDL_EXPR_FORMAT_STRING;


static const RPC_SYNTAX_IDENTIFIER  _RpcTransferSyntax = 
{{0x8A885D04,0x1CEB,0x11C9,{0x9F,0xE8,0x08,0x00,0x2B,0x10,0x48,0x60}},{2,0}};


extern const VWLicenseManager_MIDL_TYPE_FORMAT_STRING VWLicenseManager__MIDL_TypeFormatString;
extern const VWLicenseManager_MIDL_PROC_FORMAT_STRING VWLicenseManager__MIDL_ProcFormatString;
extern const VWLicenseManager_MIDL_EXPR_FORMAT_STRING VWLicenseManager__MIDL_ExprFormatString;


extern const MIDL_STUB_DESC Object_StubDesc;


extern const MIDL_SERVER_INFO ILicenseManager_ServerInfo;
extern const MIDL_STUBLESS_PROXY_INFO ILicenseManager_ProxyInfo;


extern const USER_MARSHAL_ROUTINE_QUADRUPLE UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ];

#if !defined(__RPC_WIN32__)
#error  Invalid build platform for this stub.
#endif

#if !(TARGET_IS_NT50_OR_LATER)
#error You need Windows 2000 or later to run this stub because it uses these features:
#error   /robust command line switch.
#error However, your C/C++ compilation flags indicate you intend to run this app on earlier systems.
#error This app will fail with the RPC_X_WRONG_STUB_VERSION error.
#endif


static const VWLicenseManager_MIDL_PROC_FORMAT_STRING VWLicenseManager__MIDL_ProcFormatString =
    {
        0,
        {

	/* Procedure IsDevelopment */

			0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/*  2 */	NdrFcLong( 0x0 ),	/* 0 */
/*  6 */	NdrFcShort( 0x3 ),	/* 3 */
/*  8 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 10 */	NdrFcShort( 0x44 ),	/* 68 */
/* 12 */	NdrFcShort( 0x24 ),	/* 36 */
/* 14 */	0x44,		/* Oi2 Flags:  has return, has ext, */
			0x3,		/* 3 */
/* 16 */	0x8,		/* 8 */
			0x1,		/* Ext Flags:  new corr desc, */
/* 18 */	NdrFcShort( 0x0 ),	/* 0 */
/* 20 */	NdrFcShort( 0x0 ),	/* 0 */
/* 22 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter clsid */

/* 24 */	NdrFcShort( 0x10a ),	/* Flags:  must free, in, simple ref, */
/* 26 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 28 */	NdrFcShort( 0xc ),	/* Type Offset=12 */

	/* Parameter result */

/* 30 */	NdrFcShort( 0x2150 ),	/* Flags:  out, base type, simple ref, srv alloc size=8 */
/* 32 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 34 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Return value */

/* 36 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 38 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 40 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure CreateInstance */

/* 42 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 44 */	NdrFcLong( 0x0 ),	/* 0 */
/* 48 */	NdrFcShort( 0x4 ),	/* 4 */
/* 50 */	NdrFcShort( 0x1c ),	/* x86 Stack size/offset = 28 */
/* 52 */	NdrFcShort( 0x88 ),	/* 136 */
/* 54 */	NdrFcShort( 0x8 ),	/* 8 */
/* 56 */	0x47,		/* Oi2 Flags:  srv must size, clt must size, has return, has ext, */
			0x6,		/* 6 */
/* 58 */	0x8,		/* 8 */
			0x7,		/* Ext Flags:  new corr desc, clt corr check, srv corr check, */
/* 60 */	NdrFcShort( 0x1 ),	/* 1 */
/* 62 */	NdrFcShort( 0x1 ),	/* 1 */
/* 64 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter class */

/* 66 */	NdrFcShort( 0x10a ),	/* Flags:  must free, in, simple ref, */
/* 68 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 70 */	NdrFcShort( 0xc ),	/* Type Offset=12 */

	/* Parameter pUnkOuter */

/* 72 */	NdrFcShort( 0xb ),	/* Flags:  must size, must free, in, */
/* 74 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 76 */	NdrFcShort( 0x1c ),	/* Type Offset=28 */

	/* Parameter riid */

/* 78 */	NdrFcShort( 0x10a ),	/* Flags:  must free, in, simple ref, */
/* 80 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 82 */	NdrFcShort( 0xc ),	/* Type Offset=12 */

	/* Parameter license */

/* 84 */	NdrFcShort( 0x8b ),	/* Flags:  must size, must free, in, by val, */
/* 86 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 88 */	NdrFcShort( 0x48 ),	/* Type Offset=72 */

	/* Parameter ppvObject */

/* 90 */	NdrFcShort( 0x13 ),	/* Flags:  must size, must free, out, */
/* 92 */	NdrFcShort( 0x14 ),	/* x86 Stack size/offset = 20 */
/* 94 */	NdrFcShort( 0x52 ),	/* Type Offset=82 */

	/* Return value */

/* 96 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 98 */	NdrFcShort( 0x18 ),	/* x86 Stack size/offset = 24 */
/* 100 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

	/* Procedure QueryLicenseKey */

/* 102 */	0x33,		/* FC_AUTO_HANDLE */
			0x6c,		/* Old Flags:  object, Oi2 */
/* 104 */	NdrFcLong( 0x0 ),	/* 0 */
/* 108 */	NdrFcShort( 0x5 ),	/* 5 */
/* 110 */	NdrFcShort( 0x10 ),	/* x86 Stack size/offset = 16 */
/* 112 */	NdrFcShort( 0x44 ),	/* 68 */
/* 114 */	NdrFcShort( 0x8 ),	/* 8 */
/* 116 */	0x45,		/* Oi2 Flags:  srv must size, has return, has ext, */
			0x3,		/* 3 */
/* 118 */	0x8,		/* 8 */
			0x3,		/* Ext Flags:  new corr desc, clt corr check, */
/* 120 */	NdrFcShort( 0x1 ),	/* 1 */
/* 122 */	NdrFcShort( 0x0 ),	/* 0 */
/* 124 */	NdrFcShort( 0x0 ),	/* 0 */

	/* Parameter class */

/* 126 */	NdrFcShort( 0x10a ),	/* Flags:  must free, in, simple ref, */
/* 128 */	NdrFcShort( 0x4 ),	/* x86 Stack size/offset = 4 */
/* 130 */	NdrFcShort( 0xc ),	/* Type Offset=12 */

	/* Parameter result */

/* 132 */	NdrFcShort( 0x2113 ),	/* Flags:  must size, must free, out, simple ref, srv alloc size=8 */
/* 134 */	NdrFcShort( 0x8 ),	/* x86 Stack size/offset = 8 */
/* 136 */	NdrFcShort( 0x66 ),	/* Type Offset=102 */

	/* Return value */

/* 138 */	NdrFcShort( 0x70 ),	/* Flags:  out, return, base type, */
/* 140 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 142 */	0x8,		/* FC_LONG */
			0x0,		/* 0 */

			0x0
        }
    };

static const VWLicenseManager_MIDL_TYPE_FORMAT_STRING VWLicenseManager__MIDL_TypeFormatString =
    {
        0,
        {
			NdrFcShort( 0x0 ),	/* 0 */
/*  2 */	
			0x11, 0x0,	/* FC_RP */
/*  4 */	NdrFcShort( 0x8 ),	/* Offset= 8 (12) */
/*  6 */	
			0x1d,		/* FC_SMFARRAY */
			0x0,		/* 0 */
/*  8 */	NdrFcShort( 0x8 ),	/* 8 */
/* 10 */	0x1,		/* FC_BYTE */
			0x5b,		/* FC_END */
/* 12 */	
			0x15,		/* FC_STRUCT */
			0x3,		/* 3 */
/* 14 */	NdrFcShort( 0x10 ),	/* 16 */
/* 16 */	0x8,		/* FC_LONG */
			0x6,		/* FC_SHORT */
/* 18 */	0x6,		/* FC_SHORT */
			0x4c,		/* FC_EMBEDDED_COMPLEX */
/* 20 */	0x0,		/* 0 */
			NdrFcShort( 0xfff1 ),	/* Offset= -15 (6) */
			0x5b,		/* FC_END */
/* 24 */	
			0x11, 0xc,	/* FC_RP [alloced_on_stack] [simple_pointer] */
/* 26 */	0x8,		/* FC_LONG */
			0x5c,		/* FC_PAD */
/* 28 */	
			0x2f,		/* FC_IP */
			0x5a,		/* FC_CONSTANT_IID */
/* 30 */	NdrFcLong( 0x0 ),	/* 0 */
/* 34 */	NdrFcShort( 0x0 ),	/* 0 */
/* 36 */	NdrFcShort( 0x0 ),	/* 0 */
/* 38 */	0xc0,		/* 192 */
			0x0,		/* 0 */
/* 40 */	0x0,		/* 0 */
			0x0,		/* 0 */
/* 42 */	0x0,		/* 0 */
			0x0,		/* 0 */
/* 44 */	0x0,		/* 0 */
			0x46,		/* 70 */
/* 46 */	
			0x12, 0x0,	/* FC_UP */
/* 48 */	NdrFcShort( 0xe ),	/* Offset= 14 (62) */
/* 50 */	
			0x1b,		/* FC_CARRAY */
			0x1,		/* 1 */
/* 52 */	NdrFcShort( 0x2 ),	/* 2 */
/* 54 */	0x9,		/* Corr desc: FC_ULONG */
			0x0,		/*  */
/* 56 */	NdrFcShort( 0xfffc ),	/* -4 */
/* 58 */	NdrFcShort( 0x1 ),	/* Corr flags:  early, */
/* 60 */	0x6,		/* FC_SHORT */
			0x5b,		/* FC_END */
/* 62 */	
			0x17,		/* FC_CSTRUCT */
			0x3,		/* 3 */
/* 64 */	NdrFcShort( 0x8 ),	/* 8 */
/* 66 */	NdrFcShort( 0xfff0 ),	/* Offset= -16 (50) */
/* 68 */	0x8,		/* FC_LONG */
			0x8,		/* FC_LONG */
/* 70 */	0x5c,		/* FC_PAD */
			0x5b,		/* FC_END */
/* 72 */	0xb4,		/* FC_USER_MARSHAL */
			0x83,		/* 131 */
/* 74 */	NdrFcShort( 0x0 ),	/* 0 */
/* 76 */	NdrFcShort( 0x4 ),	/* 4 */
/* 78 */	NdrFcShort( 0x0 ),	/* 0 */
/* 80 */	NdrFcShort( 0xffde ),	/* Offset= -34 (46) */
/* 82 */	
			0x11, 0x10,	/* FC_RP [pointer_deref] */
/* 84 */	NdrFcShort( 0x2 ),	/* Offset= 2 (86) */
/* 86 */	
			0x2f,		/* FC_IP */
			0x5c,		/* FC_PAD */
/* 88 */	0x28,		/* Corr desc:  parameter, FC_LONG */
			0x0,		/*  */
/* 90 */	NdrFcShort( 0xc ),	/* x86 Stack size/offset = 12 */
/* 92 */	NdrFcShort( 0x5 ),	/* Corr flags:  early, iid_is, */
/* 94 */	
			0x11, 0x4,	/* FC_RP [alloced_on_stack] */
/* 96 */	NdrFcShort( 0x6 ),	/* Offset= 6 (102) */
/* 98 */	
			0x13, 0x0,	/* FC_OP */
/* 100 */	NdrFcShort( 0xffda ),	/* Offset= -38 (62) */
/* 102 */	0xb4,		/* FC_USER_MARSHAL */
			0x83,		/* 131 */
/* 104 */	NdrFcShort( 0x0 ),	/* 0 */
/* 106 */	NdrFcShort( 0x4 ),	/* 4 */
/* 108 */	NdrFcShort( 0x0 ),	/* 0 */
/* 110 */	NdrFcShort( 0xfff4 ),	/* Offset= -12 (98) */

			0x0
        }
    };

static const USER_MARSHAL_ROUTINE_QUADRUPLE UserMarshalRoutines[ WIRE_MARSHAL_TABLE_SIZE ] = 
        {
            
            {
            BSTR_UserSize
            ,BSTR_UserMarshal
            ,BSTR_UserUnmarshal
            ,BSTR_UserFree
            }

        };



/* Standard interface: __MIDL_itf_VWLicenseManager_0000_0000, ver. 0.0,
   GUID={0x00000000,0x0000,0x0000,{0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00}} */


/* Object interface: IUnknown, ver. 0.0,
   GUID={0x00000000,0x0000,0x0000,{0xC0,0x00,0x00,0x00,0x00,0x00,0x00,0x46}} */


/* Object interface: ILicenseManager, ver. 0.0,
   GUID={0x13467F22,0x554A,0x4C51,{0x9A,0xDB,0x17,0x18,0xAF,0x5E,0x96,0x00}} */

#pragma code_seg(".orpc")
static const unsigned short ILicenseManager_FormatStringOffsetTable[] =
    {
    0,
    42,
    102
    };

static const MIDL_STUBLESS_PROXY_INFO ILicenseManager_ProxyInfo =
    {
    &Object_StubDesc,
    VWLicenseManager__MIDL_ProcFormatString.Format,
    &ILicenseManager_FormatStringOffsetTable[-3],
    0,
    0,
    0
    };


static const MIDL_SERVER_INFO ILicenseManager_ServerInfo = 
    {
    &Object_StubDesc,
    0,
    VWLicenseManager__MIDL_ProcFormatString.Format,
    &ILicenseManager_FormatStringOffsetTable[-3],
    0,
    0,
    0,
    0};
CINTERFACE_PROXY_VTABLE(6) _ILicenseManagerProxyVtbl = 
{
    &ILicenseManager_ProxyInfo,
    &IID_ILicenseManager,
    IUnknown_QueryInterface_Proxy,
    IUnknown_AddRef_Proxy,
    IUnknown_Release_Proxy ,
    (void *) (INT_PTR) -1 /* ILicenseManager::IsDevelopment */ ,
    (void *) (INT_PTR) -1 /* ILicenseManager::CreateInstance */ ,
    (void *) (INT_PTR) -1 /* ILicenseManager::QueryLicenseKey */
};

const CInterfaceStubVtbl _ILicenseManagerStubVtbl =
{
    &IID_ILicenseManager,
    &ILicenseManager_ServerInfo,
    6,
    0, /* pure interpreted */
    CStdStubBuffer_METHODS
};

static const MIDL_STUB_DESC Object_StubDesc = 
    {
    0,
    NdrOleAllocate,
    NdrOleFree,
    0,
    0,
    0,
    0,
    0,
    VWLicenseManager__MIDL_TypeFormatString.Format,
    1, /* -error bounds_check flag */
    0x50002, /* Ndr library version */
    0,
    0x700022b, /* MIDL Version 7.0.555 */
    0,
    UserMarshalRoutines,
    0,  /* notify & notify_flag routine table */
    0x1, /* MIDL flag */
    0, /* cs routines */
    0,   /* proxy/server info */
    0
    };

const CInterfaceProxyVtbl * const _VWLicenseManager_ProxyVtblList[] = 
{
    ( CInterfaceProxyVtbl *) &_ILicenseManagerProxyVtbl,
    0
};

const CInterfaceStubVtbl * const _VWLicenseManager_StubVtblList[] = 
{
    ( CInterfaceStubVtbl *) &_ILicenseManagerStubVtbl,
    0
};

PCInterfaceName const _VWLicenseManager_InterfaceNamesList[] = 
{
    "ILicenseManager",
    0
};


#define _VWLicenseManager_CHECK_IID(n)	IID_GENERIC_CHECK_IID( _VWLicenseManager, pIID, n)

int __stdcall _VWLicenseManager_IID_Lookup( const IID * pIID, int * pIndex )
{
    
    if(!_VWLicenseManager_CHECK_IID(0))
        {
        *pIndex = 0;
        return 1;
        }

    return 0;
}

const ExtendedProxyFileInfo VWLicenseManager_ProxyFileInfo = 
{
    (PCInterfaceProxyVtblList *) & _VWLicenseManager_ProxyVtblList,
    (PCInterfaceStubVtblList *) & _VWLicenseManager_StubVtblList,
    (const PCInterfaceName * ) & _VWLicenseManager_InterfaceNamesList,
    0, /* no delegation */
    & _VWLicenseManager_IID_Lookup, 
    1,
    2,
    0, /* table of [async_uuid] interfaces */
    0, /* Filler1 */
    0, /* Filler2 */
    0  /* Filler3 */
};
#pragma optimize("", on )
#if _MSC_VER >= 1200
#pragma warning(pop)
#endif


#endif /* !defined(_M_IA64) && !defined(_M_AMD64)*/

