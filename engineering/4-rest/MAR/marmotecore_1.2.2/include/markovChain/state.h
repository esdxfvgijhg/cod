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

#ifndef STATE_H_
#define STATE_H_

#include "block.h"

namespace lumping {

class state;
class block;

/**
 * @brief The state class to represent states in BFS-like algorithms for
 * computing strongly connected components, periods, lumpings.
 */
class state {

 public:

  int id; /**< index of the state */
  state * backward; /**< pointer to the previous state */
  state * forward; /**< pointer to the next state */
  block * owner; /**< pointer to the block to which the state belongs */
  bool marked; /**< marking flag for exploration algorithms */

 public:
  state(int id);

};

}

#endif /* STATE_H_ */
