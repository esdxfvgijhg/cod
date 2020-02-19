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

#ifndef poissonDistribution_H
#define poissonDistribution_H

#include "distribution.h"
#ifdef WITH_R
#include <RInside.h>
#endif

/**
 * @brief The Poisson distribution. The parameter is called "lambda".
 * The Poisson distribution is discrete but does not inherit from discreteDistribution
 * because its range is infinite.
 * @author Alain Jean-Marie
 *
 */
class PoissonDistribution : public virtual Distribution {

public:
  /**
   * @brief Constructor for a Poisson distribution from its "lambda" parameter.
   * The mean is calculated at creation.
   * @author	Alain Jean-Marie
   * @param lambda a non-negative real number
   * @return	an object of type poissonDistribution
   */
  PoissonDistribution( double lambda );

  /**
   * @brief Destructor for a Poisson distribution.
   * @author	Alain Jean-Marie
   */
  ~PoissonDistribution();

private:
  // private variables specific to the distribution
  double  lambda_; /**< the "rate" of the Poisson distribution, also its mean. */

#ifdef WITH_R
  static RInside* r_motor_; /**< @brief R execution engine; there is at most one; may not be created at all */
#else
  typedef void* RInside;
  static RInside* r_motor_;
#endif

private:
  RInside* Rmotor();


public:
  // accessors to specific variables
  /**
   * @brief Function to obtain the probability of a specific value k
   *
   * @param k the value at which the probability should be computed
   * @return the probability that the random variable is k
   */
  double 	getProba(double k );

  /**
   * @brief Function to obtain the parameter (or ratio) of the distribution. Redundant with p() but
   * defined to be more explicit.
   *
   * @return the value of the ratio
   */
  double 	lambda() { return lambda_; }

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
   * @copydoc Distribution::Variance()
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
   * @copydoc Distribution::Ccdf()
   */
  double	Ccdf( double x );
  /**
   * @copydoc Distribution::HasMoment(int)
   */
  bool		HasMoment( int order );
  
  /**
   * @copydoc Distribution::Rescale(double)
   */
  PoissonDistribution *Rescale( double factor );
  /**
   * @copydoc Distribution::Copy()
   */
  PoissonDistribution *Copy();
  /**
   * @brief Sample from the Poisson distibution. Uses the "R" package.
   */
  double	Sample();
  /**
   * @copydoc Distribution::IidSample()
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

#endif // poissonDistribution_H
