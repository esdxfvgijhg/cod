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

#ifndef DISCRETEDISTRIBUTION_H
#define DISCRETEDISTRIBUTION_H

#include "distribution.h"

/**
 * @brief The general discrete distribution with finite support
 *
 */
class DiscreteDistribution : public virtual Distribution {

 public:
  // constructors
/**
 * @brief
 *
 */
  DiscreteDistribution();
  /**
   * @brief Constructor for a general discrete distribution from arrays.
   * The arrays are ***copied***, not taken as pointer.
   * The mean is calculated at creation.
   * @author	Alain Jean-Marie
   * @param sz	number of values/probas
   * @param vals	array of values
   * @param probas	probability vector
   * @return	an object of type discreteDistribution
   */
  DiscreteDistribution( int sz, double* vals, double* probas );

  /**
   * @brief Constructor for a general discrete distribution from a file.
   * The file is assumed to contain only the probas.
   * The values are arbitrarily chosen between 0 and sz-1.
   * The mean is calculated at creation.
   *
   * @author	Alain Jean-Marie
   * @param sz	number of values/probas
   * @param name	the name of the file
   * @return	an object of type discreteDistribution
   */
  DiscreteDistribution( int sz, char *name );

 protected:
  // partial constructors
  /**
   * @brief Constructor for a general discrete distribution from its size.
   * Arrays are created to this size but not initialized.
   * DANGEROUS to use since methods cannot check whether these arrays are correct or not. Use reserved to sub-types such as diracDistribution
   * @author	Alain Jean-Marie
   * @param sz	number of values/probas
   * @return	an object of type discreteDistribution
   */
  DiscreteDistribution( int sz );

public:
  // destructor
  /**
   * @brief Destructor for a general discrete distribution. The convention is that
   * internal arrays for values and probas are freed at this moment.
   * If they are useful for something else, they sould be copied.
   * @author	Alain Jean-Marie
   */
  ~DiscreteDistribution();

protected:
  // specific variables
  int	  nb_vals_; /**< number of values in the distribution */
  double* values_; /**< table of values */
  double* probas_; /**< table of probabilities */

public:
 // accessors and such

  /**
   * @brief Read accessor for the elements of the probas array.
   * This is a pseudo-accessor since it performs additional checks.
   * @author	Alain Jean-Marie
   * @param i the index of the entry
   * @return the probability of entry i, or 0 if the index is out of range
   */
  double	getProbaByIndex(int i);

  /**
   * @brief Computes the probability of a particular value.
   * The tolerance VALUE_TOLERANCE is applied to match values.
   * @author	Alain Jean-Marie
   * @param value the value at which the proba is computed
   * @return the probability of value v
   */
  double	getProba(double value);

  /**
   * @brief Read accessor to the values (support set) of the distribution.
   * DANGEROUS: the resulting table should be used uniquely as read-only
   * @author Alain Jean-Marie
   * @return a pointer to the array of values
   */
  double* values() { return values_; }
  /**
   * @brief Read accessor to the probabilities of the distribution.
   * DANGEROUS: the resulting table should be used uniquely as read-only
   * @author Alain Jean-Marie
   * @return a pointer to the array of probabilities
   */
  double* probas() { return probas_; }
  /**
   * @brief Read accessor for the values. This is a pseudo-accessor since it performs additional
   * checks.
   * @author	Alain Jean-Marie
   * @param i the index of the entry
   * @return the value of entry i, or 0 if the index is out of range
   */
  double	getValue(int i);

  /**
   * @brief Read accessor to the number of values in the distribution
   *
   * @return the number of values _nbVals
   */
  int		nb_vals() { return nb_vals_; }

  /**
   * @brief Write accessor for the probas. This is a pseudo-accessor since it performs additional
   * checks.
   * @author	Alain Jean-Marie
   * @param i the index of the entry
   * @param v the value to be given to the entry
   * @return true if ok, or false if the index is out of range
   */
  bool		setProba(int i, double v);

public:
  // probabilistic member functions

  /**
   * @brief Calculation of the mean. Returns the value since it is pre-computed
   * @author	Alain Jean-Marie
   * @return	the mathematical expectation of the distribution
   */
  double	Mean() { return mean_; }

  /**
   * @brief Calculation of the rate, which is the inverse of the mean. If the mean
   * is 0, the value INFINITE_RATE is returned.
   * @author	Alain Jean-Marie
   * @return	the rate
   */
  double	Rate(); // inverse of the mean
  /**
   * @copydoc Distribution::Moment()
   */
  double	Moment( int order );
  /**
   * @copydoc Distribution::Laplace(double s)
   */
  double	Laplace( double s ); // Laplace transform at real points
  /**
   * @copydoc Distribution::DLaplace(double s)
   */
  double	DLaplace( double s ); // derivative of the Laplace transform
  /**
   * @brief
   *
   * @param x
   * @return double
   */
  double	Cdf( double x );
  /**
   * @brief Test of existence of a moment. These distributions always have one.
   * @author	Alain Jean-Marie
   * @param order	order of the moment
   * @return	true
   */
  bool		HasMoment( int order );
  
  /**
   * @copydoc Distribution::Rescale(double factor)
   */
  DiscreteDistribution *Rescale( double factor );
  /**
   * @copydoc Distribution::Copy()
   */
  DiscreteDistribution *Copy();

  /**
   * @brief Samples a pseudo-random value of the distribution
   *
   * @return double
   */
  double	Sample();

  /**
   * @brief Computes the L2 distance between the distribution and the one passed
   * as parameter
   * @param d
   * @return double
   */

  double	DistanceL2( DiscreteDistribution* d );
  using Distribution::DistanceL1;
  /**
   * @brief Computes the L1 distance between the distribution and the one passed
   * as parameter
   * @param d
   * @return double
   */
  double    DistanceL1(DiscreteDistribution* d);
  /**
   * @brief Computes the L-infinity (sup norm) distance between the distribution and 
   * the one passed as parameter
   *
   * @param d
   * @return double
   */
  double	DistanceLinfinity( DiscreteDistribution* d );

 public:
  /**
   * @brief Printing a representation of the law into a string
   * @author	Alain Jean-Marie
   * @return a string
   */
  std::string toString();
  /**
   * @brief Printing a representation of the law
   * @author	Alain Jean-Marie
   * @param out file descriptor of the output stream
   * @param mode	representation for the output
   */
  void Write( FILE *out, int mode );

};

#endif // DISCRETEDISTRIBUTION_H
