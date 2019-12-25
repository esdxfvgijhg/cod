// Example that constructs three 9x9 discrete-time Markov chain
// then computes the transient distributions.
//
// Usage: example3 <n> <p1> <p2> <p3> <p4> <p5> <p6> <p7> <p8>
//

// Include necessary header files to use marmoteCore and other functonalities.
#include "markovChain/markov_chain.h"
#include "Distribution/discrete_distribution.h"
#include "transitionStructure/sparse_matrix.h"
#include <iostream>
#include <sstream>
#include <algorithm>
#include <limits.h>
#include <errno.h>
#include <assert.h>

// Forward declaration of utility
bool parseParameters( int, char**, long int*, double*, double*, double*, double*,
		      double*, double*, double*, double* );

// The application code 

int main( int argc, char** argv ) 
{
	// variables used in the program
	long int var; 
	double prob1;
  	double prob2;
  	double prob3;
	double prob4;
  	double prob5;
  	double prob6;
	double prob7;
  	double prob8;

	// get values from command line
	bool test = parseParameters( argc, argv,
				     &var, &prob1, &prob2, &prob3, &prob4,
				     &prob5, &prob6, &prob7, &prob8 ); 

	if (test)  
	{
		int n = (int) var;
	  	// In this model: state 0 -> marmote is in first mountain,
		// state 1 -> marmote is in second mountain,
		// state 2 -> marmote is in third mountain .. etc ..
	  	// Creating the states array of size 8.
	  	double *states = (double *) malloc(8*sizeof(double));
		for ( int i = 0; i < 8; i++ ) states[i]=i;

	  	// Creating the initial distribution vector of size 8.
	  	double *probas = (double *) malloc(8*sizeof(double));

	  	// Filling the initial distribution vector according to the initial
		// probabilities passed in the arguments.
	  	probas[0] = prob1;
	  	probas[1] = prob2;
	  	probas[2] = prob3;
	  	probas[3] = prob4;
	  	probas[4] = prob5;
	  	probas[5] = prob6;
	  	probas[6] = prob7;
	  	probas[7] = prob8;

                // Create three times the same initial distribution (one for each chain)
	  	DiscreteDistribution* initial1 = new DiscreteDistribution(8,states,probas);
	  	DiscreteDistribution* initial2 = new DiscreteDistribution(8,states,probas);
	  	DiscreteDistribution* initial3 = new DiscreteDistribution(8,states,probas);
	  
	  	// Create 3 discrete-time Markov chains of size 8.
	  	MarkovChain* c1 = new MarkovChain(8,DISCRETE);
	  	MarkovChain* c2 = new MarkovChain(8,DISCRETE);
	  	MarkovChain* c3 = new MarkovChain(8,DISCRETE);

	  	// Assigning the created distribution to chains.
	  	c1->set_init_distribution(initial1);
	  	c2->set_init_distribution(initial2);
	  	c3->set_init_distribution(initial3);

	  	// Creating 3 transition matrices with size 8*8.
	  	SparseMatrix *P1 = new SparseMatrix(8);
	  	SparseMatrix *P2 = new SparseMatrix(8);
	  	SparseMatrix *P3 = new SparseMatrix(8);

	  	// Add entries to the first transition matrix.
	  	P1->addToEntry(0,0,0.2);
		P1->addToEntry(0,1,0.8);
	  	P1->addToEntry(1,0,0.25);
	  	P1->addToEntry(1,1,0.25);
	  	P1->addToEntry(1,2,0.25);
	  	P1->addToEntry(1,3,0.25);
	  	P1->addToEntry(2,0,0.6);
	  	P1->addToEntry(2,2,0.4);
	  	P1->addToEntry(3,2,0.3);
	  	P1->addToEntry(3,3,0.2);
	  	P1->addToEntry(3,4,0.25);
	  	P1->addToEntry(3,5,0.25);
	  	P1->addToEntry(4,4,0.1);
	  	P1->addToEntry(4,5,0.3);
	  	P1->addToEntry(4,6,0.3);
	  	P1->addToEntry(4,7,0.3);
	  	P1->addToEntry(5,5,1.0);
	  	P1->addToEntry(6,4,0.5);
	  	P1->addToEntry(6,6,0.5);
	  	P1->addToEntry(7,4,0.4);
	  	P1->addToEntry(7,5,0.2);
	  	P1->addToEntry(7,6,0.2);
	  	P1->addToEntry(7,7,0.2);

	  	// Add entries to the second transition matrix.
	  	P2->addToEntry(0,0,0.2);
	  	P2->addToEntry(0,1,0.8);
	  	P2->addToEntry(1,0,0.25);
	  	P2->addToEntry(1,1,0.25);
	  	P2->addToEntry(1,2,0.25);
	  	P2->addToEntry(1,3,0.25);
	  	P2->addToEntry(2,0,0.6);
	  	P2->addToEntry(2,2,0.4);
	  	P2->addToEntry(3,2,0.3);
	  	P2->addToEntry(3,3,0.2);
	  	P2->addToEntry(3,4,0.25);
	  	P2->addToEntry(3,5,0.25);
	  	P2->addToEntry(4,4,0.1);
	  	P2->addToEntry(4,5,0.3);
	  	P2->addToEntry(4,6,0.3);
	  	P2->addToEntry(4,7,0.3);
	  	P2->addToEntry(5,5,0.5); // split transition 5->5 to 5->(5,7)
	  	P2->addToEntry(5,7,0.5); // with 1/2 proba each
	  	P2->addToEntry(6,4,0.5);
	  	P2->addToEntry(6,6,0.5);
	  	P2->addToEntry(7,4,0.4);
	  	P2->addToEntry(7,5,0.2);
	  	P2->addToEntry(7,6,0.2);
	  	P2->addToEntry(7,7,0.2);

	  	// Add entries to the third transition matrix.
	  	P3->addToEntry(0,0,0.2);
	  	P3->addToEntry(0,1,0.8);
	  	P3->addToEntry(1,0,0.25);
	  	P3->addToEntry(1,1,0.25);
	  	P3->addToEntry(1,2,0.25);
	  	P3->addToEntry(1,3,0.25);
	  	P3->addToEntry(2,0,0.6);
	  	P3->addToEntry(2,2,0.4);
	  	P3->addToEntry(3,2,0.3);
	  	P3->addToEntry(3,3,0.2);
	  	P3->addToEntry(3,4,0.25);
	  	P3->addToEntry(3,5,0.25);
	  	P3->addToEntry(4,4,0.1);
	  	P3->addToEntry(4,5,0.3);
	  	P3->addToEntry(4,6,0.3);
	  	P3->addToEntry(4,7,0.3);
	  	P3->addToEntry(5,3,0.5); // split transition 5->5 to 5->(3,5)
	  	P3->addToEntry(5,5,0.5); // with 1/2 proba each
	  	P3->addToEntry(6,4,0.5);
	  	P3->addToEntry(6,6,0.5);
	  	P3->addToEntry(7,4,0.4);
	  	P3->addToEntry(7,5,0.2);
	  	P3->addToEntry(7,6,0.2);
	  	P3->addToEntry(7,7,0.2);

	  	// Assign the transition matrices to chains (respectively). 
	  	c1->set_generator(P1);
	  	c2->set_generator(P2);
	  	c3->set_generator(P3); 
		
		//////////////////////////////////////////////////////////////////////////////
		// Creating DiscreteDistribution objects to get the final distribution of the simulated chains.
	  	Distribution* statTrans1 = c1->TransientDistributionDT( 0 , n );
	  	Distribution* statTrans2 = c2->TransientDistributionDT( 0 , n );
	  	Distribution* statTrans3 = c3->TransientDistributionDT( 0 , n );
		//////////////////////////////////////////////////////////////////////////////
	  	

		printf("## Displaying transient distributions at time %d\n", n );
		// Write results to the terminal stdout.
	  	statTrans1->Write( stdout, -4 );
	  	printf("\n");
	  	statTrans2->Write( stdout, -4 );
	  	printf("\n");
	  	statTrans3->Write( stdout, -4 );
	  	printf("\n");

		printf("## Destruction of initial and transient distributions\n");
		delete initial1;
		delete initial2;
		delete initial3;
		delete statTrans1;
		delete statTrans2;
		delete statTrans3;
		
		// Destruct the chains in order to free the allocated memory.
		printf("## Destruction of MCs\n");
		delete c1;
		delete c2;
		delete c3;
		
		free(states);
		free(probas);
	}
	else
	{
		printf("Input format is not valid !!\n");
		printf("Usage: example1 <n> <p1> <p2> <p3> <p4> <p5> <p6> <p7> <p8>\n");
	}

	// Exit with OK code
  	return 0;
}

