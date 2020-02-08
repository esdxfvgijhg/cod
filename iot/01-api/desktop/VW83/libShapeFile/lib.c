#include "lib.h"
#include <math.h>
#include <limits.h>
#include <assert.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>



#ifndef MAX
#  define MIN(a,b)      ((a<b) ? a : b)
#  define MAX(a,b)      ((a>b) ? a : b)
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

#ifdef SHPAPI_UTF8_HOOKS
#   ifdef SHPAPI_WINDOWS
#       define WIN32_LEAN_AND_MEAN
#       define NOMINMAX
#       include <windows.h>
#       pragma comment(lib, "kernel32.lib")
#   endif
#endif

#if UINT_MAX == 65535
typedef unsigned long	      int32;
#else
typedef unsigned int	      int32;
#endif

#ifndef FALSE
#  define FALSE		0
#  define TRUE		1
#endif

static int 	bBigEndian;

#ifndef SAOffset
typedef unsigned long SAOffset;
#endif

typedef unsigned char uchar;

/************************************************************************/
/*                              SwapWord()                              */
/*                                                                      */
/*      Swap a 2, 4 or 8 byte word.                                     */
/************************************************************************/

static void	SwapWord( int length, void * wordP )

{
    int		i;
    uchar	temp;

    for( i=0; i < length/2; i++ )
    {
	temp = ((uchar *) wordP)[i];
	((uchar *)wordP)[i] = ((uchar *) wordP)[length-i-1];
	((uchar *) wordP)[length-i-1] = temp;
    }
}

/************************************************************************/
/*                             SfRealloc()                              */
/*                                                                      */
/*      A realloc cover function that will access a NULL pointer as     */
/*      a valid input.                                                  */
/************************************************************************/

static void * SfRealloc( void * pMem, int nNewSize )

{
    if( pMem == NULL )
        return( (void *) malloc(nNewSize) );
    else
        return( (void *) realloc(pMem,nNewSize) );
}


/************************************************************************/
/*                          SHPDestroyObject()                          */
/************************************************************************/

void SHPAPI_CALL
SHPDestroyObject( SHPObject * psShape )

{
    if( psShape == NULL )
        return;
    
    if( psShape->padfX != NULL )
        free( psShape->padfX );
    if( psShape->padfY != NULL )
        free( psShape->padfY );
    if( psShape->padfZ != NULL )
        free( psShape->padfZ );
    if( psShape->padfM != NULL )
        free( psShape->padfM );

    if( psShape->panPartStart != NULL )
        free( psShape->panPartStart );
    if( psShape->panPartType != NULL )
        free( psShape->panPartType );

    free( psShape );
}




/************************************************************************/
/*                              SADFOpen()                              */
/************************************************************************/

int* SADFOpen( const char *pszFilename, const char *pszAccess )

{
    return (int*) fopen( pszFilename, pszAccess );
}

/************************************************************************/
/*                              SADFRead()                              */
/************************************************************************/

SAOffset SADFRead( void *p, SAOffset size, SAOffset nmemb, int* file )

{
    return (SAOffset) fread( p, (size_t) size, (size_t) nmemb, 
                             (FILE *) file );
}

/************************************************************************/
/*                             SADFWrite()                              */
/************************************************************************/

SAOffset SADFWrite( void *p, SAOffset size, SAOffset nmemb, int* file )

{
    return (SAOffset) fwrite( p, (size_t) size, (size_t) nmemb, 
                              (FILE *) file );
}

/************************************************************************/
/*                              SADFSeek()                              */
/************************************************************************/

SAOffset SADFSeek( int* file, SAOffset offset, int whence )

{
    return (SAOffset) fseek( (FILE *) file, (long) offset, whence );
}

/************************************************************************/
/*                              SADFTell()                              */
/************************************************************************/

SAOffset SADFTell( int* file )

{
    return (SAOffset) ftell( (FILE *) file );
}

/************************************************************************/
/*                             SADFFlush()                              */
/************************************************************************/

int SADFFlush( int* file )

{
    return fflush( (FILE *) file );
}

/************************************************************************/
/*                             SADFClose()                              */
/************************************************************************/

int SADFClose( int* file )

{
    return fclose( (FILE *) file );
}

/************************************************************************/
/*                             SADFClose()                              */
/************************************************************************/

int SADRemove( const char *filename )

{
    return remove( filename );
}

/************************************************************************/
/*                              SADError()                              */
/************************************************************************/

void SADError( const char *message )

{
    fprintf( stderr, "%s\n", message );
}

/************************************************************************/
/*                        SASetupDefaultHooks()                         */
/************************************************************************/

void SASetupDefaultHooks( SAHooks *psHooks )

{
    psHooks->FOpen   = SADFOpen;
    psHooks->FRead   = SADFRead;
    psHooks->FWrite  = SADFWrite;
    psHooks->FSeek   = SADFSeek;
    psHooks->FTell   = SADFTell;
    psHooks->FFlush  = SADFFlush;
    psHooks->FClose  = SADFClose;
    psHooks->Remove  = SADRemove;

    psHooks->Error   = SADError;
    psHooks->Atof    = atof;
}






/************************************************************************/
/*                              SHPOpen()                               */
/*                                                                      */
/*      Open the .shp and .shx files based on the basename of the       */
/*      files or either file name.                                      */
/************************************************************************/
   
SHPHandle SHPAPI_CALL
SHPOpenLL( const char * pszLayer, const char * pszAccess, SAHooks *psHooks )

