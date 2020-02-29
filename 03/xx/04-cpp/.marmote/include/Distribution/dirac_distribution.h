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

#ifndef diracDistribution_H
#define diracDistribution_H

#include "discrete_distribution.h"

/**
 * @brief The Dirac distribution concentrated at some point

 *
 */
class DiracDistribution : public virtual DiscreteDistribution {

public:
/**
 * @brief Unique constructor for the Dirac distribution from its value.
 *
 * @param val the value at which the distribution is concentrated
 */
  DiracDistribution( double val ); // creation from a value

private:
  // specific variables
  double value_; /**< the value characterizing the distribution */

public:
  // accessors to specific variables
  /**
   * @brief Read accessor to the value of the Dirac distribution
   *
   * @return the value of the distribution
   */
  double	value(int) { return value_; }

public: 
  // probabilistic member functions

  /**
   * @copydoc DiscreteDistribution::getProba()
   */
  double getProba(double value);

  /**
   * @copydoc Distribution::Mean()
   */
  double	Mean();
  /**
   * @copydoc Distribution::Rate()
   */
  double	Rate(); 
  /**
   * @copydoc Distribution::Moment(int)
   */
  double	Moment( int order );
  /**
   * @brief Variance of the Dirac distribution. Reimplemented to return
   * always 0.
   */
  double	Variance();
  /**
   * @copydoc Distribution::Laplace(double)
   */
  double	Laplace( double s ); // Laplace transform at real points
  /**
   * @copydoc Distribution::DLaplace(double)
   */
  double	DLaplace( double s ); // derivative of the Laplace transform
  /**
   * @copydoc Distribution::Cdf()
   */
  double	Cdf( double x );
  /**
   * @copydoc Distribution::HasMoment(int)
   */
  bool		HasMoment( int order );
  
  /**
   * @copydoc Distribution::Rescale(double)
   */
  DiracDistribution *Rescale( double factor );
  /**
   * @copydoc Distribution::Copy()
   */
  DiracDistribution *Copy();

  /**
   * @copydoc Distribution::Sample()
   */
  double	Sample();
  /**
   * @brief Sampling of i.i.d. values in a table. Reimplemented in order
   * to avoid useless function calls.
   *
   * @copydetails Distribution::IidSample(int n, double* s)
   */
  void		IidSample( int n, double* s );

 public:
  /**
   * @copydoc Distribution::toString()
   */
  std::string toString();
  /**
   * @copydoc Distribution::Write(FILE*,int)
   */
  void Write( FILE *out, int mode );

};

#endif // diracDistribution_H
