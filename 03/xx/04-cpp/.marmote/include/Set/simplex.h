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

#ifndef SIMPLEX_H
#define SIMPLEX_H

#include "marmote_set.h"

/**
 * @brief The class representing binary sequences with a specified number of "1". 
 *
 */

class Simplex : public MarmoteSet
{
private:
  int nb_dimensions_; /**< dimension of the vector */
  int nb_elements_; /**< total sum of components of the vector */

  long int** binom_; /**< utility array of binomial coefficients */

 public:
  /**
   * @brief Constructor for a simplex from two parameters n and p
   * @param n the number of positions nbPositions
   * @param p the number of particles nbParticles
   */
  Simplex(int n, int p);
  /**
   * @brief Destructor.
   */
  ~Simplex();
  /**
   * @brief Test whether the set is finite. Simplices are always finite.
   * @return true
   */
  bool IsFinite() { return true;}
  /**
   * @copydoc MarmoteSet::IsFirst()
   */
  bool IsFirst(int* buffer);
  /**
   * @copydoc MarmoteSet::FirstState()
   */
  void FirstState(int* buffer);
  /**
   * @copydoc MarmoteSet::NextState()
   */
  void NextState(int *buffer);
  /**
   * @copydoc MarmoteSet::DecodeState()
   */
  void DecodeState(int index, int* buffer);
  /**
   * @copydoc MarmoteSet::Index()
   */
  int Index(int* buffer);
  /**
   * @copydoc MarmoteSet::PrintState()
   */
  void PrintState(FILE* out, int *buffer);

 private:
  /**
   * @brief Auxiliary procedure for indexing a buffer
   * @author Alain Jean-Marie
   * @param n size of the array
   * @param p number of elements to be placed
   * @param buf the state buffer to be filled
   */
  long int idx(int n, int p, int* buf);
  /**
   * @brief Auxiliary procedure for decoding an index
   * @author Alain Jean-Marie
   * @param idx the index to be decoded
   * @param n size of the array
   * @param p number of elements to be placed
   * @param buf the state buffer to be filled
   */
  void deco(long int idx, int n, int p, int* buf);
  /**
   * @brief Auxiliary procedure for finding boundaries of "blocks"
   * @author Alain Jean-Marie
   * @param i the number of the block
   * @param n size of the array
   * @param p number of elements to be placed
   * @param buf the state buffer to be filled
   */
  long int boundary(int i, int n, int p);
  /**
   * @brief Utility function computing binomials
   * @author Alain Jean-Marie
   * @param n 
   * @param p 
   */
  long int binomial(int n, int p);
};

#endif // SIMPLEX_H
