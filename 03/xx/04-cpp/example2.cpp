                                                                                                         //Usage: example2 <n> <p1> <p2> <p3>
#include "Distribution/discrete_distribution.h"
#include "Distribution/uniform_discrete_distribution.h"
#include "markovChain/markov_chain.h"
#include "transitionStructure/sparse_matrix.h"
#include <algorithm>
#include <assert.h>
#include <errno.h>
#include <iostream>
#include <limits.h>
#include <sstream>
#include <time.h>
bool parseParameters(int, char **, long int *, double *, double *, double *);                            //Forward declaration of utility
int main(int argc, char **argv) {                                                                        //The application code
  long int var;                                                                                          //variables used in the program
  double prob1;
  double prob2;
  double prob3;
  bool test = parseParameters(argc, argv, &var, &prob1, &prob2, &prob3);                                 //get values from command line
  if (test) {
    int n = (int)var;                                                                                    //Fixing the number of iterations
    double states[3] = {0, 1, 2};                                                                        //Creating the state space with an array. Alternately: use the dedicated structure of marmoteCore.
    double *probas = (double *)malloc(3 * sizeof(double));                                               //Creating the initial distribution vector of size 3.
    srand(0);                                                                                            //defining the initial seedsrand(time(NULL));
    probas[0] = prob1;                                                                                   //Filling the initial distribution vector according to the initial probabilities passed in the arguments.
    probas[1] = prob2;
    probas[2] = prob3;
    DiscreteDistribution *initial = new DiscreteDistribution(3, states, probas);                         //Create a discrete distribution for the three states.
    MarkovChain *c1 = new MarkovChain(3, DISCRETE);                                                      //Create a discrete-time Markov chain of size 3.
    c1->set_init_distribution(initial);                                                                  //assigning the created distribution to the chain.
    SparseMatrix *P = new SparseMatrix(3);                                                               //Creating the transition matrix with size 3*3 using sparseMatrix object.
    P->set_type(DISCRETE);                                                                               //Definition of the type of the transition structure the type is not defined by default for a sparse matrix. However defining the type or not has no impact here.
    P->addToEntry(0, 0, 0.25);                                                                           //Add entries to the transition matrix.
    P->addToEntry(0, 1, 0.5);
    P->addToEntry(0, 2, 0.25);
    P->addToEntry(1, 0, 0.4);
    P->addToEntry(1, 1, 0.2);
    P->addToEntry(1, 2, 0.4);
    P->addToEntry(2, 0, 0.4);
    P->addToEntry(2, 1, 0.3);
    P->addToEntry(2, 2, 0.3);
    c1->set_generator(P);                                                                                //Assign the transition matrix to the chain.
    c1->Write(stdout, false);                                                                            //Print chain information to the terminal stdout.
    Distribution *trDis1 = c1->TransientDistributionDT(0, n);                                            //Computing the transient distribution after n steps.
    trDis1->Write(stdout, -4);                                                                           //Write the final distribution to the terminal stdout.
    printf("\n");
    delete c1;                                                                                           //Destruct the chain in order to free the allocated memory.
    delete trDis1;                                                                                       //NB the object P does not need to be deleted: this is done during the destruction of c1. Destruct the distribution object
    free(probas);                                                                                        //Destruct what remains
  } else {
    printf("Input format is not valid !!\n");
    printf("Usage: example1 <n> <p1> <p2> <p3>\n");
  }
  return 0;
}
bool parseParameters(int argc, char **argv, long int *var, double *prob1, double *prob2, double *prob3) {//Procedure for reading the command line data and storing it in variables. Returns true if everything is OK. The input is: (number of steps n) (initial distribution p1 p2 p3)
  bool test = true;
  char *endptr1, *endptr2, *endptr3, *endptr4;
  if (argc == 5) {
    *var = strtol(argv[1], &endptr1, 10);
    *prob1 = strtod(argv[2], &endptr2);
    *prob2 = strtod(argv[3], &endptr3);
    *prob3 = strtod(argv[4], &endptr4);
  } else {
    test = false;
  }
  test = ((*var > 0) && (*var < INT_MAX) && (strlen(endptr1) == 0));                                     //Check if the format of the entered arguments is valid: not exceeding limits, no unallowed characters.
  test = test && ((strlen(endptr2) == 0) && (*prob1 <= 1) && (*prob1 >= 0));
  test = test && ((strlen(endptr3) == 0) && (*prob2 <= 1) && (*prob2 >= 0));
  test = test && ((strlen(endptr4) == 0) && (*prob3 <= 1) && (*prob3 >= 0));
  return test;
}
