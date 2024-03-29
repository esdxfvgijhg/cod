# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.14

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/bin/cmake

# The command to remove a file.
RM = /usr/local/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build

# Include any dependencies generated for this target.
include CMakeFiles/LoRa_Blocks.dir/depend.make

# Include the progress variables for this target.
include CMakeFiles/LoRa_Blocks.dir/progress.make

# Include the compile flags for this target's objects.
include CMakeFiles/LoRa_Blocks.dir/flags.make

LoRa_BlocksDocs.cpp: ../LoRaDemod.cpp
LoRa_BlocksDocs.cpp: ../LoRaMod.cpp
LoRa_BlocksDocs.cpp: ../LoRaEncoder.cpp
LoRa_BlocksDocs.cpp: ../LoRaDecoder.cpp
LoRa_BlocksDocs.cpp: ../TestLoopback.cpp
LoRa_BlocksDocs.cpp: ../TestGen.cpp
LoRa_BlocksDocs.cpp: ../BlockGen.cpp
LoRa_BlocksDocs.cpp: ../TestCodesSx.cpp
LoRa_BlocksDocs.cpp: ../TestDetector.cpp
LoRa_BlocksDocs.cpp: Version.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Generating LoRa_BlocksDocs.cpp"
	./PothosUtil.sh --doc-parse /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaDemod.cpp /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaMod.cpp /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaEncoder.cpp /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaDecoder.cpp /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestLoopback.cpp /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestGen.cpp /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/BlockGen.cpp /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestCodesSx.cpp /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestDetector.cpp /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/Version.cpp --output /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/LoRa_BlocksDocs.cpp

CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.o: CMakeFiles/LoRa_Blocks.dir/flags.make
CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.o: ../LoRaDemod.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_2) "Building CXX object CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.o -c /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaDemod.cpp

CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaDemod.cpp > CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.i

CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaDemod.cpp -o CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.s

CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.o: CMakeFiles/LoRa_Blocks.dir/flags.make
CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.o: ../LoRaMod.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_3) "Building CXX object CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.o -c /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaMod.cpp

CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaMod.cpp > CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.i

CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaMod.cpp -o CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.s

CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.o: CMakeFiles/LoRa_Blocks.dir/flags.make
CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.o: ../LoRaEncoder.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_4) "Building CXX object CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.o -c /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaEncoder.cpp

CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaEncoder.cpp > CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.i

CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaEncoder.cpp -o CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.s

CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.o: CMakeFiles/LoRa_Blocks.dir/flags.make
CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.o: ../LoRaDecoder.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_5) "Building CXX object CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.o -c /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaDecoder.cpp

CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaDecoder.cpp > CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.i

CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/LoRaDecoder.cpp -o CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.s

CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.o: CMakeFiles/LoRa_Blocks.dir/flags.make
CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.o: ../TestLoopback.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_6) "Building CXX object CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.o -c /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestLoopback.cpp

CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestLoopback.cpp > CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.i

CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestLoopback.cpp -o CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.s

CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.o: CMakeFiles/LoRa_Blocks.dir/flags.make
CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.o: ../TestGen.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_7) "Building CXX object CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.o -c /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestGen.cpp

CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestGen.cpp > CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.i

CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestGen.cpp -o CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.s

CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.o: CMakeFiles/LoRa_Blocks.dir/flags.make
CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.o: ../BlockGen.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_8) "Building CXX object CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.o -c /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/BlockGen.cpp

CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/BlockGen.cpp > CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.i

CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/BlockGen.cpp -o CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.s

CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.o: CMakeFiles/LoRa_Blocks.dir/flags.make
CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.o: ../TestCodesSx.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_9) "Building CXX object CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.o -c /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestCodesSx.cpp

CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestCodesSx.cpp > CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.i

CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestCodesSx.cpp -o CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.s

CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.o: CMakeFiles/LoRa_Blocks.dir/flags.make
CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.o: ../TestDetector.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_10) "Building CXX object CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.o -c /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestDetector.cpp

CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestDetector.cpp > CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.i

CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/TestDetector.cpp -o CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.s

CMakeFiles/LoRa_Blocks.dir/Version.cpp.o: CMakeFiles/LoRa_Blocks.dir/flags.make
CMakeFiles/LoRa_Blocks.dir/Version.cpp.o: Version.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_11) "Building CXX object CMakeFiles/LoRa_Blocks.dir/Version.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LoRa_Blocks.dir/Version.cpp.o -c /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/Version.cpp

CMakeFiles/LoRa_Blocks.dir/Version.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoRa_Blocks.dir/Version.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/Version.cpp > CMakeFiles/LoRa_Blocks.dir/Version.cpp.i

CMakeFiles/LoRa_Blocks.dir/Version.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoRa_Blocks.dir/Version.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/Version.cpp -o CMakeFiles/LoRa_Blocks.dir/Version.cpp.s

CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.o: CMakeFiles/LoRa_Blocks.dir/flags.make
CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.o: LoRa_BlocksDocs.cpp
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_12) "Building CXX object CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.o"
	/usr/bin/c++  $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -o CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.o -c /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/LoRa_BlocksDocs.cpp

CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.i: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Preprocessing CXX source to CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.i"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -E /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/LoRa_BlocksDocs.cpp > CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.i

CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.s: cmake_force
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green "Compiling CXX source to assembly CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.s"
	/usr/bin/c++ $(CXX_DEFINES) $(CXX_INCLUDES) $(CXX_FLAGS) -S /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/LoRa_BlocksDocs.cpp -o CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.s

# Object files for target LoRa_Blocks
LoRa_Blocks_OBJECTS = \
"CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.o" \
"CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.o" \
"CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.o" \
"CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.o" \
"CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.o" \
"CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.o" \
"CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.o" \
"CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.o" \
"CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.o" \
"CMakeFiles/LoRa_Blocks.dir/Version.cpp.o" \
"CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.o"

# External object files for target LoRa_Blocks
LoRa_Blocks_EXTERNAL_OBJECTS =

libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/LoRaDemod.cpp.o
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/LoRaMod.cpp.o
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/LoRaEncoder.cpp.o
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/LoRaDecoder.cpp.o
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/TestLoopback.cpp.o
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/TestGen.cpp.o
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/BlockGen.cpp.o
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/TestCodesSx.cpp.o
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/TestDetector.cpp.o
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/Version.cpp.o
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/LoRa_BlocksDocs.cpp.o
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/build.make
libLoRa_Blocks.so: /usr/local/lib/libPothos.so
libLoRa_Blocks.so: /usr/lib/libPocoFoundation.so
libLoRa_Blocks.so: /usr/lib/libPocoUtil.so
libLoRa_Blocks.so: /usr/lib/libPocoNet.so
libLoRa_Blocks.so: /usr/lib/libPocoXML.so
libLoRa_Blocks.so: CMakeFiles/LoRa_Blocks.dir/link.txt
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --green --bold --progress-dir=/home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles --progress-num=$(CMAKE_PROGRESS_13) "Linking CXX shared module libLoRa_Blocks.so"
	$(CMAKE_COMMAND) -E cmake_link_script CMakeFiles/LoRa_Blocks.dir/link.txt --verbose=$(VERBOSE)

# Rule to build all files generated by this target.
CMakeFiles/LoRa_Blocks.dir/build: libLoRa_Blocks.so

.PHONY : CMakeFiles/LoRa_Blocks.dir/build

CMakeFiles/LoRa_Blocks.dir/clean:
	$(CMAKE_COMMAND) -P CMakeFiles/LoRa_Blocks.dir/cmake_clean.cmake
.PHONY : CMakeFiles/LoRa_Blocks.dir/clean

CMakeFiles/LoRa_Blocks.dir/depend: LoRa_BlocksDocs.cpp
	cd /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build /home/aghiles/Aghiles/Program/gateway/sdr/LoRa-SDR/build/CMakeFiles/LoRa_Blocks.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : CMakeFiles/LoRa_Blocks.dir/depend

