/* Marmote is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Marmote is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Marmote. If not, see <http://www.gnu.org/licenses/>.

Copyright 2015 Alain Jean-Marie, Jean-Michel Fourneau, Jean-Marc Vincent, Issam Rabhi */

#ifndef MARKOVCHAIN_H
#define MARKOVCHAIN_H

#include "../marmote_constants.h"
#include "../Distribution/distribution.h"
#include "../Distribution/discrete_distribution.h"
#include "simulation_result.h"
#include "../transitionStructure/transition_structure.h"
#include "../transitionStructure/sparse_matrix.h"
#include <string>
#include <iostream>

#ifdef WITH_R
#include <RInside.h>
#endif

using namespace std;

/**
 * @brief Markov Chain class
 *
 */
class MarkovChain
{

 protected:

  timeType 		type_; /**< @brief time type: discrete or continuous */
  int 			state_space_size_; /**< @brief size of the state space (should be a pointer on the state space itself) */
  TransitionStructure* 	generator_; /**< @brief transition structure of the chain */
  DiscreteDistribution* init_distribution_; /**< @brief initial distribution of the process */
  bool			debug_; /**< @brief internal debugging indicator */

  string format_; /**< @brief format/language of the model */
  string model_name_; /**< @brief name of the model */

#ifdef WITH_R
  static RInside* r_motor_; /**< @brief R execution engine; there is at most one; may not be created at all */
#else
  typedef void* RInside; /**< @brief recast nonexisting RInside type to void */
  typedef void* SEXP; /**< @brief recast nonexisting SEXP type to void */
#endif

public:
  // constructors

  /**
   * @brief Simple constructor for the Markov chain from the size and time type
   * @author Alain Jean-Marie
   * @param sz the size of the state space (may be infinite)
   * @param t the type of chain: CONTINUOUS or DISCRETE
   * @return Markov Chain with no internal structures initialized
   */
  MarkovChain(int sz, timeType t);

  /**
   * @brief Constructor for the Markov chain using a transition structure.
   * @author Alain Jean-Marie
   * @param tr the transition structure
   * @return Markov Chain with no internal structures initialized
   */
  MarkovChain(TransitionStructure* tr);

  /**
   * @brief Constructor for Markov chains from files in various formats.
   * The chain is instantiated in the memory with a concrete transition structure.
   * If an abstract chain is meant: use the AbstractMarkovChain object.
   * Only the ERS, PSI and Xborne formats are supported at this time for concrete
   * chains.
   * @author Issam Rabhi and Alain Jean-Marie
   * @param format the format or language in which the model is specified
   * @param param[] is the list of parameters
   * @param nbParam the size of param
   * @param model_name the name of the model, usually the prefix for various files
   * @return a Markov Chain
   */
  MarkovChain(string format, string param[], int nbParam, string model_name );

  /**
   * @brief Constructor for Markov chain which contains given number of states and
   * has period which is multiple to the given argument. This chain is created
   * in the following way. First, it creates, multipleOfPeriod buckets. Then it distributes
   * to each bucket the equal number of states (nStates / multipleOfPeriod). Then, all buckets
   * (which is vector<int>) is shuffled. And then, transitions like this are created:
   * buckets[i % multipleOfPeriod][j] -> buckets[(i+1) % multipleOfPeriod][j].
   * @param multipleOfPeriod the target period; actual period may be a divisor
   * @param nStates the target number of states in the chain
   * @author Hlib Mykhailenko
   */
  MarkovChain(int multipleOfPeriod, int nStates);

  /**
   * @brief Standard destructor. The generator and the initial distrib are destroyed.
   * @author Alain Jean-Marie
   */

  virtual ~MarkovChain();

public:
  // accessors

