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

/* marmoteInterval.h ---
 *
 * Author: Alain Jean-Marie
 */

/* Commentary:
 *
 */

/* Change log:
 *
 */


#ifndef MARMOTEINTERVAL_H
#define MARMOTEINTERVAL_H
#include "marmote_set.h"

/**
 * @brief The class describing a <b>finite</b> integer interval.
 *
 */
class MarmoteInterval : public MarmoteSet {

 protected:
  int min_; /**< the lower end of the interval */
  int max_; /**< the higher end of the interval */

 public:
  /**
   * Constructor for an interval. By convention, if max < min, then the
   * interval is empty. Otherwise, both min and max are inside the interval.
   * @author Alain Jean-Marie
   * @param min the low end of the interval
   * @param max the high end of the interval
   */
  MarmoteInterval( int min, int max );
  /**
   * Standard destructor for an interval.
   * @author Alain Jean-Marie
   */
  ~MarmoteInterval();

 public:
  /**
   * @brief Test if the set is finite. These sets always are.
   *
   * @return true
   */
  bool IsFinite() { return true; }
  /**
   * @copydoc MarmoteSet::IsFirst(int*)
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
   * @copydoc MarmoteSet::DecodeState(int,int*)
   */
  void DecodeState(int index, int* buffer);
  /**
   * @copydoc MarmoteSet::Index(int*)
   */
  int Index(int* buffer);
  /**
   * @copydoc MarmoteSet::PrintState()
   */
  void PrintState(FILE* out, int *buffer);

 public:
  /**
   * @brief Enumeration procedure.
   *
   */
  void Enumerate();

};

#endif // MARMOTEINTERVAL_H
