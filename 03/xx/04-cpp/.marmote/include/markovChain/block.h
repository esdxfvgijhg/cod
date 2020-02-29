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

#ifndef BLOCK_H_
#define BLOCK_H_

#include "state.h"

namespace lumping {

class state;

class block {

public:
    class const_iterator {

    public:
        bool passedMarked;
        state * curr;
        state * unmarked;

    public:
        const_iterator(){
            passedMarked = false;
        }
        const_iterator& operator++();
        bool operator!=(const const_iterator & other);
        state * operator*();
    };

    state * marked;
    state * unmarked;
    int sizeMarked;
    int sizeUnmarked;
    int id;

public:

    block(int id);

    void AddUnmarkedState(state * s);

    void MarkState(state * s);

    bool operator<(const block & other) const;

    const_iterator begin();

    const_iterator end();

    void Clear();

    int Size();

};

}

#endif /* BLOCK_H_ */
