# memory_monitor (linux)

Repurpose your google tests as memory tests on Linux using a single line of CMake:

```include(cmake/Modules/memory_profiling.cmake)```

Then specify which tests you want to memory profile (using --gtest_filter like syntax) as follows:

```add_memory_profiling(my_test_executable_target_name "MyTestSuite.Test1;MyTestSuite.Test2")```

# Prerequisites

- Python
- CMake
- valgrind

# Demo (Linux)

A step by step demo is provided to illustrate:

```
git clone https://github.com/bensanmorris/memory_monitor.git
cd memory_monitor
cmake -G"Unix Makefiles" -B build .
cd build
cmake --build . --config Release
[NB a summary of any memory issues is displayed]
```

# how it works

- On first execution the memory_profiling.cmake macro will download the python ValgrindCI tool (a python utility wrapper around valgrind)
- It will then generate a POST_BUILD step against each provided test that runs the test under valgrind and generates a memory report
- It will then run ValgrindCI as a POST_BUILD step to analyse the memory report and produce a memory error summary

# Tip Jar / Patreon

If you find this project useful and want to buy me a coffee then you can do so via my itch.io page by [downloading my free software and making a donation as part of that process here](https://benmorris.itch.io/plugin-based-scene-editor). Alternatively if you want to help keep this code monkey in bananas then you can [support me over on Patreon, thanks!](https://www.patreon.com/SimulationStarterKit)
