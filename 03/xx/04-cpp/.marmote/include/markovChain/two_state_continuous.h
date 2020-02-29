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

#ifndef TWOSTATECONTINUOUS_H
#define TWOSTATECONTINUOUS_H

#include "markov_chain.h"
#include "../Distribution/discrete_distribution.h"
#include "../Distribution/bernoulli_distribution.h"

/**
 * @brief The 2-state continuous-time Markov chain
 * This model is characterized by:
 * - the rate of jumps from 1 to 2, alpha
 * - the rate of jumps from 2 to 1, beta
*/

class TwoStateContinuous : public MarkovChain
{
 protected:
  double* state_space_;	/**< @brief representation of the state space */
  double alpha_; /**< the rate of jumps from 1 to 2 */
  double beta_; /**< the rate of jumps from 2 to 1 */

 public:

/**
 * @brief Constructor for a TwoStateContinuous chain
 * @author	Alain Jean-Marie
 * @param alpha rate of transitions from 1 to 2
 * @param beta	rate of transitions from 2 to 1
 * @return	an object of type TwoStateContinuous, with initial state set arbitrarily to 0.
 */
  TwoStateContinuous( double alpha, double beta );

  /**
   * @brief Destructor for a TwoStateContinuous chain
   * @author	Alain Jean-Marie
   */
  ~TwoStateContinuous();

  /**
   * @brief Instantiation of the generator for the markovChain ancestor
   * @author	Alain Jean-Marie
   */
  void makeMarkovChain();

  /**
   * @brief Method that returns the list of absorbing states of the markovchain object.
   * @author Alain Jean-Marie
   * @return a vector of indices of states
   */
  std::vector<int> AbsorbingStates();

  /**
   * @brief Method that returns the recurrent classes of the markovchain object
   * as a list of lists of states.
   * @author Alain Jean-Marie
   * @return a vector of vectors of indices of states
   */
  std::vector< std::vector<int> > RecurrentClasses();

  /**
   * @brief Method that returns the communicating classes of the markovchain object
   * as a list of lists of states.
   * @author Alain Jean-Marie
   * @return a vector of vectors of indices of states
   */
  std::vector< std::vector<int> > CommunicatingClasses();

  /**
   * @brief Method verifing whether a Markov chain is irreducible.
   * @author Alain Jean-Marie
   * @return true if the chain is irreducible, false otherwise
   */

  bool IsIrreducible();

  /**
   * @brief Method verifying if two states communicate in a Markov chain.
   * @author Alain Jean-Marie
   * @param stateFrom index of the origin state
   * @param stateTo index of the destination state
   * @return true if a path exists from origin to destination, false otherwise
   */

  bool IsAccessible(int stateFrom, int stateTo);
  /**
   * @brief Computes the transient distribution for a TwoStateContinuous chain
   * @author	Alain Jean-Marie
   * @param t	time at which the distribution is to be computed
   * @return a Bernoulli distribution
   */
  BernoulliDistribution* transientDistribution( double t );

  /**
   * @brief Computes the stationary distribution for a TwoStateContinuous chain
   * @author	Alain Jean-Marie
   * @return a Bernoulli distribution
   */
  BernoulliDistribution* StationaryDistribution();

  /**
   * Simulates the evolution of a TwoStateContinuous chain
   * @author	Alain Jean-Marie
   * @param tMax	time until which the Markov chain is simulated
   * @param stats	indicates whether occupancy statistics are collected and returned
   * @param traj	indicates whether a trajectory is returned
   * @param withIncrements	indicates whether time increments should be printed
   * @param trace	indicates whether the trajectory should be printed along the way (on stdout)
   * @return a structure with the results of the simulation
   */
  SimulationResult*
    SimulateChain( double tMax,
                   bool stats, bool traj,
                   bool withIncrements,
                   bool trace );

};

#endif // TWOSTATECONTINUOUS_H
