# memory_monitor (linux)

Repurpose your google tests as memory tests on Linux using a single line of CMake:

```include(cmake/Modules/memory_profiling.cmake)```

Then specify which tests you want to memory profile (using --gtest_filter like syntax) as follows:

```add_memory_profiling(my_test_executable_target_name "MyTestSuite.Test1;MyTestSuite.Test2")```

# demo

A step by step demo is provided to illustrate:

```
git clone https://github.com/bensanmorris/memory_monitor.git
cd memory_monitor
cmake -G"Unix Makefiles" -B build .
cd build
cmake --build . --config Release
[NB a summary of any memory issues is displayed]
```
