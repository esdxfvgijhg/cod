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

#ifndef POISSONPROCESS_H
#define POISSONPROCESS_H

#include "homogeneous_1d_birth_death.h"
#include "../Distribution/discrete_distribution.h"
#include "../Distribution/geometric_distribution.h"

/**
 * @brief The Poisson process.
 * This model is characterized by:
 * - the rate of jumps, lambda
 *
 * It is a special case of the homogeneous1DBirthDeath process,
 * with state space N and death rate 0.
*/

class PoissonProcess : public Homogeneous1DBirthDeath
{
 public:

/**
 * @brief Constructor for a PoissonProcess chain
 * @author	Alain Jean-Marie
 * @param lambda birth rate
 * @return	an object of type PoissonProcess, with initial state set arbitrarily to 0.
 */
  PoissonProcess( double lambda );

  /**
   * @brief Destructor for a PoissonProcess chain
   * @author	Alain Jean-Marie
   */
  ~PoissonProcess();

  /**
   * @brief Computes the transient distribution for a PoissonProcess chain
   * @author	Alain Jean-Marie
   * @param t	time at which the distribution is to be computed
   * @return a discrete distribution where the result is stored
   */
  Distribution* TransientDistribution( double t );

  /**
   * @brief Computes the stationary distribution for a PoissonProcess chain
   * @author	Alain Jean-Marie
   * @return a geometric distribution
   */
  GeometricDistribution* StationaryDistribution();

  /**
   * Simulates the evolution of a PoissonProcess chain
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

#endif // POISSONPROCESS_H
