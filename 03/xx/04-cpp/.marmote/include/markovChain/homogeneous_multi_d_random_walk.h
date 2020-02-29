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

#ifndef HOMOGENEOUSMULTIDRANDOMWALK_H
#define HOMOGENEOUSMULTIDRANDOMWALK_H

#include "markov_chain.h"
#include "../Distribution/discrete_distribution.h"

/**
 * @brief The general d-dimensional random walk with homogeneous transition probabilities.
 * This model is characterized by:
 * - the number of dimensions
 * - the size in each dimension, possibly INFINITE_STATE_SPACE_SIZE
 * - the array of probabilities to jump to the right in each direction, p
 * - the array of probabilities to jump to the left in each direction, q
 * with sum_d ( p[d] + q[d] ) <= 1. The probability to stay at the same position is the remainder.
*/

class HomogeneousMultiDRandomWalk : public MarkovChain
{
protected:
  // variables specific to this class
  int nb_dims_; /**< @brief number of dimensions of the grid */
  double* state_space_;	/**< @brief representation of the state space when finite */
  int *dim_size_;          /**< @brief size of the state space in each dimension */
  double* p_;            /**< @brief the probability to jump to the right */
  double* q_;            /**< @brief the probability to jump to the left */
  double r_; 		/**< @brief r = 1 - sum_i( p_i + q_i ) is the proba of staying in the same state */

private:
  int *mu_; /**< @brief array for state space offsets */
  bool is_finite_; /**< @brief finiteness status of state space */

public:
  /**
   * @brief Constructor for the class. The initial state is set arbitrarily to (0,...,0).
   * @param nbDims the number of dimensions
   * @param sz the array of sizes in each dimension
   * @param p the array of probabilities to jump to the right
   * @param q the array of probabilities to jump to the left
   */
  HomogeneousMultiDRandomWalk( int nbDims, int* sz, double* p, double* q );
  /**
   * @brief Constructor for the class with infinite dimensions. The initial state is set arbitrarily to (0,...,0).
   * @param nbDims the array of sizes in each dimension
   * @param p the array of probabilities to jump to the right
   * @param q the array of probabilities to jump to the left
  */
  HomogeneousMultiDRandomWalk( int nbDims, double* p, double* q );
  /**
    * @brief Standard destructor.
    */
  ~HomogeneousMultiDRandomWalk();

  /**
   * @brief Instantiation of the generator for the markovChain ancestor
   * Works only for dimension 2.
   * @author	Alain Jean-Marie
   */
  void MakeMarkovChain();

public:
  /**
   * @brief Computes the stationary distribution of the chain. These Markov chains have
   * a product-form stationary distribution.
   * @return The stationary distribution.
   */
  DiscreteDistribution* StationaryDistribution();
  /**
   * @copydoc MarkovChain::SimulateHittingTime()
   */
  int* SimulateHittingTime(int iState, bool *hit_set_indicator, int nbSamples, int tMax);

public:
  /**
   * @brief General output procedure for this class of Markov chains
   * @param format the format/language to use
   */
  void Write(string format);

};

#endif // HOMOGENEOUSMULTIDRANDOMWALK_H