{
    char		*pszFullname, *pszBasename;
    SHPHandle		psSHP;
    
    uchar		*pabyBuf;
    int			i;
    double		dValue;
    
/* -------------------------------------------------------------------- */
/*      Ensure the access string is one of the legal ones.  We          */
/*      ensure the result string indicates binary to avoid common       */
/*      problems on Windows.                                            */
/* -------------------------------------------------------------------- */
    if( strcmp(pszAccess,"rb+") == 0 || strcmp(pszAccess,"r+b") == 0
        || strcmp(pszAccess,"r+") == 0 )
        pszAccess = "r+b";
    else
        pszAccess = "rb";
    
/* -------------------------------------------------------------------- */
/*	Establish the byte order on this machine.			*/
/* -------------------------------------------------------------------- */
    i = 1;
    if( *((uchar *) &i) == 1 )
        bBigEndian = FALSE;
    else
        bBigEndian = TRUE;

/* -------------------------------------------------------------------- */
/*	Initialize the info structure.					*/
/* -------------------------------------------------------------------- */
    psSHP = (SHPHandle) calloc(sizeof(SHPInfo),1);

    psSHP->bUpdated = FALSE;
    memcpy( &(psSHP->sHooks), psHooks, sizeof(SAHooks) );

/* -------------------------------------------------------------------- */
/*	Compute the base (layer) name.  If there is any extension	*/
/*	on the passed in filename we will strip it off.			*/
/* -------------------------------------------------------------------- */
    pszBasename = (char *) malloc(strlen(pszLayer)+5);
    strcpy( pszBasename, pszLayer );
    for( i = strlen(pszBasename)-1; 
	 i > 0 && pszBasename[i] != '.' && pszBasename[i] != '/'
	       && pszBasename[i] != '\\';
	 i-- ) {}

    if( pszBasename[i] == '.' )
        pszBasename[i] = '\0';

/* -------------------------------------------------------------------- */
/*	Open the .shp and .shx files.  Note that files pulled from	*/
/*	a PC to Unix with upper case filenames won't work!		*/
/* -------------------------------------------------------------------- */
    pszFullname = (char *) malloc(strlen(pszBasename) + 5);
    sprintf( pszFullname, "%s.shp", pszBasename ) ;
    psSHP->fpSHP = psSHP->sHooks.FOpen(pszFullname, pszAccess );
    if( psSHP->fpSHP == NULL )
    {
        sprintf( pszFullname, "%s.SHP", pszBasename );
        psSHP->fpSHP = psSHP->sHooks.FOpen(pszFullname, pszAccess );
    }
    
    if( psSHP->fpSHP == NULL )
    {

        free( psSHP );
        free( pszBasename );
        free( pszFullname );
        return( NULL );
    }

    sprintf( pszFullname, "%s.shx", pszBasename );
    psSHP->fpSHX =  psSHP->sHooks.FOpen(pszFullname, pszAccess );
    if( psSHP->fpSHX == NULL )
    {
        sprintf( pszFullname, "%s.SHX", pszBasename );
        psSHP->fpSHX = psSHP->sHooks.FOpen(pszFullname, pszAccess );
    }
    
    if( psSHP->fpSHX == NULL )
    {

        psSHP->sHooks.FClose( psSHP->fpSHP );
        free( psSHP );
        free( pszBasename );
        free( pszFullname );
        return( NULL );
    }

    free( pszFullname );
    free( pszBasename );

/* -------------------------------------------------------------------- */
/*  Read the file size from the SHP file.				*/
/* -------------------------------------------------------------------- */
    pabyBuf = (uchar *) malloc(100);
    psSHP->sHooks.FRead( pabyBuf, 100, 1, psSHP->fpSHP );

    psSHP->nFileSize = ((unsigned int)pabyBuf[24] * 256 * 256 * 256
			+ (unsigned int)pabyBuf[25] * 256 * 256
			+ (unsigned int)pabyBuf[26] * 256
			+ (unsigned int)pabyBuf[27]) * 2;

/* -------------------------------------------------------------------- */
/*  Read SHX file Header info                                           */
/* -------------------------------------------------------------------- */
    if( psSHP->sHooks.FRead( pabyBuf, 100, 1, psSHP->fpSHX ) != 1 
        || pabyBuf[0] != 0 
        || pabyBuf[1] != 0 
        || pabyBuf[2] != 0x27 
        || (pabyBuf[3] != 0x0a && pabyBuf[3] != 0x0d) )
    {
        psSHP->sHooks.Error( ".shx file is unreadable, or corrupt." );
	psSHP->sHooks.FClose( psSHP->fpSHP );
	psSHP->sHooks.FClose( psSHP->fpSHX );
	free( psSHP );

	return( NULL );
    }

    psSHP->nRecords = pabyBuf[27] + pabyBuf[26] * 256
      + pabyBuf[25] * 256 * 256 + pabyBuf[24] * 256 * 256 * 256;
    psSHP->nRecords = (psSHP->nRecords*2 - 100) / 8;

    psSHP->nShapeType = pabyBuf[32];

    if( psSHP->nRecords < 0 || psSHP->nRecords > 256000000 )
    {
        char szError[200];
        
        sprintf( szError, 
                 "Record count in .shp header is %d, which seems\n"
                 "unreasonable.  Assuming header is corrupt.",
                  psSHP->nRecords );
        psSHP->sHooks.Error( szError );				       
	psSHP->sHooks.FClose( psSHP->fpSHP );
	psSHP->sHooks.FClose( psSHP->fpSHX );
	free( psSHP );
        free(pabyBuf);

	return( NULL );
    }

/* -------------------------------------------------------------------- */
/*      Read the bounds.                                                */
/* -------------------------------------------------------------------- */
    if( bBigEndian ) SwapWord( 8, pabyBuf+36 );
    memcpy( &dValue, pabyBuf+36, 8 );
    psSHP->adBoundsMin[0] = dValue;

    if( bBigEndian ) SwapWord( 8, pabyBuf+44 );
    memcpy( &dValue, pabyBuf+44, 8 );
    psSHP->adBoundsMin[1] = dValue;

    if( bBigEndian ) SwapWord( 8, pabyBuf+52 );
    memcpy( &dValue, pabyBuf+52, 8 );
    psSHP->adBoundsMax[0] = dValue;

    if( bBigEndian ) SwapWord( 8, pabyBuf+60 );
    memcpy( &dValue, pabyBuf+60, 8 );
    psSHP->adBoundsMax[1] = dValue;

    if( bBigEndian ) SwapWord( 8, pabyBuf+68 );		/* z */
    memcpy( &dValue, pabyBuf+68, 8 );
    psSHP->adBoundsMin[2] = dValue;
    
    if( bBigEndian ) SwapWord( 8, pabyBuf+76 );
    memcpy( &dValue, pabyBuf+76, 8 );
    psSHP->adBoundsMax[2] = dValue;
    
    if( bBigEndian ) SwapWord( 8, pabyBuf+84 );		/* z */
    memcpy( &dValue, pabyBuf+84, 8 );
    psSHP->adBoundsMin[3] = dValue;

    if( bBigEndian ) SwapWord( 8, pabyBuf+92 );
    memcpy( &dValue, pabyBuf+92, 8 );
    psSHP->adBoundsMax[3] = dValue;

    free( pabyBuf );

/* -------------------------------------------------------------------- */
/*	Read the .shx file to get the offsets to each record in 	*/
/*	the .shp file.							*/
/* -------------------------------------------------------------------- */
    psSHP->nMaxRecords = psSHP->nRecords;

    psSHP->panRecOffset = (unsigned int *)
        malloc(sizeof(unsigned int) * MAX(1,psSHP->nMaxRecords) );
    psSHP->panRecSize = (unsigned int *)
        malloc(sizeof(unsigned int) * MAX(1,psSHP->nMaxRecords) );
    pabyBuf = (uchar *) malloc(8 * MAX(1,psSHP->nRecords) );

    if (psSHP->panRecOffset == NULL ||
        psSHP->panRecSize == NULL ||
        pabyBuf == NULL)
    {
        char szError[200];

        sprintf(szError, 
                "Not enough memory to allocate requested memory (nRecords=%d).\n"
                "Probably broken SHP file", 
                psSHP->nRecords );
        psSHP->sHooks.Error( szError );
	psSHP->sHooks.FClose( psSHP->fpSHP );
	psSHP->sHooks.FClose( psSHP->fpSHX );
        if (psSHP->panRecOffset) free( psSHP->panRecOffset );
        if (psSHP->panRecSize) free( psSHP->panRecSize );
        if (pabyBuf) free( pabyBuf );
        free( psSHP );
        return( NULL );
    }

    if( (int) psSHP->sHooks.FRead( pabyBuf, 8, psSHP->nRecords, psSHP->fpSHX ) 
			!= psSHP->nRecords )
    {
        char szError[200];

        sprintf( szError, 
                 "Failed to read all values for %d records in .shx file.",
                 psSHP->nRecords );
        psSHP->sHooks.Error( szError );

        /* SHX is short or unreadable for some reason. */
	psSHP->sHooks.FClose( psSHP->fpSHP );
	psSHP->sHooks.FClose( psSHP->fpSHX );
        free( psSHP->panRecOffset );
        free( psSHP->panRecSize );
        free( pabyBuf );
	free( psSHP );

	return( NULL );
    }
    
    /* In read-only mode, we can close the SHX now */
    if (strcmp(pszAccess, "rb") == 0)
    {
        psSHP->sHooks.FClose( psSHP->fpSHX );
        psSHP->fpSHX = NULL;
    }

    for( i = 0; i < psSHP->nRecords; i++ )
    {
	int32		nOffset, nLength;

	memcpy( &nOffset, pabyBuf + i * 8, 4 );
	if( !bBigEndian ) SwapWord( 4, &nOffset );

	memcpy( &nLength, pabyBuf + i * 8 + 4, 4 );
	if( !bBigEndian ) SwapWord( 4, &nLength );

	psSHP->panRecOffset[i] = nOffset*2;
	psSHP->panRecSize[i] = nLength*2;
    }
    free( pabyBuf );

    return( psSHP );
}


