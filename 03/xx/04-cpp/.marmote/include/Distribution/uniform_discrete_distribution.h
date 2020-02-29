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

#ifndef uniformDiscreteDistribution_H
#define uniformDiscreteDistribution_H

#include "discrete_distribution.h"

/**
 * @brief The uniform discrete distribution
 *
 */
class UniformDiscreteDistribution : public virtual DiscreteDistribution {

 public:
  /**
   * @brief The unique constructor for the uniform discrete distribution on some interval [a..b]
   * @author	Alain Jean-Marie
   * The mean is calculated at creation.
   * @param val_inf the lower bound (a)
   * @param val_sup the upper bound (b)
   * @return	an object of type uniformDiscreteDistribution
   */
  UniformDiscreteDistribution( int val_inf, int val_sup );

private:
  int val_inf_; /**< @brief lower extremity of the interval */
  int val_sup_; /**< @brief higher extremity of the interval */
  int span_; /**< @brief length of the interval */
  bool is_constant_; /**< @brief indicator of the fact that the interval is reduced to a point */

public:
  // accessors to specific variables
  /**
   * @brief Read accessor to the lower end of the interval
   *
   * @return the lower end of the interval
   */
  int	valInf();
  /**
   * @brief Read accessor to the upper end of the interval
   *
   * @return the upper end of the interval
   */
  int	valSup();

 public: // probabilistic member functions
  /**
    * @copydoc DiscreteDistribution::getProba(double value)
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
   * @copydoc Distribution::Variance()
   */
  double	Variance();
  /**
   * @copydoc Distribution::Laplace(double)
   */
  double	Laplace( double s );
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
  UniformDiscreteDistribution *Rescale( double factor );
  /**
   * @copydoc Distribution::Copy()
   */
  UniformDiscreteDistribution *Copy();
  /**
   * @copydoc Distribution::Sample()
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

#endif // uniformDiscreteDistribution_H
