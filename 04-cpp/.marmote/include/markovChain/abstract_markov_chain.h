#ifndef ABSTRACTMARKOVCHAIN_H
#define ABSTRACTMARKOVCHAIN_H

#include "markov_chain.h"
#include "../libXborne.h"
//#include "libPsi.h"

/**
 * @brief The AbstractMarkovChain class. Abstract Markov chains are such that the
 * generator is not created into the memory. It is usually assumed that it is
 * already created and stored under some format. Abstract chains allow the manipulation
 * of these models with external tools, using the same interface as regular chains.
 */
class AbstractMarkovChain : public MarkovChain
{
protected:
   int abstract_nbr_; /**< @brief number of abstraction parameters */
    string* abstract_param_; /**< @brief table of abstraction parameters */

public:
    AbstractMarkovChain();

    /**
     * @brief Simple constructor for the abstract Markov chain from the size and time type
     * @author Alain Jean-Marie
     * @param sz the size of the state space (may be infinite)
     * @param t the type of chain: CONTINUOUS or DISCRETE
     * @return An abstract Markov Chain with no internal structures initialized
     */
    AbstractMarkovChain( int sz, timeType t );

    /**
     * @brief Constructor for Markov chains from files in various formats.
     * In the abstract form, the object just stores the name(s) of the files
     * that define the mode. In the non-abstract (concrete) form, the chain is
     * instantiated in the memory with a concrete transition structure.
     * Only the ERS, PSI and Xborne formats are supported at this time for concrete
     * chains.
     * @author Issam Rabhi and Alain Jean-Marie
     * @param format the format or language in which the model is specified
     * @param param[] is the list of parameters
     * @param nbParam the size of param
     * @param model_name the name of the model, usually the prefix for various files
     * @return an abstract Markov Chain
     */
    AbstractMarkovChain(string format, string param[], int nbParam, string model_name );

    /**
      * @brief Read accessor to get the value of the generator.
      * But abstract chains do not have concrete generators.
      *
      * @return NULL
      */
    TransitionStructure* generator();

    /**
     * @brief Utility to set the value of abstract_nbr_
     *
     * @param abstractNbre the number of abstract parameters to be set
     */
    void set_abstract_nbr(int abstract_nbr){abstract_nbr_=abstract_nbr;}

    /**
     * @brief Utility to set the value of the table containing names related to the model: file names, extensions etc.
     * @author Issam Rabhi and Alain Jean-Marie
     * @param abstract table with the strings to be copied to abstract_
     */
    void set_abstract(string abstract[]);

    /**
     * @brief Read accessor to abstract_nbr_
     * @author Issam Rabhi
     * @return abstract_nbr_ which is the length of the table containing names related to the model.
     */
    int abstract_nbr(){return abstract_nbr_;}

    /**
     * @brief Writing the chain to some file
     * @author Alain Jean-Marie
     **/
    void Write(string format, string model_name);

    /**
     * @brief Utility to provide a description of the object
     * @author Alain Jean-Marie
     **/
    string toString();

    /**
     * @brief Entry point for methods computing stationary distributions using the
     * GTH method for solving the linear system
     * @author Issam Rabhi and Alain Jean-Marie
     * @return the stationary distribution, up to errors in the solution of the linear system
     */
    Distribution* StationaryDistributionGthLD();

    /**
     * @brief Entry point for methods computing stationary distributions using the
     * SOR method for solving the linear system
     * @author Alain Jean-Marie
     * @return the stationary distribution, up to errors in the solution of the linear system
     */
    Distribution* StationaryDistributionSOR();
    /**
     * @brief Entry point for NCD command of XBORNE (Near Complete Decomposibility)
     * @author Issam Rabhi
     * @param epsilon threshold for detecting decomposability
     * @return void but files are created: modelName.NCD.suffix.part and modelName.NCD.suffix.eps
     */
    void NCDProperty(double epsilon);

    /**
     * @brief Entry point for BandIMSUB command of XBORNE
     * @author Issam Rabhi
     * @return void but BandIMSUB create modelName.I.U.sz and modelName.I.U.Rii files
     */
    void BandIMSUB(std::string model_name="modelName");

    /**
     * @brief Entry point for Vincent command of XBORNE
     * @author Issam Rabhi
     * @return void but Vincent creates 4 files: modelName.V.[UL].sz, modelName.V.U.Rii and modelName.V.L.Rdi files
     */
    void Vincent();

    /**
     * @brief Entry point for RowVincent command of XBORNE
     * @author Issam Rabhi
     * @return void but RowVincent creates files modelName.V.U.sz and modelName.V.U.Rii
     */
    void RowVincent();

    /**
     * @brief Entry point for Absorbing command of XBORNE:
     * computes the absorbing states of a DTMC
     * @author Issam Rabhi
     * @return void but Absorbing may create modelName.part if any absorbing nodes are found
     */
    void Absorbing();

    /**
     * @brief Entry point for ProdFundSW command of XBORNE
     * @author Issam Rabhi
     * @return void but ProdFundSW create 5 files:
     * modelName.abs.SW.Cii modelName.abs.SW.sz modelName.FUND.SE.Rii modelName.FUND.SE.sz modelName.RwdP
     */
    void ProdFundSW(std::string model_name="modelName");

    /**
     * @brief Entry point for RowSum command of XBORNE
     * @author Issam Rabhi
     * @return void but RowSum create modelName.rwdT file
     */
    void RowSum(std::string model_name="modelName");

};

#endif // ABSTRACTMARKOVCHAIN_H
