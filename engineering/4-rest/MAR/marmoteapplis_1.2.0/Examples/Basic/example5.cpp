// Example that creates a 3x3 Markov chains then tests several methods for the
// same result.
//
// Usage: example5
//

// Include necessary header files to use marmoteCore and other functonalities.
#include "markovChain/markov_chain.h"
#include "Distribution/discrete_distribution.h"
#include "Distribution/uniform_distribution.h"
#include "transitionStructure/sparse_matrix.h"
#include <stdlib.h>
#include <iostream>
#include <sstream>
#include <algorithm>
#include <time.h>

// The application code devised for testing the input/output files of Markov chains

int main( int argc, char** argv ) 
{
	// In this model:
        // state 0 -> marmote is in first mountain,
        // state 1 -> marmote is in second mountain,
        // state 2 -> marmote is in third mountain .. etc ..

	// Creating the states array of size 3.
	double states[3]={0,1,2};

  	//Creating the initial distribution vector of size 3.
  	double probas[3];
        
        srand(time(NULL));
        //srand(0);

  	// Filling the initial distribution vector using a uniform distribution
	// to generate random probabilities.	
  	UniformDistribution* initialRandom = new UniformDistribution(0,1);
	
	probas[0] = initialRandom->Sample();
        probas[1] = initialRandom->Sample();
	probas[2] = initialRandom->Sample();
	
	double sum = probas[0]+probas[1]+probas[2];
	
	probas[0] = probas[0]/sum;
	probas[1] = probas[1]/sum;
	probas[2] = probas[2]/sum;
	
  	// Create a discrete distribution for the three states.
  	DiscreteDistribution* initial1 = new DiscreteDistribution(3,states,probas);
	DiscreteDistribution* initial2 = new DiscreteDistribution(3,states,probas);
	
  	// Create a discrete-time Markov chain of size 3.
  	MarkovChain* c1 = new MarkovChain(3,DISCRETE);
	
  	// Assigning created distribution to the chain.
  	c1->set_init_distribution(initial1);

  	// Creating the transition matrix of size 3*3.
  	SparseMatrix *P= new SparseMatrix(3);

  	// Add entries to the transition matrix.
  	P->addToEntry(0,0,0.25);
  	P->addToEntry(0,1,0.5);
  	P->addToEntry(0,2,0.25);
  	P->addToEntry(1,0,0.4);
  	P->addToEntry(1,1,0.2);
  	P->addToEntry(1,2,0.4);
  	P->addToEntry(2,0,0.4);
  	P->addToEntry(2,1,0.3);
  	P->addToEntry(2,2,0.3);

  	// Assign the transition matrix to the chain. 
  	c1->set_generator(P);
 

  	// Creating a DiscreteDistribution object containing the stationary distribution
	// of the chain.
  	Distribution* staDis1 = c1->StationaryDistribution(false);
	// Creating an other DiscreteDistribution containing the stationnary distribution
	// computed with an other method
	Distribution* staDis2 = c1->StationaryDistributionPower(100,0.00001,initial1,false);
	
  	// Write results to the terminal stdout.
	printf("# Initial probability\n");
  	initial1->Write( stdout, -4 );
	printf("\n");
	printf("# Markov chain\n");
  	c1->Write(stdout,false);
	printf("# Stationary distribution #1 with iterative method\n");
  	staDis1->Write( stdout, -4 );
	printf("\n");
	printf("# Stationary distribution #2 with power method\n");
  	staDis2->Write( stdout, -4 );
  	printf("\n");

	// Checking invariance of the stationary distribution
	// In order to do that, we set the computed stationary distribution as initial
	// distribution, then compute the one-step transient probability.
	DiscreteDistribution* staDis2bis  = dynamic_cast<DiscreteDistribution*>(staDis2);
	c1->set_init_distribution(staDis2bis);
	Distribution* dis3 = c1->TransientDistributionDT( 0, 1 );
	printf("# Checking invariance of distribution #2: one-step transition is:\n");
	dis3->Write( stdout, -4 );
  	printf("\n");
	printf("# L1 distance with distribution #2:\n");
	printf("d = %e\n", dis3->DistanceL1( staDis2bis ) );

	// Comparing stationary distribution with transient distribution after a "large"
	// number of steps (100) from some random initial distribution
	c1->set_init_distribution(initial2);
	Distribution* dis4 = c1->TransientDistributionDT( 0, 100 );
	printf("# Transient distribution after 100 steps");
	printf(" from the random initial distribution\n");
	dis4->Write( stdout, -4 );
	printf("\n");
	printf("# L1 distance with distribution #2:\n");
	printf("d = %e\n", dis4->DistanceL1( staDis2bis ) );

	// Cleanup the chain and distribution objects
	delete initialRandom;
	delete initial1;
	delete initial2;
	delete c1; 
	delete staDis1;
	delete staDis2;
	// Deletion of staDis2bis is not needed because this is a castof staDis2
	// delete staDis2bis;
	delete dis3;
	delete dis4;

	// Exit with OK code
  	return 0;
}