  /**
   * @brief Accessor to get the number of states in the state space of the Markov chain.
   * @return the size of the state space
   */
  int state_space_size() { return state_space_size_; }
  /**
    * @brief Accessor to get the value of generator_ which is a TransitionStructure
    *
    * @return the transition structure
    */
  TransitionStructure* generator() { return generator_; }
  /**
   * @brief Mutator to set the value of init_distribution_ which is a DiscreteDistribution
   *
   * @param d the distribution to be set
   */
  void set_init_distribution( DiscreteDistribution* d ) { if ( init_distribution_ != NULL ){ delete(init_distribution_); }; init_distribution_ = d->Copy(); }
  /**
    * @brief Mutator to set the value of generator_ which is a TransitionStructure
    *
    * @param tr the transition structure to be set
    */
  void set_generator( TransitionStructure* tr ) { generator_ = tr; }

  /**
   * @brief Accessor to the embedded R engine, a static variable named r_motor_.
   * When accessed for the first time, an instance of RInside is created.
   * @return a pointer to the R execution engine
   */
  RInside* r_motor();

  /**
   * @brief Utility to set the value of format_
   *
   * @param format
   */
  void set_format(string format){format_=format;}

  /**
   * @brief  Utility to set the value of model_name_
   *
   * @param modelName
   */
  void set_model_name(string modelName){model_name_=modelName;}

  /**
   * @brief Read accessor to model_name_.
   * @author Issam Rabhi
   * @return model_name_ which is the model name.
   **/
  string model_name(){ if ( model_name_.size() == 0 ) fprintf( stderr, "Warning: empty model name.\n" ); return model_name_;}

  /**
   * @brief Read accessor to format_.
   * @author Issam Rabhi
   * @return format_ which is the format of the Markov Chain (XbornePres, Xborne, mcl,  ...)
   **/
  string format(){return format_;}


 public:
  // solution methods
 /**
  * @brief Simulates the evolution of a Markov Chain using the "Monte-Carlo" method.
  * This is a front-end function to both discrete-time and the continuous-time simulators.
  * @author	Alain Jean-Marie and Issam Rabhi
  * @param tMax	time until which the Markov chain is simulated
  * @param stats	indicates whether occupancy statistics are collected and returned
  * @param traj	indicates whether a trajectory is returned
  * @param withIncrements	indicates whether time increments should be produced
  * @param print	indicates whether values should be printed along the way
  * @return a structure with the results of the simulation
  */

  virtual SimulationResult* SimulateChain( double tMax,
                                           bool stats, bool traj,
                                           bool withIncrements, bool print );

 /**
  * @brief Simulates the evolution of a discrete-time Markov Chain
  * @author	Alain Jean-Marie and Issam Rabhi
  * @param tMax	time until which the Markov chain is simulated
  * @param stats	indicates whether occupancy statistics are collected and returned
  * @param traj	indicates whether a trajectory is returned
  * @param trace	indicates whether the trajectory should be printed along the way (on stdout)
  * @return a structure with the results of the simulation
  */

  virtual SimulationResult* SimulateChainDT( int tMax,
                                             bool stats, bool traj,
                                             bool trace );
 /**
  * @brief Simulates the evolution of a continuous-time Markov Chain
  * @author	Alain Jean-Marie and Issam Rabhi
  * @param tMax	time until which the Markov chain is simulated
  * @param stats	indicates whether occupancy statistics are collected and returned
  * @param traj	indicates whether a trajectory is returned
  * @param withIncrements	indicates whether time increments should be printed
  * @param trace	indicates whether the trajectory should be printed along the way (on stdout)
  * @return a structure with the results of the simulation
  */
  virtual SimulationResult* SimulateChainCT( double tMax,
                                             bool stats, bool traj,
                                             bool withIncrements,
                                             bool trace );

