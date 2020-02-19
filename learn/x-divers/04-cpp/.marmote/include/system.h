 #include <stdio.h>
 #include <stdlib.h>
 #include <string>
 #include <vector>

using namespace std;

/**
 * @brief A class for interacting with the file system.
 *
 */

class system
{
 public:

  static std::string pwd();

  static std::string existFile(std::string fileName, std::string rootDirectory);

  static std::string existDirectory(std::string directoryName, std::string rootDirectory);

  static bool hasR();

  static bool hasScilab();

  static std::vector<std::string> getFiles(std::string path, std::string extension);

  static bool isExecutable(std::string name);

  static bool isReadable(std::string name);

  static bool isWritable(std::string name);

};

