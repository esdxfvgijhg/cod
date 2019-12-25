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

#ifndef MULTIDIMHOMTRANSITION_H
#define MULTIDIMHOMTRANSITION_H

#include "transition_structure.h"
#include <iostream>
#include <string>

using namespace std;

/**
 * @brief Class for multidimensional, homogeneous random walk transition structures.
 * These are characterized by
 * - their dimension d
 * - d sizes for each dimension (possibly infinite)
 * - d transitions probabilities to the right in each dimension, p_i,
 * - d transition probabilties to the left in each dimension, q_i.
 * The probability to stay in the current location is 1 - sum_i ( p_i + q_i ).
 * The boundaries are absorbing: when a transition goes out of bounds, it is assumed to stay
 * on the boundary.
 * @author Alain Jean-Marie
 *
 */
class MultiDimHomTransition : public TransitionStructure
{
protected:
  int nb_dims_; /**< @brief the number of dimensions */
  int *dim_size_; /**< @brief size of the state space in each dimension */
  double *p_; /**< @brief probas to jump to the right in each dimension */
  double *q_; /**< @brief probas to jump to the left in each dimension */

private:
  int *mu_; /**< @brief array for state space offsets */
  double r_; /**< @brief "natural" self jump probability */
  int *from_state_; /**< @brief state decoding buffer */
  int *to_state_; /**< @brief state decoding buffer */
  int nb_max_trans_; /**< @brief max number of transitions from any state */
  int stored_state_; /**< @brief index of the cached state */
  int* col_num_; /**< @brief cache for the transitions: destination states */
  double* col_val_; /**< @brief cache for the transitions: transition values */

public:
  // constructors
  /**
   * @brief General constructor of the class.
   * @param nbDims the number of dimensions
   * @param dim_size the array of sizes
   * @param p the array of jump probabilities to the right
   * @param q the array of jump probabilities to the left
   */
  MultiDimHomTransition(int nbDims, int* dim_size, double* p, double* q);
  /**
   * @brief Destructor of the class.
   *
   */
  ~MultiDimHomTransition();

public:
  // accessors
  /**
   * @brief Accessor for the size of the state space in each dimension
   * @param d the dimension
   * @return the size of the state space in dimension d
   */
  int dim_size(int d) { return dim_size_[d]; }
  /**
   * @brief Accessor for the jump probability to the right in each dimension
   * @param d the dimension
   * @return the jump probability
   */
  double p(int d) { return p_[d]; }
  /**
   * @brief Accessor for the jump probability to the right in each dimension
   * @param d the dimension
   * @return the jump probability
   */
  double q(int d) { return q_[d]; }

public:
  // implementation of virtual methods
  bool setEntry(int i, int j, double val);
  double getEntry(int i, int j);
  int getNbElts(int i);
  int getCol(int i, int k);
  double getEntryByCol(int i, int k);
  DiscreteDistribution* TransDistrib(int i);
  double RowSum(int i);
  MultiDimHomTransition* Copy();
  MultiDimHomTransition* Uniformize();
  MultiDimHomTransition* Embed();
  void EvaluateMeasure(double* d,double* res);
  void EvaluateValue(double* v, double* res);
  /**
   * @brief Output method for the transition structure. Supported formats are:
   * XBORNE, MARCA, Ers, Maple.
   *
   * @param out the file descriptor to which the structure should be written.
   * @param format the format/language to be used
   */
  void Write(FILE* out, string format);

public:
  /**
   * @copydoc TransitionStructure::EvaluateMeasure(DiscreteDistribution*)
   */
  DiscreteDistribution* EvaluateMeasure(DiscreteDistribution* d);

public:
  // specific methods
  /**
   * @brief Getting a discrete distribution representing the generic jumps.
   * The distribution has 2*nbDims + 1 values: 0, +/- 1, ..., +/- nDims. The coding is:
   * - 0 codes the self jump
   * - +d codes a jump upwards in dimension (d-1).
   * - -d codes a jump downwards in dimension (d-1).
   *
   * @return a discrete distribution object
   */
  DiscreteDistribution* JumpDistribution();

private:
  // specific utilities, doomed to be obsoletized by the use of MarmoteBox
  void decodeState( int index, int* buf );
  void nextState( int* buf );
  void decodeTransitions( int index );

};

#endif // MULTIDIMHOMTRANSITION_H
