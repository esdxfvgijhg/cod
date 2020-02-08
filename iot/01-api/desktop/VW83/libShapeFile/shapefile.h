#ifndef SHAPEFILE_H_INCLUDED
#define SHAPEFILE_H_INCLUDED

/******************************************************************************
 * $Id: shapefil.h,v 1.47 2010-01-28 11:34:34 fwarmerdam Exp $
 *
 * Project:  Shapelib
 * Purpose:  Primary include file for Shapelib.
 * Author:   Frank Warmerdam, warmerdam@pobox.com
 *
 ******************************************************************************
 * Copyright (c) 1999, Frank Warmerdam
 *
 * This software is available under the following "MIT Style" license,
 * or at the option of the licensee under the LGPL (see LICENSE.LGPL).  This
 * option is discussed in more detail in shapelib.html.
 *
 * --
 * 
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included
 * in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
 * OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
 * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 ******************************************************************************
 *
 * $Log: shapefil.h,v $
 * Revision 1.47  2010-01-28 11:34:34  fwarmerdam
 * handle the shape file length limits more gracefully (#3236)
 *
 * Revision 1.46  2008-11-12 14:28:15  fwarmerdam
 * DBFCreateField() now works on files with records
 *
 * Revision 1.45  2008/11/11 17:47:10  fwarmerdam
 * added DBFDeleteField() function
 *
 * Revision 1.44  2008/01/16 20:05:19  bram
 * Add file hooks that accept UTF-8 encoded filenames on some platforms.  Use SASetupUtf8Hooks
 *  tosetup the hooks and check SHPAPI_UTF8_HOOKS for its availability.  Currently, this
 *  is only available on the Windows platform that decodes the UTF-8 filenames to wide
 *  character strings and feeds them to _wfopen and _wremove.
 *
 * Revision 1.43  2008/01/10 16:35:30  fwarmerdam
 * avoid _ prefix on #defined symbols (bug 1840)
 *
 * Revision 1.42  2007/12/18 18:28:14  bram
 * - create hook for client specific atof (bugzilla ticket 1615)
 * - check for NULL handle before closing cpCPG file, and close after reading.
 *
 * Revision 1.41  2007/12/15 20:25:32  bram
 * dbfopen.c now reads the Code Page information from the DBF file, and exports
 * this information as a string through the DBFGetCodePage function.  This is 
 * either the number from the LDID header field ("LDID/<number>") or as the 
 * content of an accompanying .CPG file.  When creating a DBF file, the code can
 * be set using DBFCreateEx.
 *
 * Revision 1.40  2007/12/06 07:00:25  fwarmerdam
 * dbfopen now using SAHooks for fileio
 *
 * Revision 1.39  2007/12/04 20:37:56  fwarmerdam
 * preliminary implementation of hooks api for io and errors
 *
 * Revision 1.38  2007/11/21 22:39:56  fwarmerdam
 * close shx file in readonly mode (GDAL #1956)
 *
 * Revision 1.37  2007/10/27 03:31:14  fwarmerdam
 * limit default depth of tree to 12 levels (gdal ticket #1594)
 *
 * Revision 1.36  2007/09/10 23:33:15  fwarmerdam
 * Upstreamed support for visibility flag in SHPAPI_CALL for the needs
 * of GDAL (gdal ticket #1810).
 *
 * Revision 1.35  2007/09/03 19:48:10  fwarmerdam
 * move DBFReadAttribute() static dDoubleField into dbfinfo
 *
 * Revision 1.34  2006/06/17 15:33:32  fwarmerdam
 * added pszWorkField - bug 1202 (rso)
 *
 * Revision 1.33  2006/02/15 01:14:30  fwarmerdam
 * added DBFAddNativeFieldType
 *
 * Revision 1.32  2006/01/26 15:07:32  fwarmerdam
 * add bMeasureIsUsed flag from Craig Bruce: Bug 1249
 *
 * Revision 1.31  2006/01/05 01:27:27  fwarmerdam
 * added dbf deletion mark/fetch
 *
 * Revision 1.30  2005/01/03 22:30:13  fwarmerdam
 * added support for saved quadtrees
 *
 * Revision 1.29  2004/09/26 20:09:35  fwarmerdam
 * avoid rcsid warnings
 *
 * Revision 1.28  2003/12/29 06:02:18  fwarmerdam
 * added cpl_error.h option
 *
 * Revision 1.27  2003/04/21 18:30:37  warmerda
 * added header write/update public methods
 *
 * Revision 1.26  2002/09/29 00:00:08  warmerda
 * added FTLogical and logical attribute read/write calls
 *
 * Revision 1.25  2002/05/07 13:46:30  warmerda
 * added DBFWriteAttributeDirectly().
 *
 * Revision 1.24  2002/04/10 16:59:54  warmerda
 * added SHPRewindObject
 *
 * Revision 1.23  2002/01/15 14:36:07  warmerda
 * updated email address
 *
 * Revision 1.22  2002/01/15 14:32:00  warmerda
 * try to improve SHPAPI_CALL docs
 */

#include <stdio.h>

#ifdef USE_DBMALLOC
#include <dbmalloc.h>
#endif

#ifdef USE_CPL
#include "cpl_error.h"
#include "cpl_vsi.h"
#endif