// Procedure for reading the command line data and storing it in variables.
// Returns true if the format of the arguments is valid (not exceeding limits,
// no unallowed characters).
// The input is: 
// (number of steps n) 
// (initial distribution p1 p2 p3 p4 p5 p6 p7 p8 p9)
//
bool parseParameters( int argc, char** argv, long int* var,
		      double* prob1, double* prob2, double* prob3, double* prob4,
		      double* prob5, double* prob6, double* prob7, double* prob8 )
{
        bool test = true;
  	char *endptr1, *endptr2, *endptr3, *endptr4, *endptr5, *endptr6, *endptr7, *endptr8, *endptr9;

	if (argc==10){

	  	*var = strtol(argv[1], &endptr1, 10);
     		*prob1 = strtod(argv[2], &endptr2);
  		*prob2 = strtod(argv[3], &endptr3);
  		*prob3 = strtod(argv[4], &endptr4);
		*prob4 = strtod(argv[5], &endptr5);
		*prob5 = strtod(argv[6], &endptr6);
		*prob6 = strtod(argv[7], &endptr7);
		*prob7 = strtod(argv[8], &endptr8);
		*prob8 = strtod(argv[9], &endptr9);

		test = ( (*var > 0) && (*var < INT_MAX)
			 && (strlen(endptr1) == 0) && (strlen(endptr2) == 0)
			 && (strlen(endptr3) == 0) && (strlen(endptr4) == 0)
			 && (strlen(endptr5) == 0) && (strlen(endptr6) == 0)
			 && (strlen(endptr7) == 0) && (strlen(endptr8) == 0)
			 && (strlen(endptr9) == 0) );
	}
	else {
	  test = false;
	}

	return test;
}
