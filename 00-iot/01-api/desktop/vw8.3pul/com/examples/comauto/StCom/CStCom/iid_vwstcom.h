/* this file contains the actual definitions of */
/* the IIDs and CLSIDs */

/* link this file in with the server and any clients */


/* File created by MIDL compiler version 3.01.75 */
/* at Tue Mar 25 00:40:32 1997
 */
/* Compiler settings for vwstcom.idl:
    Os (OptLev=s), W1, Zp8, env=Win32, ms_ext, c_ext
    error checks: none
*/
//@@MIDL_FILE_HEADING(  )
#ifdef __cplusplus
extern "C"{
#endif 


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

const IID IID_ISmalltalkCommanderDisp = {0x5FD2D2B3,0x95A8,0x11d0,{0xAC,0xAB,0xE8,0x04,0x67,0x00,0x00,0x00}};


const IID LIBID_VWSTCOM = {0x5FD2D2B2,0x95A8,0x11d0,{0xAC,0xAB,0xE8,0x04,0x67,0x00,0x00,0x00}};


const CLSID CLSID_VWSmalltalkCommander = {0x5FD2D2B4,0x95A8,0x11d0,{0xAC,0xAB,0xE8,0x04,0x67,0x00,0x00,0x00}};


#ifdef __cplusplus
}
#endif

