

/* this ALWAYS GENERATED file contains the IIDs and CLSIDs */

/* link this file in with the server and any clients */


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

MIDL_DEFINE_GUID(IID, IID_ISmalltalkCommanderDispVtbl,0xC9594220,0xF715,0x11d0,0xA7,0x91,0x00,0xA0,0x24,0xCD,0x45,0xB2);


MIDL_DEFINE_GUID(IID, DIID_ISmalltalkCommanderDisp,0x5FD2D2B3,0x95A8,0x11d0,0xAC,0xAB,0xE8,0x04,0x67,0x00,0x00,0x00);


MIDL_DEFINE_GUID(IID, LIBID_VWSTCOM,0x5FD2D2B2,0x95A8,0x11d0,0xAC,0xAB,0xE8,0x04,0x67,0x00,0x00,0x00);


MIDL_DEFINE_GUID(CLSID, CLSID_VWSmalltalkCommander,0x5FD2D2B1,0x95A8,0x11d0,0xAC,0xAB,0xE8,0x04,0x67,0x00,0x00,0x00);

#undef MIDL_DEFINE_GUID

#ifdef __cplusplus
}
#endif



