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

#ifndef HOMOGENOUS1DBIRTHDEATH_H
#define HOMOGENOUS1DBIRTHDEATH_H

#include "markov_chain.h"
#include "../Distribution/discrete_distribution.h"
#include "../Distribution/geometric_distribution.h"

/**
 * @brief The 1-dimensional birth and death process with homogeneous transition rates.
 * This model is characterized by:
 * - the size N, possibly INFINITE_STATE_SPACE_SIZE: number of states
 * - the rate of jumps to the right, lambda
 * - the rate of jumps to the left, mu.
*/

class Homogeneous1DBirthDeath : public MarkovChain
{
 protected:
  int size_; /**< @brief the number of states; possibly infinite */
  double* state_space_;	/**< @brief representation of the state space when finite */
  double lambda_; /**< the rate of jumps to the right */
  double mu_; /**< the rate of jumps to the left */

 public:

/**
 * @brief Constructor for a Homogeneous1DBirthDeath chain with infinite state space
 * @author	Alain Jean-Marie
 * @param lambda birth rate
 * @param mu	death rate
 * @return	an object of type Homogeneous1DBirthDeath, with initial state set arbitrarily to 0.
 */
  Homogeneous1DBirthDeath( double lambda, double mu );
  /**
   * @brief Constructor for a Homogeneous1DBirthDeath chain
   * @author	Alain Jean-Marie
   * @param n	size of the state space of the chain
   * @param lambda birth rate
   * @param mu	death rate
   * @return	an object of type markovChain, with initial state set
          arbitrarily to 0.
   */
  Homogeneous1DBirthDeath( int n, double lambda, double mu );

  /**
   * @brief Destructor for a Homogeneous1DBirthDeath chain
   * @author	Alain Jean-Marie
   */
  ~Homogeneous1DBirthDeath();

  /**
   * @brief Instantiation of the generator for the markovChain ancestor
   * @author	Alain Jean-Marie
   */
  void MakeMarkovChain();

  /**
   * @brief Computes the transient distribution for a Homogeneous1DBirthDeath chain
   * @author	Alain Jean-Marie
   * @param t	time at which the distribution is to be computed
   * @param nMax maximal state for the range on which the distribution is to be computed
   * @return a discrete distribution where the result is stored
   */
  DiscreteDistribution* TransientDistribution( double t, int nMax );
  /**
   * @brief Computes an approximation to the transient distribution for a 
   * Homogeneous1DBirthDeath chain, computed as an interpolation between the
   * initial distribution and the stationary distribution.
   * @author	Alain Jean-Marie
   * @param t	time at which the distribution is to be computed
   * @param nMax maximal state for the range on which the distribution is to be computed
   * @return a distribution object where the result is stored
   */
  DiscreteDistribution* ApproxTransientDistribution( double t, int nMax );
  /**
   * @brief Computes the stationary distribution for a Homogeneous1DBirthDeath chain
   * @author	Alain Jean-Marie
   * @return a geometric distribution
   */
  GeometricDistribution* StationaryDistribution();
  /**
   * Computes the stationary distribution for a finite Homogeneous1DBirthDeath chain
   * @author	Alain Jean-Marie
   * @return	the stationary distribution
   */
  DiscreteDistribution* StationaryDistribution( int nMax );
  /**
   * Simulates the evolution of a Homogeneous1DBirthDeath chain
   * @author	Alain Jean-Marie
   * @param tMax	time until which the Markov chain is simulated
   * @param stats	indicates whether occupancy statistics are collected and returned
   * @param traj	indicates whether a trajectory is returned
   * @param withIncrements	indicates whether time increments should be printed
   * @param trace	indicates whether the trajectory should be printed along the way (on stdout)
   * @return a structure with the results of the simulation
   */
  SimulationResult* SimulateChain( double tMax,
                   bool stats, bool traj,
                   bool withIncrements,
                   bool trace );

};

#endif // HOMOGENOUS1DBIRTHDEATH_H
