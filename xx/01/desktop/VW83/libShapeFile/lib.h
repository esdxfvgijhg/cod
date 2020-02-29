/* -------------------------------------------------------------------- */
/*      IO/Error hook functions.                                        */
/* -------------------------------------------------------------------- */



typedef struct {
    int *     (*FOpen) ( const char *filename, const char *access);
    unsigned long   (*FRead) ( void *p, unsigned long size, unsigned long nmemb, int* file);
    unsigned long   (*FWrite)( void *p, unsigned long size, unsigned long nmemb, int* file);
    unsigned long   (*FSeek) ( int* file, unsigned long offset, int whence );
    unsigned long   (*FTell) ( int* file );
    int        (*FFlush)( int* file );
    int        (*FClose)( int* file );
    int        (*Remove) ( const char *filename );

    void       (*Error) ( const char *message );
    double     (*Atof)  ( const char *str );
} SAHooks;




/************************************************************************/
/*                             SHP Support.                             */
/************************************************************************/
typedef	struct
{
    SAHooks sHooks;

    int *fpSHP;
    int *fpSHX;

    int		nShapeType;				/* SHPT_* */
    
    unsigned int 	nFileSize;				/* SHP file */

    int         nRecords;
    int		nMaxRecords;
    unsigned int		*panRecOffset;
    unsigned int		*panRecSize;

    double	adBoundsMin[4];
    double	adBoundsMax[4];

    int		bUpdated;

    unsigned char *pabyRec;
    int         nBufSize;
} SHPInfo;

typedef SHPInfo*  SHPHandle;

/* -------------------------------------------------------------------- */
/*      Shape types (nSHPType)                                          */
/* -------------------------------------------------------------------- */
#define SHPT_NULL	0
#define SHPT_POINT	1
#define SHPT_ARC	3
#define SHPT_POLYGON	5
#define SHPT_MULTIPOINT	8
#define SHPT_POINTZ	11
#define SHPT_ARCZ	13
#define SHPT_POLYGONZ	15
#define SHPT_MULTIPOINTZ 18
#define SHPT_POINTM	21
#define SHPT_ARCM	23
#define SHPT_POLYGONM	25
#define SHPT_MULTIPOINTM 28
#define SHPT_MULTIPATCH 31


/* -------------------------------------------------------------------- */
/*      Part types - everything but SHPT_MULTIPATCH just uses           */
/*      SHPP_RING.                                                      */
/* -------------------------------------------------------------------- */

#define SHPP_TRISTRIP	0
#define SHPP_TRIFAN	1
#define SHPP_OUTERRING	2
#define SHPP_INNERRING	3
#define SHPP_FIRSTRING	4
#define SHPP_RING	5

/* -------------------------------------------------------------------- */
/*      SHPObject - represents on shape (without attributes) read       */
/*      from the .shp file.                                             */
/* -------------------------------------------------------------------- */
typedef struct
{
    int		nSHPType;

    int		nShapeId; /* -1 is unknown/unassigned */

    int		nParts;
    int		*panPartStart;
    int		*panPartType;
    
    int		nVertices;
    double	*padfX;
    double	*padfY;
    double	*padfZ;
    double	*padfM;

    double	dfXMin;
    double	dfYMin;
    double	dfZMin;
    double	dfMMin;

    double	dfXMax;
    double	dfYMax;
    double	dfZMax;
    double	dfMMax;

    int		bMeasureIsUsed;
} SHPObject;


/* -------------------------------------------------------------------- */
/*      SHP API Prototypes                                              */
/* -------------------------------------------------------------------- */

    int SHPSize( char *pszFilename);
    SHPObject *oneSHP( char *pszFilename, int i);
    SHPObject **allSHP( char *pszFilename);
    SHPObject **dumpSHP( char *pszFilename );
/*void dumpSHP( char *pszFilename,SHPObject **tabSHP );*/
    void DeleteSHP(SHPObject **tabSHP);
    SHPHandle  SHPOpen( const char * pszShapeFile, const char * pszAccess );
    void       SHPGetInfo( SHPHandle hSHP, int * pnEntities, int * pnShapeType,
                 double * padfMinBound, double * padfMaxBound );
    SHPObject* SHPReadObject( SHPHandle psSHP, int hEntity );
    void       SHPClose( SHPHandle hSHP );
    void       SHPDestroyObject( SHPObject *psObject );