/************************************************************************/
/*                              SHPOpen()                               */
/************************************************************************/

SHPHandle SHPAPI_CALL
SHPOpen( const char * pszLayer, const char * pszAccess )

{
    SAHooks sHooks;

    SASetupDefaultHooks( &sHooks );

    return SHPOpenLL( pszLayer, pszAccess, &sHooks );
}

/************************************************************************/
/*                              SHPClose()                              */
/*								       	*/
/*	Close the .shp and .shx files.					*/
/************************************************************************/

void SHPAPI_CALL
SHPClose(SHPHandle psSHP )

{
    if( psSHP == NULL )
        return;

/* -------------------------------------------------------------------- */
/*	Update the header if we have modified anything.			*/
/* -------------------------------------------------------------------- */
    /*if( psSHP->bUpdated )
	SHPWriteHeader( psSHP );*/

/* -------------------------------------------------------------------- */
/*      Free all resources, and close files.                            */
/* -------------------------------------------------------------------- */
    free( psSHP->panRecOffset );
    free( psSHP->panRecSize );

    if ( psSHP->fpSHX != NULL)
        psSHP->sHooks.FClose( psSHP->fpSHX );
    psSHP->sHooks.FClose( psSHP->fpSHP );

    if( psSHP->pabyRec != NULL )
    {
        free( psSHP->pabyRec );
    }
    
    free( psSHP );
}

/************************************************************************/
/*                             SHPGetInfo()                             */
/*                                                                      */
/*      Fetch general information about the shape file.                 */
/************************************************************************/

