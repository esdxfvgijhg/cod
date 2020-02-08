// Usage: example4
#include "Distribution/discrete_distribution.h"
#include "markovChain/markov_chain.h"
#include "transitionStructure/sparse_matrix.h"
#include <algorithm>
#include <iostream>
#include <sstream>
#include <stdlib.h>
// The application code devised for testing the input/output files of Markov chains
int main(int argc, char **argv) {
  // Construct two Markov chain from the external input files with Ers format:
  // rw1d.mcl and aexample.mcl.
  // Specification of the constructor that is used:
  // MarkovChain( format, param[], nbreParam, modelName )
  // @param format: he format in which the model is specified
  // @param param[]: parameter list
  // @param nbreParam: size of param[].
  // @param modelName: name of the model, typically prefix of files.
  // @return: a markovChain object.
  MarkovChain *c1 = new MarkovChain("Ers", NULL, 0, "aexample");
  MarkovChain *c2 = new MarkovChain("Ers", NULL, 0, "rw1d");
  // Print the constructed chains to the stdout (to make sure they are well constructed).
  printf("%s\n", "####################################");
  printf("%s\n", "Constructed Chains:");
  printf("%s\n", "Example1: aexample.mcl");
  c1->Write(stdout, false);
  printf("%s\n", "####################################");
  printf("%s\n", "Example2: rw1d.mcl");
  c2->Write(stdout, false);
  printf("%s\n", "####################################");
  // Write both chains to external Ers output files: example1.mcl and example2.mcl using the method "write(format,model_name)".
  c1->Write("Ers", "example4_chain1");
  c2->Write("Ers", "example4_chain2");
  // Write both transition matrices to external Ers output files: example1Mat and example2Mat using the method "write(FILE out, format)".
  if ((TransitionStructure *)NULL != c1->generator()) {
    FILE *out1 = fopen("example4_chain1.gen", "w");
    c1->generator()->Write(out1, "Ers");
    fclose(out1);
  } else {
    printf("Chain 1 has no generator.\n");
  }
  if ((TransitionStructure *)NULL != c2->generator()) {
    FILE *out2 = fopen("example4_chain2.gen", "w");
    c2->generator()->Write(out2, "Ers");
    fclose(out2);
  } else {
    printf("Chain 2 has no generator.\n");
  }
  // Now both output files are created, we destruct the chains to free the
  // allocated memory.
  delete c1;
  delete c2;
  return 0;
}
