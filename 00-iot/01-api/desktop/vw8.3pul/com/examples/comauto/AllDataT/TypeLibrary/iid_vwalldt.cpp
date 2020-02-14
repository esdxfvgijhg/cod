

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


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


#ifdef __cplusplus
extern "C"{
#endif 


#include <rpc.h>
#include <rpcndr.h>

#ifdef _MIDL_USE_GUIDDEF_

#ifndef INITGUID
#define INITGUID
#include <guiddef.h>
#undef INITGUID
#else
#include <guiddef.h>
#endif

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        DEFINE_GUID(name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8)

#else // !_MIDL_USE_GUIDDEF_

#ifndef __IID_DEFINED__
#define __IID_DEFINED__

typedef struct _IID
{
    unsigned long x;
    unsigned short s1;
    unsigned short s2;
    unsigned char  c[8];
} IID;

#endif // __IID_DEFINED__

#ifndef CLSID_DEFINED
#define CLSID_DEFINED
typedef IID CLSID;
#endif // CLSID_DEFINED

#define MIDL_DEFINE_GUID(type,name,l,w1,w2,b1,b2,b3,b4,b5,b6,b7,b8) \
        const type name = {l,w1,w2,{b1,b2,b3,b4,b5,b6,b7,b8}}

#endif !_MIDL_USE_GUIDDEF_

MIDL_DEFINE_GUID(IID, IID_IAllDataTypesDisp,0xDB5DE8E2,0xAD1F,0x11d0,0xAC,0xBE,0x5E,0x86,0xB1,0x00,0x00,0x00);


MIDL_DEFINE_GUID(IID, DIID_IAllDataTypesAuto,0x04A143E4,0x883D,0x4EE4,0xB2,0xD2,0x7F,0xB7,0x44,0x73,0xA5,0x1E);


MIDL_DEFINE_GUID(IID, LIBID_VWALLDT,0x6A693FAC,0xD5E6,0x4D5B,0x90,0x9B,0x0C,0x05,0x83,0x4A,0x58,0xA1);


MIDL_DEFINE_GUID(CLSID, CLSID_VWAllDataTypesAuto,0xDB5DE8E3,0xAD1F,0x11d0,0xAC,0xBE,0x5E,0x86,0xB1,0x00,0x00,0x00);


MIDL_DEFINE_GUID(CLSID, CLSID_VWAllDataTypes,0xEAD794C6,0x9658,0x4C2C,0xBE,0x97,0xF8,0x6B,0xDA,0x33,0x38,0xFB);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