void SHPAPI_CALL
SHPGetInfo(SHPHandle psSHP, int * pnEntities, int * pnShapeType,
           double * padfMinBound, double * padfMaxBound )

{
    int		i;

    if( psSHP == NULL )
        return;
    
    if( pnEntities != NULL )
        *pnEntities = psSHP->nRecords;

    if( pnShapeType != NULL )
        *pnShapeType = psSHP->nShapeType;

    for( i = 0; i < 4; i++ )
    {
        if( padfMinBound != NULL )
            padfMinBound[i] = psSHP->adBoundsMin[i];
        if( padfMaxBound != NULL )
            padfMaxBound[i] = psSHP->adBoundsMax[i];
    }
}

/************************************************************************/
/*                          SHPReadObject()                             */
/*                                                                      */
/*      Read the vertices, parts, and other non-attribute information	*/
/*	for one shape.							*/
/************************************************************************/

SHPObject SHPAPI_CALL1(*)
SHPReadObject( SHPHandle psSHP, int hEntity )

{
    int                  nEntitySize, nRequiredSize;
    SHPObject		*psShape;
    char                 pszErrorMsg[128];

	
/* -------------------------------------------------------------------- */
/*      Validate the record/entity number.                              */
/* -------------------------------------------------------------------- */
    if( hEntity < 0 || hEntity >= psSHP->nRecords )
        return( NULL );

/* -------------------------------------------------------------------- */
/*      Ensure our record buffer is large enough.                       */
/* -------------------------------------------------------------------- */
    nEntitySize = psSHP->panRecSize[hEntity]+8;
    if( nEntitySize > psSHP->nBufSize )
    {
	psSHP->pabyRec = (uchar *) SfRealloc(psSHP->pabyRec,nEntitySize);
        if (psSHP->pabyRec == NULL)
        {
            char szError[200];

            /* Reallocate previous successfull size for following features */
            psSHP->pabyRec = malloc(psSHP->nBufSize);

            sprintf( szError, 
                     "Not enough memory to allocate requested memory (nBufSize=%d). "
                     "Probably broken SHP file", psSHP->nBufSize );
            psSHP->sHooks.Error( szError );
            return NULL;
        }

        /* Only set new buffer size after successfull alloc */
	psSHP->nBufSize = nEntitySize;
    }

    /* In case we were not able to reallocate the buffer on a previous step */
    if (psSHP->pabyRec == NULL)
    {
        return NULL;
    }
	
/* -------------------------------------------------------------------- */
/*      Read the record.                                                */
/* -------------------------------------------------------------------- */
    if( psSHP->sHooks.FSeek( psSHP->fpSHP, psSHP->panRecOffset[hEntity], 0 ) != 0 )
    {
        /*
         * TODO - mloskot: Consider detailed diagnostics of shape file,
         * for example to detect if file is truncated.
         */
        char str[128];
        sprintf( str,
                 "Error in fseek() reading object from .shp file at offset %u",
                 psSHP->panRecOffset[hEntity]);

        psSHP->sHooks.Error( str );
        return NULL;
    }

    if( psSHP->sHooks.FRead( psSHP->pabyRec, nEntitySize, 1, psSHP->fpSHP ) != 1 )
    {
        /*
         * TODO - mloskot: Consider detailed diagnostics of shape file,
         * for example to detect if file is truncated.
         */
        char str[128];
        sprintf( str,
                 "Error in fread() reading object of size %u from .shp file",
                 nEntitySize);

        psSHP->sHooks.Error( str );
        return NULL;
    }

/* -------------------------------------------------------------------- */
/*	Allocate and minimally initialize the object.			*/
/* -------------------------------------------------------------------- */
    psShape = (SHPObject *) calloc(1,sizeof(SHPObject));
    psShape->nShapeId = hEntity;
    psShape->bMeasureIsUsed = FALSE;

    if ( 8 + 4 > nEntitySize )
    {
        snprintf(pszErrorMsg, 128, "Corrupted .shp file : shape %d : nEntitySize = %d",
                    hEntity, nEntitySize); 
        psSHP->sHooks.Error( pszErrorMsg );
        SHPDestroyObject(psShape);
        return NULL;
    }
    memcpy( &psShape->nSHPType, psSHP->pabyRec + 8, 4 );

    if( bBigEndian ) SwapWord( 4, &(psShape->nSHPType) );

/* ==================================================================== */
/*  Extract vertices for a Polygon or Arc.				*/
/* ==================================================================== */
    if( psShape->nSHPType == SHPT_POLYGON || psShape->nSHPType == SHPT_ARC
        || psShape->nSHPType == SHPT_POLYGONZ
        || psShape->nSHPType == SHPT_POLYGONM
        || psShape->nSHPType == SHPT_ARCZ
        || psShape->nSHPType == SHPT_ARCM
        || psShape->nSHPType == SHPT_MULTIPATCH )
    {
	int32		nPoints, nParts;
	int    		i, nOffset;

        if ( 40 + 8 + 4 > nEntitySize )
        {
            snprintf(pszErrorMsg, 128, "Corrupted .shp file : shape %d : nEntitySize = %d",
                     hEntity, nEntitySize); 
            psSHP->sHooks.Error( pszErrorMsg );
            SHPDestroyObject(psShape);
            return NULL;
        }
/* -------------------------------------------------------------------- */
/*	Get the X/Y bounds.						*/
/* -------------------------------------------------------------------- */
        memcpy( &(psShape->dfXMin), psSHP->pabyRec + 8 +  4, 8 );
        memcpy( &(psShape->dfYMin), psSHP->pabyRec + 8 + 12, 8 );
        memcpy( &(psShape->dfXMax), psSHP->pabyRec + 8 + 20, 8 );
        memcpy( &(psShape->dfYMax), psSHP->pabyRec + 8 + 28, 8 );

	if( bBigEndian ) SwapWord( 8, &(psShape->dfXMin) );
	if( bBigEndian ) SwapWord( 8, &(psShape->dfYMin) );
	if( bBigEndian ) SwapWord( 8, &(psShape->dfXMax) );
	if( bBigEndian ) SwapWord( 8, &(psShape->dfYMax) );

/* -------------------------------------------------------------------- */
/*      Extract part/point count, and build vertex and part arrays      */
/*      to proper size.                                                 */
/* -------------------------------------------------------------------- */
	memcpy( &nPoints, psSHP->pabyRec + 40 + 8, 4 );
	memcpy( &nParts, psSHP->pabyRec + 36 + 8, 4 );

	if( bBigEndian ) SwapWord( 4, &nPoints );
	if( bBigEndian ) SwapWord( 4, &nParts );

        if (nPoints < 0 || nParts < 0 ||
            nPoints > 50 * 1000 * 1000 || nParts > 10 * 1000 * 1000)
        {
            snprintf(pszErrorMsg, 128, "Corrupted .shp file : shape %d, nPoints=%d, nParts=%d.",
                        hEntity, nPoints, nParts);
            psSHP->sHooks.Error( pszErrorMsg );
            SHPDestroyObject(psShape);
            return NULL;
        }
        
        /* With the previous checks on nPoints and nParts, */
        /* we should not overflow here and after */
        /* since 50 M * (16 + 8 + 8) = 1 600 MB */
        nRequiredSize = 44 + 8 + 4 * nParts + 16 * nPoints;
        if ( psShape->nSHPType == SHPT_POLYGONZ
            || psShape->nSHPType == SHPT_ARCZ
            || psShape->nSHPType == SHPT_MULTIPATCH )
        {
            nRequiredSize += 16 + 8 * nPoints;
        }
        if( psShape->nSHPType == SHPT_MULTIPATCH )
        {
            nRequiredSize += 4 * nParts;
        }
        if (nRequiredSize > nEntitySize)
        {
            snprintf(pszErrorMsg, 128, "Corrupted .shp file : shape %d, nPoints=%d, nParts=%d, nEntitySize=%d.",
                        hEntity, nPoints, nParts, nEntitySize);
            psSHP->sHooks.Error( pszErrorMsg );
            SHPDestroyObject(psShape);
            return NULL;
        }

	psShape->nVertices = nPoints;
        psShape->padfX = (double *) calloc(nPoints,sizeof(double));
        psShape->padfY = (double *) calloc(nPoints,sizeof(double));
        psShape->padfZ = (double *) calloc(nPoints,sizeof(double));
        psShape->padfM = (double *) calloc(nPoints,sizeof(double));

	psShape->nParts = nParts;
        psShape->panPartStart = (int *) calloc(nParts,sizeof(int));
        psShape->panPartType = (int *) calloc(nParts,sizeof(int));
        
        if (psShape->padfX == NULL ||
            psShape->padfY == NULL ||
            psShape->padfZ == NULL ||
            psShape->padfM == NULL ||
            psShape->panPartStart == NULL ||
            psShape->panPartType == NULL)
        {
            snprintf(pszErrorMsg, 128,
                     "Not enough memory to allocate requested memory (nPoints=%d, nParts=%d) for shape %d. "
                     "Probably broken SHP file", hEntity, nPoints, nParts );
            psSHP->sHooks.Error( pszErrorMsg );
            SHPDestroyObject(psShape);
            return NULL;
        }

        for( i = 0; i < nParts; i++ )
            psShape->panPartType[i] = SHPP_RING;

/* -------------------------------------------------------------------- */
/*      Copy out the part array from the record.                        */
/* -------------------------------------------------------------------- */
	memcpy( psShape->panPartStart, psSHP->pabyRec + 44 + 8, 4 * nParts );
	for( i = 0; i < nParts; i++ )
	{
	    if( bBigEndian ) SwapWord( 4, psShape->panPartStart+i );

            /* We check that the offset is inside the vertex array */
            if (psShape->panPartStart[i] < 0 ||
                psShape->panPartStart[i] >= psShape->nVertices)
            {
                snprintf(pszErrorMsg, 128, "Corrupted .shp file : shape %d : panPartStart[%d] = %d, nVertices = %d",
                         hEntity, i, psShape->panPartStart[i], psShape->nVertices); 
                psSHP->sHooks.Error( pszErrorMsg );
                SHPDestroyObject(psShape);
                return NULL;
            }
            if (i > 0 && psShape->panPartStart[i] <= psShape->panPartStart[i-1])
            {
                snprintf(pszErrorMsg, 128, "Corrupted .shp file : shape %d : panPartStart[%d] = %d, panPartStart[%d] = %d",
                         hEntity, i, psShape->panPartStart[i], i - 1, psShape->panPartStart[i - 1]); 
                psSHP->sHooks.Error( pszErrorMsg );
                SHPDestroyObject(psShape);
                return NULL;
            }
	}

	nOffset = 44 + 8 + 4*nParts;

/* -------------------------------------------------------------------- */
/*      If this is a multipatch, we will also have parts types.         */
/* -------------------------------------------------------------------- */
        if( psShape->nSHPType == SHPT_MULTIPATCH )
        {
            memcpy( psShape->panPartType, psSHP->pabyRec + nOffset, 4*nParts );
            for( i = 0; i < nParts; i++ )
            {
                if( bBigEndian ) SwapWord( 4, psShape->panPartType+i );
            }

            nOffset += 4*nParts;
        }
        
/* -------------------------------------------------------------------- */
/*      Copy out the vertices from the record.                          */
/* -------------------------------------------------------------------- */
	for( i = 0; i < nPoints; i++ )
	{
	    memcpy(psShape->padfX + i,
		   psSHP->pabyRec + nOffset + i * 16,
		   8 );

	    memcpy(psShape->padfY + i,
		   psSHP->pabyRec + nOffset + i * 16 + 8,
		   8 );

	    if( bBigEndian ) SwapWord( 8, psShape->padfX + i );
	    if( bBigEndian ) SwapWord( 8, psShape->padfY + i );
	}

        nOffset += 16*nPoints;
        
/* -------------------------------------------------------------------- */
/*      If we have a Z coordinate, collect that now.                    */
/* -------------------------------------------------------------------- */
        if( psShape->nSHPType == SHPT_POLYGONZ
            || psShape->nSHPType == SHPT_ARCZ
            || psShape->nSHPType == SHPT_MULTIPATCH )
        {
            memcpy( &(psShape->dfZMin), psSHP->pabyRec + nOffset, 8 );
            memcpy( &(psShape->dfZMax), psSHP->pabyRec + nOffset + 8, 8 );
            
            if( bBigEndian ) SwapWord( 8, &(psShape->dfZMin) );
            if( bBigEndian ) SwapWord( 8, &(psShape->dfZMax) );
            
            for( i = 0; i < nPoints; i++ )
            {
                memcpy( psShape->padfZ + i,
                        psSHP->pabyRec + nOffset + 16 + i*8, 8 );
                if( bBigEndian ) SwapWord( 8, psShape->padfZ + i );
            }

            nOffset += 16 + 8*nPoints;
        }

/* -------------------------------------------------------------------- */
/*      If we have a M measure value, then read it now.  We assume      */
/*      that the measure can be present for any shape if the size is    */
/*      big enough, but really it will only occur for the Z shapes      */
/*      (options), and the M shapes.                                    */
/* -------------------------------------------------------------------- */
        if( nEntitySize >= nOffset + 16 + 8*nPoints )
        {
            memcpy( &(psShape->dfMMin), psSHP->pabyRec + nOffset, 8 );
            memcpy( &(psShape->dfMMax), psSHP->pabyRec + nOffset + 8, 8 );
            
            if( bBigEndian ) SwapWord( 8, &(psShape->dfMMin) );
            if( bBigEndian ) SwapWord( 8, &(psShape->dfMMax) );
            
            for( i = 0; i < nPoints; i++ )
            {
                memcpy( psShape->padfM + i,
                        psSHP->pabyRec + nOffset + 16 + i*8, 8 );
                if( bBigEndian ) SwapWord( 8, psShape->padfM + i );
            }
            psShape->bMeasureIsUsed = TRUE;
        }
    }

/* ==================================================================== */
/*  Extract vertices for a MultiPoint.					*/
/* ==================================================================== */
    else if( psShape->nSHPType == SHPT_MULTIPOINT
             || psShape->nSHPType == SHPT_MULTIPOINTM
             || psShape->nSHPType == SHPT_MULTIPOINTZ )
    {
	int32		nPoints;
	int    		i, nOffset;

        if ( 44 + 4 > nEntitySize )
        {
            snprintf(pszErrorMsg, 128, "Corrupted .shp file : shape %d : nEntitySize = %d",
                     hEntity, nEntitySize); 
            psSHP->sHooks.Error( pszErrorMsg );
            SHPDestroyObject(psShape);
            return NULL;
        }
	memcpy( &nPoints, psSHP->pabyRec + 44, 4 );

	if( bBigEndian ) SwapWord( 4, &nPoints );

        if (nPoints < 0 || nPoints > 50 * 1000 * 1000)
        {
            snprintf(pszErrorMsg, 128, "Corrupted .shp file : shape %d : nPoints = %d",
                     hEntity, nPoints); 
            psSHP->sHooks.Error( pszErrorMsg );
            SHPDestroyObject(psShape);
            return NULL;
        }

        nRequiredSize = 48 + nPoints * 16;
        if( psShape->nSHPType == SHPT_MULTIPOINTZ )
        {
            nRequiredSize += 16 + nPoints * 8;
        }
        if (nRequiredSize > nEntitySize)
        {
            snprintf(pszErrorMsg, 128, "Corrupted .shp file : shape %d : nPoints = %d, nEntitySize = %d",
                     hEntity, nPoints, nEntitySize); 
            psSHP->sHooks.Error( pszErrorMsg );
            SHPDestroyObject(psShape);
            return NULL;
        }
        
	psShape->nVertices = nPoints;
        psShape->padfX = (double *) calloc(nPoints,sizeof(double));
        psShape->padfY = (double *) calloc(nPoints,sizeof(double));
        psShape->padfZ = (double *) calloc(nPoints,sizeof(double));
        psShape->padfM = (double *) calloc(nPoints,sizeof(double));

        if (psShape->padfX == NULL ||
            psShape->padfY == NULL ||
            psShape->padfZ == NULL ||
            psShape->padfM == NULL)
        {
            snprintf(pszErrorMsg, 128,
                     "Not enough memory to allocate requested memory (nPoints=%d) for shape %d. "
                     "Probably broken SHP file", hEntity, nPoints );
            psSHP->sHooks.Error( pszErrorMsg );
            SHPDestroyObject(psShape);
            return NULL;
        }

	for( i = 0; i < nPoints; i++ )
	{
	    memcpy(psShape->padfX+i, psSHP->pabyRec + 48 + 16 * i, 8 );
	    memcpy(psShape->padfY+i, psSHP->pabyRec + 48 + 16 * i + 8, 8 );

	    if( bBigEndian ) SwapWord( 8, psShape->padfX + i );
	    if( bBigEndian ) SwapWord( 8, psShape->padfY + i );
	}

        nOffset = 48 + 16*nPoints;
        
/* -------------------------------------------------------------------- */
/*	Get the X/Y bounds.						*/
/* -------------------------------------------------------------------- */
        memcpy( &(psShape->dfXMin), psSHP->pabyRec + 8 +  4, 8 );
        memcpy( &(psShape->dfYMin), psSHP->pabyRec + 8 + 12, 8 );
        memcpy( &(psShape->dfXMax), psSHP->pabyRec + 8 + 20, 8 );
        memcpy( &(psShape->dfYMax), psSHP->pabyRec + 8 + 28, 8 );

	if( bBigEndian ) SwapWord( 8, &(psShape->dfXMin) );
	if( bBigEndian ) SwapWord( 8, &(psShape->dfYMin) );
	if( bBigEndian ) SwapWord( 8, &(psShape->dfXMax) );
	if( bBigEndian ) SwapWord( 8, &(psShape->dfYMax) );

/* -------------------------------------------------------------------- */
/*      If we have a Z coordinate, collect that now.                    */
/* -------------------------------------------------------------------- */
        if( psShape->nSHPType == SHPT_MULTIPOINTZ )
        {
            memcpy( &(psShape->dfZMin), psSHP->pabyRec + nOffset, 8 );
            memcpy( &(psShape->dfZMax), psSHP->pabyRec + nOffset + 8, 8 );
            
            if( bBigEndian ) SwapWord( 8, &(psShape->dfZMin) );
            if( bBigEndian ) SwapWord( 8, &(psShape->dfZMax) );
            
            for( i = 0; i < nPoints; i++ )
            {
                memcpy( psShape->padfZ + i,
                        psSHP->pabyRec + nOffset + 16 + i*8, 8 );
                if( bBigEndian ) SwapWord( 8, psShape->padfZ + i );
            }

            nOffset += 16 + 8*nPoints;
        }

/* -------------------------------------------------------------------- */
/*      If we have a M measure value, then read it now.  We assume      */
/*      that the measure can be present for any shape if the size is    */
/*      big enough, but really it will only occur for the Z shapes      */
/*      (options), and the M shapes.                                    */
/* -------------------------------------------------------------------- */
        if( nEntitySize >= nOffset + 16 + 8*nPoints )
        {
            memcpy( &(psShape->dfMMin), psSHP->pabyRec + nOffset, 8 );
            memcpy( &(psShape->dfMMax), psSHP->pabyRec + nOffset + 8, 8 );
            
            if( bBigEndian ) SwapWord( 8, &(psShape->dfMMin) );
            if( bBigEndian ) SwapWord( 8, &(psShape->dfMMax) );
            
            for( i = 0; i < nPoints; i++ )
            {
                memcpy( psShape->padfM + i,
                        psSHP->pabyRec + nOffset + 16 + i*8, 8 );
                if( bBigEndian ) SwapWord( 8, psShape->padfM + i );
            }
            psShape->bMeasureIsUsed = TRUE;
        }
    }

/* ==================================================================== */
/*      Extract vertices for a point.                                   */
/* ==================================================================== */
    else if( psShape->nSHPType == SHPT_POINT
             || psShape->nSHPType == SHPT_POINTM
             || psShape->nSHPType == SHPT_POINTZ )
    {
        int	nOffset;
        
	psShape->nVertices = 1;
        psShape->padfX = (double *) calloc(1,sizeof(double));
        psShape->padfY = (double *) calloc(1,sizeof(double));
        psShape->padfZ = (double *) calloc(1,sizeof(double));
        psShape->padfM = (double *) calloc(1,sizeof(double));

        if (20 + 8 + (( psShape->nSHPType == SHPT_POINTZ ) ? 8 : 0)> nEntitySize)
        {
            snprintf(pszErrorMsg, 128, "Corrupted .shp file : shape %d : nEntitySize = %d",
                     hEntity, nEntitySize); 
            psSHP->sHooks.Error( pszErrorMsg );
            SHPDestroyObject(psShape);
            return NULL;
        }
	memcpy( psShape->padfX, psSHP->pabyRec + 12, 8 );
	memcpy( psShape->padfY, psSHP->pabyRec + 20, 8 );

	if( bBigEndian ) SwapWord( 8, psShape->padfX );
	if( bBigEndian ) SwapWord( 8, psShape->padfY );

        nOffset = 20 + 8;
        
/* -------------------------------------------------------------------- */
/*      If we have a Z coordinate, collect that now.                    */
/* -------------------------------------------------------------------- */
        if( psShape->nSHPType == SHPT_POINTZ )
        {
            memcpy( psShape->padfZ, psSHP->pabyRec + nOffset, 8 );
        
            if( bBigEndian ) SwapWord( 8, psShape->padfZ );
            
            nOffset += 8;
        }

/* -------------------------------------------------------------------- */
/*      If we have a M measure value, then read it now.  We assume      */
/*      that the measure can be present for any shape if the size is    */
/*      big enough, but really it will only occur for the Z shapes      */
/*      (options), and the M shapes.                                    */
/* -------------------------------------------------------------------- */
        if( nEntitySize >= nOffset + 8 )
        {
            memcpy( psShape->padfM, psSHP->pabyRec + nOffset, 8 );
        
            if( bBigEndian ) SwapWord( 8, psShape->padfM );
            psShape->bMeasureIsUsed = TRUE;
        }

/* -------------------------------------------------------------------- */
/*      Since no extents are supplied in the record, we will apply      */
/*      them from the single vertex.                                    */
/* -------------------------------------------------------------------- */
        psShape->dfXMin = psShape->dfXMax = psShape->padfX[0];
        psShape->dfYMin = psShape->dfYMax = psShape->padfY[0];
        psShape->dfZMin = psShape->dfZMax = psShape->padfZ[0];
        psShape->dfMMin = psShape->dfMMax = psShape->padfM[0];
    }

    return( psShape );
}




 int SHPSize( char *pszFilename)