#ifdef __cplusplus
extern "C" {
#endif

/************************************************************************/
/*                        Configuration options.                        */
/************************************************************************/

/* -------------------------------------------------------------------- */
/*      Should the DBFReadStringAttribute() strip leading and           */
/*      trailing white space?                                           */
/* -------------------------------------------------------------------- */
#define TRIM_DBF_WHITESPACE

/* -------------------------------------------------------------------- */
/*      Should we write measure values to the Multipatch object?        */
/*      Reportedly ArcView crashes if we do write it, so for now it     */
/*      is disabled.                                                    */
/* -------------------------------------------------------------------- */
#define DISABLE_MULTIPATCH_MEASURE
    
/* -------------------------------------------------------------------- */
/*      SHPAPI_CALL                                                     */
/*                                                                      */
/*      The following two macros are present to allow forcing           */
/*      various calling conventions on the Shapelib API.                */
/*                                                                      */
/*      To force __stdcall conventions (needed to call Shapelib         */
/*      from Visual Basic and/or Dephi I believe) the makefile could    */
/*      be modified to define:                                          */
/*                                                                      */
/*        /DSHPAPI_CALL=__stdcall                                       */
/*                                                                      */
/*      If it is desired to force export of the Shapelib API without    */
/*      using the shapelib.def file, use the following definition.      */
/*                                                                      */
/*        /DSHAPELIB_DLLEXPORT                                          */
/*                                                                      */
/*      To get both at once it will be necessary to hack this           */
/*      include file to define:                                         */
/*                                                                      */
/*        #define SHPAPI_CALL __declspec(dllexport) __stdcall           */
/*        #define SHPAPI_CALL1 __declspec(dllexport) * __stdcall        */
/*                                                                      */
/*      The complexity of the situtation is partly caused by the        */
/*      peculiar requirement of Visual C++ that __stdcall appear        */
/*      after any "*"'s in the return value of a function while the     */
/*      __declspec(dllexport) must appear before them.                  */
/* -------------------------------------------------------------------- */

#ifdef SHAPELIB_DLLEXPORT
#  define SHPAPI_CALL __declspec(dllexport)
#  define SHPAPI_CALL1(x)  __declspec(dllexport) x
#endif

#ifndef SHPAPI_CALL
#  if defined(USE_GCC_VISIBILITY_FLAG)
#    define SHPAPI_CALL     __attribute__ ((visibility("default")))
#    define SHPAPI_CALL1(x) __attribute__ ((visibility("default")))     x
#  else
#    define SHPAPI_CALL
#  endif
#endif

#ifndef SHPAPI_CALL1
#  define SHPAPI_CALL1(x)      x SHPAPI_CALL
#endif
    
/* -------------------------------------------------------------------- */
/*      Macros for controlling CVSID and ensuring they don't appear     */
/*      as unreferenced variables resulting in lots of warnings.        */
/* -------------------------------------------------------------------- */
#ifndef DISABLE_CVSID
#  define SHP_CVSID(string)     static char cpl_cvsid[] = string; \
static char *cvsid_aw() { return( cvsid_aw() ? ((char *) NULL) : cpl_cvsid ); }
#else
#  define SHP_CVSID(string)
#endif

/* -------------------------------------------------------------------- */
/*      On some platforms, additional file IO hooks are defined that    */
/*      UTF-8 encoded filenames Unicode filenames                       */
/* -------------------------------------------------------------------- */
#if defined(_WIN32) || defined(__WIN32__) || defined(WIN32)
#	define SHPAPI_WINDOWS
#	define SHPAPI_UTF8_HOOKS
#endif

/* -------------------------------------------------------------------- */
/*      SHP API Prototypes                                              */
/* -------------------------------------------------------------------- */

SHPObject **dumpSHP( char *pszFilename );

/* If pszAccess is read-only, the fpSHX field of the returned structure */
/* will be NULL as it is not necessary to keep the SHX file open */
SHPHandle SHPAPI_CALL
      SHPOpen( const char * pszShapeFile, const char * pszAccess );
SHPHandle SHPAPI_CALL
      SHPOpenLL( const char *pszShapeFile, const char *pszAccess, 
                 SAHooks *psHooks );
SHPHandle SHPAPI_CALL
      SHPCreate( const char * pszShapeFile, int nShapeType );
SHPHandle SHPAPI_CALL
      SHPCreateLL( const char * pszShapeFile, int nShapeType,
                   SAHooks *psHooks );
void SHPAPI_CALL
      SHPGetInfo( SHPHandle hSHP, int * pnEntities, int * pnShapeType,
                  double * padfMinBound, double * padfMaxBound );

SHPObject SHPAPI_CALL1(*)
      SHPReadObject( SHPHandle hSHP, int iShape );
int SHPAPI_CALL
      SHPWriteObject( SHPHandle hSHP, int iShape, SHPObject * psObject );

void SHPAPI_CALL
      SHPDestroyObject( SHPObject * psObject );
void SHPAPI_CALL
      SHPComputeExtents( SHPObject * psObject );
SHPObject SHPAPI_CALL1(*)
      SHPCreateObject( int nSHPType, int nShapeId, int nParts, 
                       const int * panPartStart, const int * panPartType,
                       int nVertices, 
                       const double * padfX, const double * padfY,
                       const double * padfZ, const double * padfM );
SHPObject SHPAPI_CALL1(*)
      SHPCreateSimpleObject( int nSHPType, int nVertices,
                             const double * padfX, 
                             const double * padfY, 
                             const double * padfZ );

int SHPAPI_CALL
      SHPRewindObject( SHPHandle hSHP, SHPObject * psObject );

void SHPAPI_CALL SHPClose( SHPHandle hSHP );
void SHPAPI_CALL SHPWriteHeader( SHPHandle hSHP );

const char SHPAPI_CALL1(*)
      SHPTypeName( int nSHPType );
const char SHPAPI_CALL1(*)
      SHPPartTypeName( int nPartType );



