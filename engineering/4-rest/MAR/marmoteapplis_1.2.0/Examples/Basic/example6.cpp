// Example that creates MarmoteSet objects and enumerates them.
//
// Usage: example6
//

// Include necessary header files to use marmoteCore and other functonalities.
#include "markovChain/markov_chain.h"
#include "Set/marmote_interval.h"
#include "Set/marmote_box.h"
#include "Set/marmote_set.h"
#include <iostream>
#include <sstream>
#include <algorithm>
#include <stdlib.h>
#include <stdio.h>
#include <malloc.h>
#include <time.h>

// Forward declaration
void testSet( MarmoteSet* set, string name );

// The application code devised for testing the MarmoteBox object

int main( int argc, char** argv ) 
{
	int dim1[1] = {2};
        int dim2[2]= {2,3};

        // Creation of a 1-dimensional MarmoteBox with size 2
	MarmoteBox* bb1 = new MarmoteBox(1, dim1);
	// Creation of a 2-dimensional MarmoteBox with size 2x3
        MarmoteBox* bb2 = new MarmoteBox(2, dim2);
	// Creation of the MarmoteInterval [8..13]
        MarmoteInterval* aa = new MarmoteInterval(8,13);

	// Statistics and enumeration of the 1-d box
	testSet( bb1, "Marmote Box #1" );

	// Test with a pointer of the generic type MarmoteSet
	MarmoteSet* cc = bb1;
	testSet( cc, "Pointer to Marmote Box #1" );

	// Statistics and enumeration of the 2-d box
	testSet( bb2, "Marmote Box #2" );
	
	// Test with a pointer of the generic type MarmoteSet
	cc = bb2;
	testSet( cc, "Pointer to Marmote Box #2" );

	// Statistics and enumeration of the interval
	testSet( aa, "Marmote Interval" );

	// Test with a pointer of the generic type MarmoteSet
        cc = aa;
	testSet( cc, "Pointer to Marmote Interval" );

	// cleanup
	delete bb1;
	delete bb2;
	delete aa;

	// Exit with OK code
  	return 0;
}

// The test procedure
// The input is:
// set: the object to be tested
// name: a string describing the test
//
void testSet( MarmoteSet* set, string name )
{
        fprintf(stdout,"###### %s features:\n", name.c_str() );
	fprintf(stdout,"Cardinal = %d, NbDimensions %d:\n",
		(int) set->Cardinal(),set->tot_nb_dims());

	fprintf(stdout,"# Direct enumeration of %s:\n", name.c_str() );
	set->Enumerate();
	fprintf(stdout,"\n");

	fprintf(stdout,"# Enumeration of %s via through walk:\n", name.c_str() );
	int* statebuffer = (int*) calloc( set->Cardinal(), sizeof(int) );
	set->FirstState(statebuffer);
	for(int i = 0 ; i < set->Cardinal() ; i++)
	  {
		fprintf(stdout,"stateIndex: %d\t state", set->Index(statebuffer));
		set->PrintState(stdout,statebuffer);
		fprintf(stdout,"\n");
		set->NextState(statebuffer);
	}

	fprintf(stdout,"# Enumeration of %s via index access:\n", name.c_str() );
	for(int i = 0 ; i < set->Cardinal() ; i++)
	  {
  	        set->DecodeState(i,statebuffer);
		fprintf(stdout,"stateIndex: %d\t state", i);
		set->PrintState(stdout,statebuffer);
		fprintf(stdout,"\n");
		set->NextState(statebuffer);
	}
	fprintf(stdout,"\n");

	// cleanup
	free(statebuffer);
}