{
    SHPHandle	hSHP;
    int		nShapeType, i,nEntities, iPart, bValidate = 0,nInvalidCount=0;
    double 	adfMinBound[4], adfMaxBound[4];

/* -------------------------------------------------------------------- */
/*      Open the shapefile.                                             */
/* -------------------------------------------------------------------- */
    hSHP = SHPOpen(pszFilename,"rb");

/* -------------------------------------------------------------------- */
/*      Print out the file bounds.                                      */
/* -------------------------------------------------------------------- */
    SHPGetInfo( hSHP, &nEntities, &nShapeType, adfMinBound, adfMaxBound );
    SHPClose( hSHP );
    return nEntities;
}




SHPObject *oneSHP( char *pszFilename, int i)

{
    SHPHandle	hSHP;
    int		nShapeType, nEntities,iPart, bValidate = 0,nInvalidCount=0;
    int         bHeaderOnly = 0;
    double 	adfMinBound[4], adfMaxBound[4];

/* -------------------------------------------------------------------- */
/*      Open the shapefile.                                             */
/* -------------------------------------------------------------------- */
    hSHP = SHPOpen(pszFilename,"rb");

/* -------------------------------------------------------------------- */
/*      Print out the file bounds.                                      */
/* -------------------------------------------------------------------- */
    SHPGetInfo( hSHP, &nEntities, &nShapeType, adfMinBound, adfMaxBound );

/* -------------------------------------------------------------------- */
/*	Skim over the list of shapes, printing all the vertices.	*/
/* -------------------------------------------------------------------- */
	SHPObject  *psShape;
	psShape = SHPReadObject( hSHP, i );

    SHPClose( hSHP );
    return psShape;
}