  /**
  * @brief Simulates the evolution of a Markov Chain. This is a front-end function
  * to the discrete-time simulator. For continuous time, the PSI simulator
  * does not allow to control the simulation horizon.
  * The effect of "Print" is to be handled in the specific simulation function,
  * not here.
  * @author	Alain Jean-Marie and Issam Rabhi
  * @param tMax	time until which the Markov chain is simulated
  * @param stats	indicates whether occupancy statistics are collected and returned
  * @param Traj	indicates whether a trajectory is returned
  * @param Print	indicates whether values should be printed along the way
  * @return a structure with the results of the simulation
  */
  SimulationResult* SimulatePSI( int tMax,
                                 bool stats, bool Traj,
                                 bool Print );

  /**
   * @brief Multi-purpose entry point for iterative methods for approximating the stationary
   * distribution of discrete-time Markov chains. Offers the maximal flexibility with respect
   * to parameters, as well as the possibility to set defaults.
   * @param method a string describing the method to be called. Possibilities are "Power", "SOR".
   * @param tmax maximal number of iterations; defaults to 1000 if set to 0
   * @param precision precision parameter for stopping rules; defaults to 1e-7 if set to 0
   * @param initDistribType a string describing the initial distribution to be used in iterations.
   * Possibilities are "Zero", "Max", "Uniform", "Custom".
   * @param initDistrib a distribution object in the case of "Custom" initial distribution.
   * @param progress boolean indicator for tracing the progression
   * @return
   */
  Distribution* StationaryDistributionIterative( string method,
                                                  int tmax,
                                                  double precision,
                                                  string initDistribType,
                                                  DiscreteDistribution* initDistrib,
                                                  bool progress );

  /**
   * @brief Entry point for methods Computing the stationary distribution of chains using
   * the iterative method
   * @author Alain Jean-Marie
   * @param progress indicates whether the progress of the iterative method should be displayed
   * @return an approximation of the stationary distribution
   */
  Distribution* StationaryDistribution( bool progress );

  /**
   * @brief Computing the stationary distribution of a CTMC using uniformization
   * and the iterative method
   * @author Alain Jean-Marie
   * @param progress indicates whether the progress of the iterative method should be displayed
   * @return an approximation of the stationary distribution
   */
  virtual Distribution* StationaryDistributionCT( bool progress );

  /**
   * @brief Computing the stationary distribution of a CTMC using embedding
   * and the iterative method
   * @author Alain Jean-Marie
   * @param tMax maximal number of iterations
   * @param epsilon precision parameter for the stopping rule
   * @param iDis initial distribution to be used
   * @param progress indicates whether the progress of the iterative method should be displayed
   * @return an approximation of the stationary distribution
   */
  virtual Distribution* StationaryDistributionCTEmbedding( int tMax, double epsilon,
                                                           DiscreteDistribution *iDis, bool progress );

  /**
   * @brief Computing the stationary distribution of a DTMC using
   * the standard iterative power method
   * @author Alain Jean-Marie and Issam Rabhi
   * @param tMax maximal number of iterations
   * @param epsilon precision parameter for the stopping rule
   * @param iDis initial distribution to be used
   * @param progress indicates whether the progress of the iterative method should be displayed
   * @return an approximation of the stationary distribution
   */
  virtual Distribution* StationaryDistributionPower( int tMax, double epsilon,
                                                     DiscreteDistribution *iDis, bool progress );


  /**
   * @brief Entry point for eigenmarkov command of scilab: Y=grand(n,'markov',P,x0) generate n successive states of a Markov chain described by the transition matrix P. Initial state is given by x0. 
   * @author Issam Rabhi
   * @return a matrix
   */
  std::vector< std::vector<double> >  scilab_grand(int n, std::string x0);

  /**
   * @brief Entry point for genmarkov command of scilab 
   * @author Issam Rabhi
   * @return a matrix 
   */
  std::vector< std::vector<double> >  scilab_genmarkov(int a, int b);


  /**
   * @brief Entry point for eigenmarkov command of scilab 
   * @author Issam Rabhi
   * @return void but eigenmarkov create scilab_eigenmarkov file
   */
  std::vector< std::vector<double> >  scilab_eigenmarkov();

