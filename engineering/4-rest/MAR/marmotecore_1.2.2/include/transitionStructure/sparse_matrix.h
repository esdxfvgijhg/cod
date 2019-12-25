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

#ifndef SPARSEMATRIX_H
#define SPARSEMATRIX_H



#include "transition_structure.h"

#include <vector>
#include <set>

#include <boost/lockfree/queue.hpp>
#include <boost/atomic.hpp>
#include <boost/thread.hpp>

using namespace std;

/**
 * @brief The SCC structure, to hold the description of individual Strongly Connected Components.
 */
struct SCC {
    int id;  /**< index of the SCC */
    int period; /**< period of this SCC */
    std::set<int> states; /**< list of states indices in the SCC */
	bool operator<(const SCC& a) {
	  return id < a.id;
    } /**< comparison of (indices) of SCCs */
};

/**
 * @brief Class SparseMatrix: implementation of a transition structure using
 * the sparse matrix data structure. Elements of the transition structure (matrix)
 * are stored by row, using two arrays containing indices of columns, and values
 * of entries. A priori, only non-zero entries are stored but this is not a requirement.
 * @author Alain Jean-Marie, from the ERS package
 *
 */
class SparseMatrix : public TransitionStructure
{

  /**
   * markovChain class is a friend class because we want markovChain
   * to be the main class for user.
   */
  friend class MarkovChain;

private:
  // specific variables of the class
  int*		nb_elts_; 	/**< Table of numbers of elements in rows */
  int**		elts_;		/**< Ids of neighboring states in a row */
  double**	vals_;		/**< entries in a row */

  std::pair<std::vector<SCC> *, SparseMatrix *> sccs_;/**< cached computed strongly connected components with SparseMatrix of transitions */

  SparseMatrix* reverted_; /**< cached transpose of the sparse matrix */
  bool		debug_;     /**< internal debugging indicator */

public:
  // constructors
  /**
   * @brief Standard constructor for sparse matrices. The internal structures
   * are initialized. The result is the null matrix.
   * @param size the number of states/rows and columns in the structure
   * @return a sparse matrix object
   */
  SparseMatrix(int size);

  // constructors
  /**
   * @brief Constructor for non-square sparse matrices. The internal structures
   * are initialized. The result is the null matrix.
   * @param rowSize the number of origin states/rows in the structure
   * @param colSize the number of destination states/columns in the structure
   * @return a sparse matrix object
   */
  SparseMatrix(int rowSize, int colSize);

  // destructor
  /**
   * @copydoc TransitionStructure::~TransitionStructure()
   */
  ~SparseMatrix();

public:
  /**
   * @brief Inserting an element in the matrix.
   * IMPORTANT NOTE: there is no check for the existence of the column
   * This is because in the context of Markov Reward Processes, there
   * may be several transitions with different reward. It is simpler to
   * handle this by allowing replicated entries in the neighborhood lists.
   * The multiplication algorithm handles this in a natural way. BUT the
   * getEntry(int,int) method must handle this situation carefully.
   * @author Alain Jean-Marie
   * @param row the row number
   * @param col the column number
   * @param val the value to be inserted
   * @return true if successful, that is, if ranges are OK and memory allocation is OK.
   */
  bool setEntry(int row, int col, double val); // set A[i,j]
  /**
   * @brief Retrieving an entry from the matrix. Takes into account the fact that
   * columns may be replicated: the different values are then added. @see setEntry()
   * @author Alain Jean-Marie
   * @param row
   * @param col
   */
  double getEntry(int,int); // get A[i,j]
  /**
   * @brief Retrieving a the number of elements on some row
   * @author Alain Jean-Marie
   * @param row the number of the row
   * @return the number of columns
   */
  int getNbElts(int row); // get the number of entries in row i
  /**
   * @brief Retrieving an low-level entry from the matrix.
   * @author Alain Jean-Marie
   * @param row the number of the row
   * @param numCol the number of the entry in the sparse structure
   */
  int getCol(int row, int numCol ); // get the jth column for row i
  /**
   * @brief Retrieving an low-level entry from the matrix.
   * @author Alain Jean-Marie
   * @param row the number of the row
   * @param numCol the number of the entry in the sparse structure
   */
  double getEntryByCol(int row, int numCol); // get the value in the jth column for row i
  /**
   * @brief Retrieving the transitions from some state as a discrete distribution
   * @author Alain Jean-Marie
   * @param row the number of the row
   * @return the distribution: next states with the corresponding probas
   */
  DiscreteDistribution* TransDistrib(int row); // transitions from some state
  /**
   * @brief Summing a row
   * @author Alain Jean-Marie
   * @param row the number of the row
   * @return the sum of the entries of the row (including diagonal)
   */
  double RowSum(int row);
  /**
   * @brief Sparse vector/matrix multiplication. The result is stored in an array
   * that must be already allocated. Anciently the "multVM" method.
   * @author Alain Jean-Marie
   * @param m the measure (row vector) to be multiplied
   * @param res the resulting vector
   */
  void EvaluateMeasure(double* m, double* res);
  /**
   * Version of the vector/matrix multiplication that acts on discreteDistribution objects.
   * @author Alain Jean-Marie
   * @param d the distribution to be multiplied
   */
  DiscreteDistribution* EvaluateMeasure(DiscreteDistribution* d);
  /**
   * @brief Sparse matrix/vector multiplication. The result is stored in an array
   * that must be already allocated. Anciently the "multMV" method.
   * @author Alain Jean-Marie
   * @param v the value (column vector) to be multiplied
   * @param res the resulting vector
   */
  void EvaluateValue(double* v, double* res);
  /**
   * @brief Sparse matrix/vector multiplication, for a specific state/line of the matrix
   * @author Emmanuel Hyon and Abood Mourad
   * @param v the value (column vector) to be multiplied
   * @param stateIndex the index of the state for which to perform the multiplication
   * @return the value of the state
   * */
  double EvaluateValueState(double* v, int stateIndex);


public:
  /**
   * @brief Sparse matrix copy. This is a straightforward copy.
   * No optimization is performed, viz replicated columns.
   * @author Alain Jean-Marie
   * @return a copy of the generator
   */
  SparseMatrix* Copy();
  /**
   * @brief Sparse matrix uniformization. Returns a sparse matrix and
   * sets the uniformization factor.
   * If the type is already discrete, returns a copy.
   * @author Alain Jean-Marie
   * @return the uniformized version of the generator
   */
  SparseMatrix* Uniformize();
  /**
   * @brief Sparse matrix embedding. Returns a sparse matrix.
   * If the type is already discrete, returns a copy.
   * @author Alain Jean-Marie
   * @return the embedded version of the generator
   */
  SparseMatrix* Embed();
  /**
   * @brief Sparse matrix transposition. Returns a sparse matrix.
   * @author Hlib Mykhailenko
   * @return the transposed, or reverted transition structure
   */
  SparseMatrix* Revert();