SHPObject **allSHP( char *pszFilename)

{
    SHPHandle	hSHP;
    int		nShapeType, nEntities,iPart, bValidate = 0,nInvalidCount=0;
    int         bHeaderOnly = 0;
    double 	adfMinBound[4], adfMaxBound[4];
    SHPObject** tabSHP;
    int         i;
/* -------------------------------------------------------------------- */
/*      Open the shapefile.                                             */
/* -------------------------------------------------------------------- */

    hSHP = SHPOpen(pszFilename,"rb");

/* -------------------------------------------------------------------- */
/*      Print out the file bounds.                                      */
/* -------------------------------------------------------------------- */
    SHPGetInfo( hSHP, &nEntities, &nShapeType, adfMinBound, adfMaxBound );
    tabSHP = malloc (sizeof (SHPObject*) * (nEntities));
    //tabSHP[nEntities +1] = 0;
/* -------------------------------------------------------------------- */
/*	Skim over the list of shapes, printing all the vertices.	*/
/* -------------------------------------------------------------------- */
    for (i=0; i<nEntities; i++)
    { 
	//SHPObject  *psShape;
	//psShape = SHPReadObject( hSHP, i );
	tabSHP[i] = SHPReadObject( hSHP, i );
    }
    SHPClose( hSHP );
    return tabSHP;
}


