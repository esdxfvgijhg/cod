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

#ifndef bernoulliDistribution_H
#define bernoulliDistribution_H

#include "discrete_distribution.h"

/**
 * @brief The Bernoulli distribution with two values
 *
 */
class BernoulliDistribution : public virtual DiscreteDistribution {

public:
  /**
   * @brief Unique onstructor for a Bernoulli distribution from the probability
   * that it is equal to 1.
   * @author	Alain Jean-Marie
   * @param	val the value P( X = 1 )
   * @return	an object of type bernoulliDistribution
   */
  BernoulliDistribution( double ); // creation from a value

private:
  // private variables specific to the distribution
  double proba_;  /**< proba of the value 1 */

public:
  // accessors to specific variables
  /**
   * @brief Accessor to the parameter of the distribution. Redundant with the
   * standard accessor proba() but more explicit.
   *
   * @return the parameter
   */
  double	getParameter() { return proba_; }
  /**
   * @brief Accessor to the parameter of the distribution. Redundant with the
   * accessor getParameter() but conform to the coding standard.
   *
   * @return the parameter
   */
  double	proba() { return proba_; }

public: 
  // probabilistic member functions
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
   * @brief Rescaling the distribution. Bernoulli distributions cannot be
   * rescaled. Ac copy is returned and an error message is issued if the
   * factor is not 1.0.
   *
   * @copydetails Distribution::Rescale(double)
   */
  BernoulliDistribution *Rescale( double factor );
  /**
   * @copydoc Distribution::Copy()
   */
  BernoulliDistribution *Copy();

  /**
   * @copydoc Distribution::Sample()
   */
  double	Sample();

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

#endif // bernoulliDistribution_H