 public:
  /**
   * @brief Performs various diagnostics on the transition structure (only written
   * for SparseMatrix objects at the moment)
   * @author Alain Jean-Marie
   * @param out the file descriptor to which the diagnostic is written
   */
  void Diagnose(FILE* out);
  /**
   * @brief Writing a sparse matrix to a file. Several formats could be chosen.
   * Supported formats are: "Ers", "Full", "MatrixMarket-sparse", "MatrixMarket-full", "Maple", "MARCA", "R", "scilab", "XBORNE".
   *
   * @author Alain Jean-Marie
   * @param out the file descriptor to which the matrix is written
   * @param format the name of the format/language to use
   */
  virtual void Write(FILE* out, std::string format);

  // methods specific to this class
  /**
   * @brief Adding a value to an element to the matrix
   * @author Alain Jean-Marie
   * @param row number of the row
   * @param col number of the column
   * @param val value to be added
   * @return true if successful, @see setEntry()
   */
  bool addToEntry(int row, int col, double val); // add to A[i,j]

private:
  // specific technical methods
  /**
   * @brief Method to consolidate (aggregate) transition probabilities/rates from a given state.
   * The method returns the number of different destination states, and modifies the arrays
   * which will containt the lists of destinations and the corresponding probabilities.
   * These arrays must have been allocated beforehand, with a size at least the number of
   * events.
   * @param i the origin state
   * @param destinations the list of destinations
   * @param values the list of probabilities
   * @return the number of different destinations
   */
  int Consolidate(int i, int* destinations, double* values);

public:
  /**
   * @brief Method to normalize transition probabilities/rates across the matrix.
   * The normalized form has strictly increasing column indices for each row.
   */
  void Normalize();


public:

  /**
   * @brief Method for computing strongly connected components of the Markov chain
   * which utilize Divide-and-Conquer algorithm.
   * @author Hlib Mykhailenko
   */
  std::pair<std::vector<SCC>*, SparseMatrix*> getStronglyConnectedComponents(double ignore = 0.0);

  /**
    * @brief getReverted. Constructs and returns the transposed matrix.
    * @return a SparseMatrix object
    */
   SparseMatrix* getReverted();

private:

  /**
   * @brief Breadth first search implementation. Finds all states which are reachable frmo 'pivot'.
   * @author Hlib Mykhailenko
   * @param ts structure of transitions between states of markovChain
   * @param pivot starting state
   * @param vertices defines states which should be considered (kind of filter data structure for ts)
   * @param ignore method ignores all thansitions with probability less or equal than ignore
   */
  std::set<int> * bfs(int pivot, std::set<int> * vertices = NULL, double ignore = 0.0);

  /**
   * @brief Computes period of the chain
   * according to Chapter 17, Graph-Theoretic Analysis of Finite Markov Chains.
   * @author Hlib Mykhailenko
   */
  int period(TransitionStructure * ts, set<int> * sccStates);

  /**
   * @brief Creates and returns new SparseMatrix with the given states and transitions only between given states
   * @author Hlib Mykhailenko
   * @param states Set of states according to which method filters states
   */
  SparseMatrix * newFiltered(std::vector<int> states);


  void sccSeeker(boost::lockfree::queue< set<int> * > * qjob,
			 boost::lockfree::queue<SCC *> * qscc,
             SparseMatrix * sparse,
             SparseMatrix * Revert,
			 boost::atomic<int> * counter, double ignore);

  int trimmer(TransitionStructure * ts, set<int> * vertices, boost::lockfree::queue<SCC *> * qscc, double ignore);

  void clearComputedSCCs();



  virtual int period();

};

#endif // SPARSEMATRIX_H