  /**
   * @brief Entry point for eigenmarkov command of scilab 
   * @author Issam Rabhi
   * @return void but eigenmarkov create scilab_eigenmarkov file
   */
  void scilab_eigenmarkov(std::vector< std::vector<double> > & M, std::vector< std::vector<double> > & Q);

  /**
   * @brief Entry point for eigenmarkov command of scilab 
   * @author Issam Rabhi
   * @return void but eigenmarkov create scilab_eigenmarkov file
   */
  void scilab_classmarkov(std::vector<double> & perm, std::vector<double> & rec, int & tr, std::vector<double> & indsRec, std::vector<double> & indsT);

  /**
   * @brief Entry point for methods computing stationary distributions using the
   * GTH method for solving the linear system
   * @author Issam Rabhi and Alain Jean-Marie
   * @return the stationary distribution, up to errors in the solution of the linear system
   */
  Distribution* StationaryDistributionGthLD();

  /**
   * @brief Entry point for methods computing stationary distributions using the
   * SOR method for solving the linear system
   * @author Alain Jean-Marie
   * @return the stationary distribution, up to errors in the solution of the linear system
   */
  Distribution* StationaryDistributionSOR();

  /**
   * @brief Method for computing the transient distribution of a Markov chain.
   * It wraps the 'solve.uc' method of the R package of L. Cerda-Alabern
   * @author Alain Jean-Marie
   * @return the transient distribution, up to numerical errors
   */
  Distribution* TransientDistributionR( int fromState, double t );

  /**
   * @brief Method for computing the transient distribution of a DTMC.
   * Uses the general method evaluateMeasure.
   * @author Alain Jean-Marie
   * @return the transient distribution, up to numerical errors
   */
  Distribution* TransientDistributionDT( int fromState, int t );

  /**
   * @brief Entry point for methods computing stationary distributions using the
   * R package 'markovchain' for solving the linear system
   * @author Issam Rabhi
   * @return the stationary distribution, up to errors in the solution of the linear system
   */

  Distribution* StationaryDistributionR();

  /**
   * @brief Simulates the evolution of a discrete-time Markov Chain.
   * Wraps the 'rmarkovchain' method of the R package 'markovchain'.
   * @author	Issam Rabhi
   * @param tMax	time until which the Markov chain is simulated
   * @param stats	indicates whether occupancy statistics are collected and returned
   * @param traj	indicates whether a trajectory is returned
   * @param trace	indicates whether the trajectory should be printed along the way (on stdout)
   * @return a structure with the results of the simulation
   */

  SimulationResult* SimulateChainR( double tMax,
                                    bool stats, bool traj, bool trace );

  /**
   * @brief Method to get the transition probabilities from some intial to
   * some destination state. It wraps the 'transitionProbability' method of
   * the R package 'markovchain'
   * @author Issam Rabhi
   * @return a probability
   */
  double TransitionProbability(int stateFrom, int stateTo);

  /**
   * @brief Method that returns the list of absorbing states of the markovchain object.
   * It uses the "SCC" features of TransitionStructures.
   * @author Hlib Mykhailenko
   * @return a vector of indices of states
   */
  std::vector<int> AbsorbingStates();

  /**
   * @brief Method that returns the list of absorbing states of the markovchain object.
   * It wraps the 'absorbingStates()' method of the R package 'markovchain'.
   * @author Issam Rabhi
   * @return a vector of indices of states
   */
  std::vector<int> AbsorbingStatesR();

  /**
   * @brief Method that returns the recurrent classes of the markovchain object
   * as a list of lists of states.
   * @author Hlib Mykhailenko
   * @return a vector of vectors of indices of states
   */
  std::vector< std::vector<int> > RecurrentClasses();

