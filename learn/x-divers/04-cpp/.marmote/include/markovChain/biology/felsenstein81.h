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

#ifndef FELSENSTEIN81_H
#define FELSENSTEIN81_H

#include "../markov_chain.h"
#include "../../Distribution/discrete_distribution.h"

/**
 * @brief Ajout de fonctionalites sur les matrices F81 (Felsenstein 81)
 * Ce sont des matrices 4x4 qui sont caracterisees par:
 * un vecteur de 4 probabilites p[0], p[1], p[2], p[3]
 * un parametre de vitesse mu > 0
*/


class Felsenstein81 : public MarkovChain
{
 public:
    /**
     * Constructor for a F81 Markov Chain from a probability vector
     * @author	Alain Jean-Marie
     * @param p	probability vector
     * @param mu	speed parameter
     * @return	an object of type Markov_Chain, with initial state set
            arbitrarily to 0.
     */
  Felsenstein81( double p[4] , double mu);
  /**
   * Constructor for a F81 Markov Chain from a distribution and a speed parameter
   * @author	Alain Jean-Marie
   * @param d	the distribution
   * @param mu	speed parameter
   * @return	an object of type Markov_Chain, with initial state set
          arbitrarily to 0.
   */
  Felsenstein81( DiscreteDistribution* d, double mu);
  /**
   * Standard destructor
   * @author	Alain Jean-Marie
   */
  ~Felsenstein81();
  /**
   * Instantiation of the generator for the markovChain ancestor
   * @author	Alain Jean-Marie
   */
  void MakeMarkovChain();

  /**
   * Computes the transient distribution for a F81 Markov Chain, assuming that
   * the initial state is distributed as in init_distribution_
   * @author	Alain Jean-Marie
   * @param t	time at which the distribution is to be computed
   */
  DiscreteDistribution* TransientDistribution( double t );
  /**
   * Computes the transient distribution for a F81 Markov Chain
   * @author	Alain Jean-Marie
   * @param fromState state from which the chain stats
   * @param t	time at which the distribution is to be computed
   */
  DiscreteDistribution* TransientDistribution( int fromState, double t );
  /**
   * Computes the stationary distribution for a F81 Markov Chain
   * @author	Alain Jean-Marie
   */
  DiscreteDistribution* StationaryDistribution();

  /**
   * Simulates the evolution of a F81 Markov Chain
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

  /**
   * @brief Computes the hitting time distribution. It is an exponential distribution
   * with parameter equal to the speed times the sum of probabilities of the hitting set.
   * It is therefore independent from the initial state.
   * @param iState the initial state
   * @param hittingSet an array describing the hitting set.
   */
  Distribution* HittingTimeDistribution( int iState, bool* hittingSet);

  /**
   * @brief Computes the average hitting time from every state. It is either 0, or
   * the inverse of the speed times the sum of probabilities of the hitting set.
   * It is therefore independent from the initial state not in the hitting set.
   * @param hittingSet an array describing the hitting set.
   */
  double* AverageHittingTime( bool* hittingSet );


protected:
  int size_;			  /**< @brief the number of values; 4 at the moment */
  double* state_space_;		 /**< @brief representation of the state space */
  DiscreteDistribution* trans_distrib_; /**< @brief the distribution "p" */
  double trans_speed_;			 /**< @brief the speed parameter "mu" */
  
};

#endif // FELSENSTEIN81_H
