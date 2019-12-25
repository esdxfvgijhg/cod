// Example that constructs three 9x9 discrete-time Markov chain
// then performs structural analysis on them.
//
// Usage: example7
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
void analysis( MarkovChain* mc );

// The application code 

int main( int argc, char** argv ) 
{
	// Create 3 discrete-time Markov chains of size 8.
	MarkovChain* c1 = new MarkovChain(8,DISCRETE);
	MarkovChain* c2 = new MarkovChain(8,DISCRETE);
	MarkovChain* c3 = new MarkovChain(8,DISCRETE);

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
		
	//////////////////////////////////////////////////////////////////////////
	fprintf( stdout, "##### Analysis of chain #1\n" );
	analysis( c1 );
	fprintf( stdout, "\n##### Analysis of chain #2\n" );
	analysis( c2 );
	fprintf( stdout, "\n##### Analysis of chain #3\n" );
	analysis( c3 );

	// Destruct the chains in order to free the allocated memory.
	printf("\n## Destruction of MCs\n");
	delete c1;
	delete c2;
	delete c3;
		
	// return with OK status
  	return 0;
}

// Procedure for reading the command line data and storing it in variables.
// Returns true if the format of the arguments is valid (not exceeding limits,
// no unallowed characters).
// The input is: 
// (number of steps n) 
// (initial distribution p1 p2 p3 p4 p5 p6 p7 p8 p9)
//
void analysis( MarkovChain* mc )
{

  SparseMatrix* sp = dynamic_cast<SparseMatrix*>(mc->generator());

  fprintf( stdout, "# Generator general diagnostic:\n" );
  sp->Diagnose(stdout);

  fprintf( stdout, "# Absorbing states:\n" );
  std::vector<int> abs = mc->AbsorbingStates();
  fprintf( stdout, "number = %ld\n", abs.size() );
  fprintf( stdout, "list = ( " );
  for ( std::vector<int>::iterator iter = abs.begin(); iter != abs.end(); iter++ ) {
    fprintf( stdout, "%d ", *iter );
  }
  fprintf( stdout, ")\n");

  fprintf( stdout, "# Communicating classes:\n" );
  std::vector<std::vector<int> > com = mc->CommunicatingClasses();
  fprintf( stdout, "number = %ld\n", com.size() );
  fprintf( stdout, "list = ( " );
  for ( std::vector<std::vector<int> >::iterator iter = com.begin();
	iter != com.end(); iter++ ) {
    fprintf( stdout, "[ " );
    for ( std::vector<int>::iterator itr = (*iter).begin();
	  itr != (*iter).end(); itr++ ) {
      fprintf( stdout, "%d ", *itr );
    }
    fprintf( stdout, "] " );
  }
  fprintf( stdout, ")\n");

  fprintf( stdout, "# Recurrent classes:\n" );
  std::vector<std::vector<int> > rec = mc->RecurrentClasses();
  fprintf( stdout, "number = %ld\n", rec.size() );
  fprintf( stdout, "list = ( " );
  for ( std::vector<std::vector<int> >::iterator iter = rec.begin();
	iter != rec.end(); iter++ ) {
    fprintf( stdout, "[ " );
    for ( std::vector<int>::iterator itr = (*iter).begin();
	  itr != (*iter).end(); itr++ ) {
      fprintf( stdout, "%d ", *itr );
    }
    fprintf( stdout, "] " );
  }
  fprintf( stdout, ")\n");

}
