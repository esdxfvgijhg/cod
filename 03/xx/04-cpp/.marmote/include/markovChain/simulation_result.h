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

#ifndef SIMULATIONRESULT_H
#define SIMULATIONRESULT_H

using namespace std;

#include <string.h>
#include "../Distribution/discrete_distribution.h"
#include "../marmote_constants.h" // at least for the definition of enum timeType

/**
 * @brief The class for transmitting (Monte Carlo) simulation results between objects.
 * Simulation results may be diverse: this structure should be able to accomodate each
 * of the results, even if they are not all present at the same time.
 * Results include: trajectories, empirical frequencies.
 * @author Alain Jean-Marie
 *
 */
class SimulationResult{
 private:
  timeType	type_; /**< Time type of the trajectory: DISCRETE or CONTINUOUS */
  int		state_space_size_; /**< Size of the underlying state space */
  int		trajectory_size_; /**< Length (number of elements) of the trajectory */
  bool		has_distrib_; /**< Indicator of whether the empirical distribution has been computed */
  bool		has_trajectory_; /**< Indicator of whether some trajectory is returned */
  DiscreteDistribution* distrib_; /**< The empirical distribution */
  double*	dates_;	/**< Table of times in the trajectory */
  double*	increments_; /**< Table of time increments in the trajectory */
  int*		state_idx_;	/**< Table of states in the trajectory */

 public:
  // constructors
  /**
   * Constructor for a simulation result object
   * @author Alain Jean-Marie
   * @param size the state of the state space
   * @param t type of time: CONTINUOUS or DISCRETE
   * @param stats whether the occupancy distribution is present or not
   */
  SimulationResult( int size, timeType t, bool stats );
  /**
   * Constructor for a simulation result object from a file
   * @author Alain Jean-Marie
   * @param format the format of the file: the PSI format is supported
   * @param modelName the name of the model
   * @param stats whether the occupancy distribution is present or not
   */
  SimulationResult( string format, string modelName, bool stats );

  // destructor
  /**
   * @brief
   *
   */
  ~SimulationResult();

 public:
  // accessors
  /**
   * @brief Sets the boolean indicating is a trajectory is present.
   *
   * @param v value of the boolean to be set
   */
  void setTrajectory(bool v) { has_trajectory_ = v; }
  /**
   * @brief Sets the size of the trajectory.
   *
   * @param l the size to be set
   */
  void setTrajectorySize(int l) { trajectory_size_ = l; }
  /**
   * @brief Sets the trajectory element of the object, from pointers to tables.
   * Tables are **not** copied.
   *
   * @param d the table of transition dates
   * @param s the table of visited states
   */
  void setTrajectory(double* d, int *s) { dates_ = d; state_idx_ = s; }
  /**
   * @brief Sets the empirical distribution, from a distribution object.
   * The object is **not** copied.
   *
   * @param d the distribution to be set
   */
  void setDistribution(DiscreteDistribution *d) { distrib_ = d; }
  /**
   * @brief Accessor to the empirical distribution
   *
   * @return the distribution
   */
  DiscreteDistribution* distribution() { return distrib_; }
  /**
    * @brief Accessor to the size of the trajectory
    *
    * @return the size
    */
  int trajectorySize() { return trajectory_size_; }
  /**
    * @brief Accessor to the dates of the trajectory
    *
    * @return the size
    */
  double* dates() { return dates_; }
  /**
    * @brief Accessor to the states of the trajectory
    *
    * @return the size
    */
  int* states() { return state_idx_; }

public:
  // output methods
  /**
   * @brief Writes the trajectory to a file
   * @param out the file descriptor to which the trajectory is written
   * @param format the format used for writing. Supported formats are "standard" and "" which are equivalent
   */
  void writeTrajectory( FILE* out, string format );

private:
  // technical private methods
  /**
   * @brief A procedure to get data lines from a file, skipping comments
   * along the way. See the C procedure getline().
   * @param line pointer to a character array, containing the line, to be set by the procedure
   * @param n pointer to the size of the line read
   * @param stream data stream from which the lines are read
   * @return
   */
  ssize_t getDataLine(char** line, size_t *n, FILE* stream);

};

#endif // SIMULATIONRESULT_H
