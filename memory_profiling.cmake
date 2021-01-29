# Adds automated memory checking of the provided tests (performed as test executable post build steps)
# Typical usage - add_memory_profiling(${TEST_EXECUTABLE_NAME} "Test1;Test2;etc")
function(add_memory_profiling TEST_EXECUTABLE_NAME TESTS)
    if(NOT (APPLE OR ANDROID OR WIN32))

        if(NOT TEST_EXECUTABLE_NAME OR NOT TESTS)
            message(FATAL_ERROR "add_memory_profiling function requires test targets to profile")
        endif()
        
        message(STATUS "PROFILING MEMORY TESTS = ${TESTS}")
        
        find_package(Python COMPONENTS Interpreter)
        if(NOT Python_Interpreter_FOUND)
            message(FATAL_ERROR "Python is required in order to perform memory profiling")
        endif()

        execute_process(COMMAND valgrind-ci
                        RESULT_VARIABLE PYTHON_CHECK_RESULT
                        OUTPUT_VARIABLE PYTHON_CHECK_OUTPUT
                        ERROR_VARIABLE  PYTHON_CHECK_ERROR)
        if(PYTHON_CHECK_RESULT AND NOT PYTHON_CHECK_RESULT EQUAL 0)
            message(STATUS "valgrind-ci is required for memory profiling support, installing...")
            execute_process(COMMAND "${Python_EXECUTABLE}" -m pip install "ValgrindCI" --user
                RESULT_VARIABLE PYTHON_CHECK_RESULT
                OUTPUT_VARIABLE PYTHON_CHECK_OUTPUT
                ERROR_VARIABLE  PYTHON_CHECK_ERROR)
            if(PYTHON_CHECK_RESULT AND NOT PYTHON_CHECK_RESULT EQUAL 0)
                message(FATAL_ERROR "Memory profiling requires your Python interpreter has ValgrindCI package installed. I tried installing this for you but the installation failed. Error is: ${PYTHON_CHECK_ERROR}")
            endif()
        endif()

        find_program(VALGRIND valgrind REQUIRED)
        set(MEM_CHECK_TOOL_OPTIONS "--xml=yes")
        foreach(TEST ${TESTS})
            set(PROFILE_OUTPUT_FILENAME "./${TEST_EXECUTABLE_NAME}_${TEST}_memory_profile.xml") 
            add_custom_command(TARGET ${TEST_EXECUTABLE_NAME} POST_BUILD COMMAND "${VALGRIND}" --tool=memcheck ${MEM_CHECK_TOOL_OPTIONS} --xml-file=${PROFILE_OUTPUT_FILENAME} ./${TEST_EXECUTABLE_NAME} --gtest_filter=${TEST})
            add_custom_command(TARGET ${TEST_EXECUTABLE_NAME} POST_BUILD COMMAND valgrind-ci ${PROFILE_OUTPUT_FILENAME} --number-of-errors)
        endforeach()
    else()
        message(STATUS "memory profiling is not supported on this platform, skipping memory profiling...")
    endif()
endfunction()