  /**
   * @brief Method that returns the recurrent classes of the markovchain object
   * as a list of lists of states.
   * It wraps the 'recurrentClasses()' method of the R package 'markovchain'.
   * @author Issam Rabhi
   * @return a vector of vectors of indices of states
   */
  std::vector< std::vector<int> > RecurrentClassesR();


  /**
   * @brief Method that returns the communicating classes of the markovchain object
   * as a list of lists of states.
   * @author Hlib Mykhailenko
   * @return a vector of vectors of indices of states
   */
  std::vector< std::vector<int> > CommunicatingClasses();

  /**
   * @brief Method that returns the communicating classes of the markovchain object
   * as a list of lists of states.
   * It wraps the 'communicatingClasses()' method of the R package 'markovchain'.
   * @author Issam Rabhi
   * @return a vector of vectors of indices of states
   */
  std::vector< std::vector<int> > CommunicatingClassesR();

  /**
  * @brief Method verifing whether a Markov chain is irreducible.
  * @author Hlib Mykhailenko
  * @return true if the chain is irreducible, false otherwise
  */
  bool IsIrreducible();

  /**
   * @brief Method verifing whether a Markov chain is irreducible.
   * It wraps the "is.irreducible()' method of the R package 'markovchain'.
   * @author Issam Rabhi
   * @return true if the chain is irreducible, false otherwise
   */
  bool IsIrreducibleR();

  /**
   * @brief Method verifying if two states communicate in a Markov chain.
   * @author Hlib Mykhailenko
   * @param stateFrom index of the origin state
   * @param stateTo index of the destination state
   * @return true if a path exists from origin to destination, false otherwise
   */
  bool IsAccessible(int stateFrom, int stateTo);

  /**
   * @brief Method verifying if two states communicate in a Markov chain.
   * Wraps the 'is.accessible()' method from the R package 'markovchain'.
   * @author Issam Rabhi
   * @param stateFrom index of the origin state
   * @param stateTo index of the destination state
   * @return true if a path exists from origin to destination, false otherwise
   */
  bool IsAccessibleR(int stateFrom, int stateTo);


  /**
    * @brief Methods to sample from the stationary distribution using backwards coupling.
    * The result is returned in a simulationResult object, but the interpretation is different:
    * it does not represent trajectories.
    * Here, "state" entries are the measured states, and "time" entries are the measured coupling time.
    * @author Alain Jean-Marie
    * @param nbSamples number of samples to collect
    * @return an object storing the measured samples and coupling times
    */
  SimulationResult* StationaryDistributionSample( int nbSamples );

  /**
    * @brief Entry point for methods computing the distribution of the hitting time (first entry times)
    * from some state to some set of states.
    * @author Alain Jean-Marie
    * @param iState index of the initial state
    * @param hitSetIndicator a boolean array where states in the hitting set are marked with true
    * @return the array of average hitting times from every state not in the hitting set
    */
  Distribution* HittingTimeDistribution( int iState, bool *hitSetIndicator );

  /**
   * @brief Obtain samples of hitting times through Monte Carlo simulation.
   * A trajectory is simulated until it hits the target set, or its length attains a maximum,
   * whichever comes first. Samples with the maximum are returned although they do not represent
   * a proper hitting time. It is the responsibility of the calling party to ignore these values.
   * @param iState the initial state from which trajectories start
   * @param hit_set_indicator a boolean array where states in the hitting set are marked with true
   * @param nbSamples number of samples to collect
   * @param tMax maximum length of trajectories
   * @return an array with the samples
   */
  int* SimulateHittingTime(int iState, bool *hit_set_indicator,
                           int nbSamples, int tMax );
  /**
    * @brief Entry point for methods computing average hitting times (first entry times) from every state to some set of states.
    * @author Alain Jean-Marie
    * @param hitSetIndicator a boolean array where states in the hitting set are marked with true
    * @return the array of average hitting times from every state not in the hitting set
    */
  double* AverageHittingTime( bool *hitSetIndicator );

