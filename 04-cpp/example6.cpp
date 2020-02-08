                                                   //Usage: example6
#include "Set/marmote_box.h"
#include "Set/marmote_interval.h"
#include "Set/marmote_set.h"
#include "markovChain/markov_chain.h"
#include <algorithm>
#include <iostream>
#include <malloc.h>
#include <sstream>
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
void testSet(MarmoteSet *set, string name);        //Forward declaration
int main(int argc, char **argv) {                  //The application code devised for testing the MarmoteBox object
  int dim1[1] = {2};
  int dim2[2] = {2, 3};
  MarmoteBox *bb1 = new MarmoteBox(1, dim1);       //Creation of a 1-dimensional MarmoteBox with size 2
  MarmoteBox *bb2 = new MarmoteBox(2, dim2);       //Creation of a 2-dimensional MarmoteBox with size 2x3
  MarmoteInterval *aa = new MarmoteInterval(8, 13);//Creation of the MarmoteInterval [8..13]
  testSet(bb1, "Marmote Box #1");                  //Statistics and enumeration of the 1-d box
  MarmoteSet *cc = bb1;                            //Test with a pointer of the generic type MarmoteSet
  testSet(cc, "Pointer to Marmote Box #1");
  testSet(bb2, "Marmote Box #2");                  //Statistics and enumeration of the 2-d box
  cc = bb2;                                        //Test with a pointer of the generic type MarmoteSet
  testSet(cc, "Pointer to Marmote Box #2");
  testSet(aa, "Marmote Interval");                 //Statistics and enumeration of the interval
  cc = aa;                                         //Test with a pointer of the generic type MarmoteSet
  testSet(cc, "Pointer to Marmote Interval");
  delete bb1;                                      //cleanup
  delete bb2;
  delete aa;
  return 0;
}
void testSet(MarmoteSet *set, string name) {       //The test procedure The input is: set: the object to be tested name: a string describing the test
  fprintf(stdout, "###### %s features:\n", name.c_str());
  fprintf(stdout, "Cardinal = %d, NbDimensions %d:\n", (int)set->Cardinal(), set->tot_nb_dims());
  fprintf(stdout, "# Direct enumeration of %s:\n", name.c_str());
  set->Enumerate();
  fprintf(stdout, "\n");
  fprintf(stdout, "# Enumeration of %s via through walk:\n", name.c_str());
  int *statebuffer = (int *)calloc(set->Cardinal(), sizeof(int));
  set->FirstState(statebuffer);
  for (int i = 0; i < set->Cardinal(); i++) {
    fprintf(stdout, "stateIndex: %d\t state", set->Index(statebuffer));
    set->PrintState(stdout, statebuffer);
    fprintf(stdout, "\n");
    set->NextState(statebuffer);
  }
  fprintf(stdout, "# Enumeration of %s via index access:\n", name.c_str());
  for (int i = 0; i < set->Cardinal(); i++) {
    set->DecodeState(i, statebuffer);
    fprintf(stdout, "stateIndex: %d\t state", i);
    set->PrintState(stdout, statebuffer);
    fprintf(stdout, "\n");
    set->NextState(statebuffer);
  }
  fprintf(stdout, "\n");
  free(statebuffer);
}
