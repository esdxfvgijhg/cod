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

#ifndef uniformDistribution_H
#define uniformDistribution_H

#include "distribution.h"

/**
 * @brief The continuous uniform distribution over some interval
 *
 */
class UniformDistribution : public virtual Distribution {

private:
  double val_inf_; /**< @brief lower extremity of the interval */
  double val_sup_; /**< @brief higher extremity of the interval */
  double span_; /**< @brief length of the interval */
  bool is_constant_; /**< @brief indicator of the fact that the interval is reduced to a point */

public:
  /**
   * Constructor for a continuous uniform distribution on [a,b]
   * The mean is calculated at creation.
   * @author	Alain Jean-Marie
   * @param	inf the value of a
   * @param	sup the value of b
   * @return	an object of type uniformDistribution
   */
  UniformDistribution( double inf, double sup );

public:
  // accessors to specific variables
  /**
   * @brief Read accessor to the lower end of the interval
   *
   * @return the lower end of the interval
   */
  double	valInf();
  /**
   * @brief Read accessor to the upper end of the interval
   *
   * @return the upper end of the interval
   */
  double	valSup();

 public: // probabilistic member functions
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
  bool		HasMoment( int order); 
  /**
   * @copydoc Distribution::Rescale(double)
   */
  UniformDistribution *Rescale( double factor );
  /**
   * @copydoc Distribution::Copy()
   */
  UniformDistribution *Copy();
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

#endif // uniformDistribution_H