  /**
    * @brief Computing the average hitting times in a discrete-time Markov chain.
    * Uses a direct Gauss-Seidel matrix inversion.
    * @author Alain Jean-Marie
    * @param hitSetIndicator a boolean array where states in the hitting set are marked with true
    * @return the array of average hitting times from every state not in the hitting set
    */
  double* AverageHittingTimeDT( bool *hitSetIndicator );

  /**
    * @brief Computing the average hitting times in a discrete-time Markov chain.
    * Uses an iterative approximate computation.
    * @author Alain Jean-Marie
    * @param hitSetIndicator a boolean array where states in the hitting set are marked with true
    * @return the array of average hitting times from every state not in the hitting set
    */
  double* AverageHittingTimeDTIterative( bool *hitSetIndicator );

  /**
   * @brief Computes period of the chain
   * according to Chapter 17, Graph-Theoretic Analysis of Finite Markov Chains.
   * @author Hlib Mykhailenko
   */
  int Period();

  /**
   * @brief  returns a vector of markovChains corresponding to each terminal
   * class of the scc decomposition. These classes are the ones that have
   * no successor in the DAG of classes (=sccs).
   * Each of these "subchains" has a transition matrix which is the restriction
   * of the original one to the corresponding class/scc.
   * @author Hlib Mykhailenko
   */
  std::vector<MarkovChain *> * SubChains();

  /**
   * @brief Lumping algorithm is that of Tarjan et Paige to detect that a
   * chain/matrix is "strongly lumpable".
   * @author Hlib Mykhailenko
   */
  std::vector<std::vector<int> > * ComputeLumpings();

 public:

  /**
   * @brief copy utility
   *
   * @return markovChain
   */
  virtual MarkovChain* Copy();

  /**
   * @brief Uniformize Markov Chain, by uniformizing the generator.
   * If the chain is already discrete time, a copy is returned.
   * @author Alain Jean-Marie
   * @return a new Markov chain, uniformized version of the original
   */
  virtual MarkovChain* Uniformize();

  /**
   * @brief Construct discrete-time Markov Chain obtained at transition
   * times.
   * If the chain is already discrete time, a copy is returned.
   * @author Alain Jean-Marie
   * @return a new Markov chain, embedded at transition times
   */
  virtual MarkovChain* Embed();


public:
  /**
   * @brief Function to find out the size and the type of a Markov chain described
   * in the MARCA format. Both quantities are directly set in the method,
   * which returns nothing.
   * Adapted from the method HBF::read_marka of Psi/Unix/v1.0.
   * @author Alain Jean-Marie
   **/
  void set_size_type(const string path);

  /**
   * @brief Utility function to convert the element of a Rcpp::CharacterVector to a
   * state number.
   * @param elt the element to be converted
   * @param function the name of the function where the call occurs, for tracing
   * @return the state index
   */
   int CharVectorElt2State(SEXP elt, std::string function );


public:
  /**
   * @brief Method for writing Markov chains in a file with the ERS format.
   * @author Alain Jean-Marie
   * @param out the file descriptor in which to write the chain
   * @param withReward specifies if rewards are to be written; not used yet
   */
   virtual void Write( FILE *out, bool withReward );
   
  /**
   * @brief Method for writing Markov chains in files with various formats.
   * The ERS and R formats are supported at this time.
   * @author Alain Jean-Marie
   * @param format a string describing the format
   * @param model_name a string for naming the model, usually used for file name prefixes
   */
   virtual void Write( string format, string model_name);

   /**
    * @brief Method for writing Markov chains in files with various formats.
    * This version uses the given model name.
    * @author Alain Jean-Marie
    * @param format a string describing the format
    */
   void Write( string format ) { Write( format, model_name() ); }

   /**
    * @brief String serialization method for a Markov chain
    * @author Issam Rabhi (R language)
    * @param format the format/language to be used.
    */
   std::string toString(std::string format);
   
};


#endif // MARKOVCHAIN_H
