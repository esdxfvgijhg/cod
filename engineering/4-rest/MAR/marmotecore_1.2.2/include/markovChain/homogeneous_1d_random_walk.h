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

#ifndef HOMOGENOUS1DRANDOMWALK_H
#define HOMOGENOUS1DRANDOMWALK_H

#include "markov_chain.h"
#include "../Distribution/discrete_distribution.h"
#include "../Distribution/geometric_distribution.h"

/**
 * @brief The 1-dimensional random walk with homogeneous transition probabilities.
 * This model is characterized by:
 * - the size N, possibly INFINITE_STATE_SPACE_SIZE: number of states
 * - the probability to jump to the right, p
 * - the probability to jump to the left, q
 * with p + q <= 1. The probability to stay at the same position is 1 - p - q.
*/

class Homogeneous1DRandomWalk : public MarkovChain 
{
 protected:
  int size_;		/**< @brief the number of states; possibly infinite */
  double* state_space_;	/**< @brief representation of the state space when finite */
  double p_;            /**< @brief the probability to jump to the right */
  double q_;            /**< @brief the probability to jump to the left */
  double r_; 		/**< @brief r = 1 - p - q is the proba of staying in the same state */

 public:

/**
 * @brief Constructor for a Homogeneous1DRandomWalk chain with infinite state space
 * @author	Alain Jean-Marie
 * @param p	right-jump probability
 * @param q	left-jump probability
 * @return	an object of type Homogeneous1DRandomWalk, with initial state set arbitrarily to 0.
 */
  Homogeneous1DRandomWalk( double p, double q );
  /**
   * @brief Constructor for a Homogeneous1DRandomWalk chain
   * @author	Alain Jean-Marie
   * @param n	size of the state space of the chain
   * @param p	right-jump probability
   * @param q	left-jump probability
   * @return	an object of type markovChain, with initial state set arbitrarily to 0.
  */
  Homogeneous1DRandomWalk( int n, double p, double q );

  /**
   * @brief Destructor for a Homogeneous1DRandomWalk chain
   * @author	Alain Jean-Marie
   */
  ~Homogeneous1DRandomWalk();

  /**
   * @brief Instantiation of the generator for the markovChain ancestor
   * @author	Alain Jean-Marie
   */
  void MakeMarkovChain();

  /**
   * @brief Computes the transient distribution for a Homogeneous1DRandomWalk chain
   * @author	Alain Jean-Marie
   * @param t	time at which the distribution is to be computed
   * @param nMax maximal state for the range on which the distribution is to be computed
   * @return a discrete distribution where the result is stored
   */
  DiscreteDistribution* ApproxTransientDistribution( int t, int nMax );
  /**
   * @brief Computes the stationary distribution for a Homogeneous1DRandomWalk
   * chain. When the state space is infinite, the Geometric distribution is returned.
   * If the chain is not stable, the (improper) geometric distribution with
   * parameter 1 is returned. When the state space is finite, the truncated
   * Geometric distribution is returned as a discreteDistribution object.
   * @author Alain Jean-Marie
   * @return a distribution
   */
  Distribution* StationaryDistribution();
//  /**
//   * @brief Computes the stationary distribution for a Homogeneous1DRandomWalk
//   * chain. When the state space is infinite, the Geometric distribution is returned.
//   * If the chain is not stable, the (improper) geometric distribution with
//   * parameter 1 is returned. When the state space is finite, the truncated
//   * Geometric distribution is returned as a discreteDistribution object.
//   * @author Alain Jean-Marie
//   * @param nMax the actual maximal state in the random walk
//   * @return a distribution
//   */
  // TO BE OBSOLETIZED
  // discreteDistribution* stationaryDistribution( int nMax );
  /**
   * @brief Simulates the evolution of a Homogeneous1DRandomWalk chain
   * @author	Alain Jean-Marie
   * @param tMax	time until which the Markov chain is simulated
   * @param stats	indicates whether occupancy statistics are collected and returned
   * @param traj	indicates whether a trajectory is returned
   * @param trace	indicates whether the trajectory should be printed along the way (on stdout)
   * @return a structure with the results of the simulation
   */
  SimulationResult* SimulateChain( long int tMax, bool stats, bool traj, bool trace );

 public:
  /**
   * @brief Writes a Homogeneous1DRandomWalk chain in files with some specified format.
   * Supported formats:
   * - Xborne: both Rii and Cuu files are written
   * - Psi, Ers, "R"
   * @author Alain Jean-Marie
   * @param format format/language to be used
   * @param prefix the name of the model, usually used as prefix for the different files
   */
  void Write(string format, string prefix);

};

#endif // HOMOGENOUS1DRANDOMWALK_H