/* **********************************************************************/
/*       Lecture.shp DUMPSHP.                                           */
/* ******************************************************************** */


SHPObject **dumpSHP( char *pszFilename)

{
    SHPHandle	hSHP;
    int		nShapeType, nEntities, i, iPart, bValidate = 0,nInvalidCount=0;
    int         bHeaderOnly = 0;
    double 	adfMinBound[4], adfMaxBound[4];
    SHPObject **tabSHP;

/* -------------------------------------------------------------------- */
/*      Open the shapefile.                                             */
/* -------------------------------------------------------------------- */
    hSHP = SHPOpen(pszFilename,"rb");

/* -------------------------------------------------------------------- */
/*      Print out the file bounds.                                      */
/* -------------------------------------------------------------------- */
    SHPGetInfo( hSHP, &nEntities, &nShapeType, adfMinBound, adfMaxBound );
    /*tabSHP = malloc(sizeof(SHPObject)*(nEntities +1));
    tabSHP[nEntities +1] = '\o';*/
    tabSHP = malloc(sizeof(SHPObject)*(1+1));
    //tabSHP[1+1] = '\o';

/* -------------------------------------------------------------------- */
/*	Skim over the list of shapes, printing all the vertices.	*/
/* -------------------------------------------------------------------- */
    /*for( i = 0; i < nEntities && !bHeaderOnly; i++ )
    {
        SHPObject	*psShape;

	psShape = SHPReadObject( hSHP, 0 );
	tabSHP[i]= psShape;
    }*/
	SHPObject	*psShape;

	psShape = SHPReadObject( hSHP, 0 );
	tabSHP[0]= psShape;

    SHPClose( hSHP );
    return tabSHP;
    /*return SHPReadObject( hSHP, 0 );*/
}

/* **********************************************************************/
/*       Delete a tab of SHPObject                                      */
/* ******************************************************************** */


void DeleteSHP(SHPObject **tabSHP)

{
    int i;

    i=0;
    //while(tabSHP[i] != '\o')
    while(tabSHP[i] != 0)
    {
        SHPDestroyObject( tabSHP[i] );
	i++;
    }
}


int main()
{

   /*SHPObject **tabSHP;
    tabSHP =  dumpSHP("/home/joyeux/legall/Netgen/bretagne.shapefiles/europe_western_europe_france_bretagne_administrative.shx");
    DeleteSHP(tabSHP);*/
 	printf("%d\n",SHPSize("/home/joyeux/legall/Netgen/bretagne.shapefiles/europe_western_europe_france_bretagne_administrative.shx"));
return 0;
}
