//from XBORNE/SOR/SOR.c

/**
 * @brief The basic transition element structure for matrix storage in XBORNE.
 *
 */
struct element {
  int ori; /**< end node of the transition */
  double prob; /**< probability of the transition */
};

typedef struct element element;
typedef double *probavector; /* de la taille du nombre d'etats */
typedef int *indexvector; /* de la taille du nombre d'etats */
typedef element *elmtvector; /* de la taille du nombre d'arcs */

//from XBORNE/SOR/SOR.c
extern "C" void mainSOR(char* modelName, double **pi, int *NSommets, 
			int writeResult );
extern "C" void readModel( char* modelName, elmtvector *arc, indexvector *debut, indexvector *taille, int *size );
extern "C" double* doSOR( elmtvector arc, indexvector debut, indexvector taille,  int NSommets );

//from XBORNE/generMarkov/generMarkov.c
extern "C" void mainGenerMarkov(char * modelName);
//from XBORNE/gthLD/gthLD.c
extern "C" void mainGthLD(char * modelName, char * suffix, long double **pi, int *NSommets );
