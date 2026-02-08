macro(terrauto_package)
  # Set compile options
  if(NOT CMAKE_CXX_STANDARD)
    set(CMAKE_CXX_STANDARD 17)
    set(CMAKE_CXX_STANDARD_REQUIRED ON)
    set(CMAKE_CXX_EXTENSIONS OFF)
  endif()
  if(CMAKE_COMPILER_IS_GNUCXX OR CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    add_compile_options(-Wall -Wextra -Wpedantic)
    if(${CMAKE_VERSION} VERSION_GREATER_EQUAL "3.24.0")
      option(CMAKE_COMPILE_WARNING_AS_ERROR "Treat compiler warnings as errors." ON)
      mark_as_advanced(CMAKE_COMPILE_WARNING_AS_ERROR)
    else()
      add_compile_options(-Werror)
    endif()
  endif()

  # Ignore PCL errors in Clang
  if(CMAKE_CXX_COMPILER_ID MATCHES "Clang")
    add_compile_options(-Wno-gnu-anonymous-struct -Wno-nested-anon-types)
  endif()

  # Ignore Boost deprecated messages
  add_compile_definitions(BOOST_ALLOW_DEPRECATED_HEADERS)

  # Ignore unnecessary CMake warnings
  set(__dummy__ ${CMAKE_EXPORT_COMPILE_COMMANDS})

  # Set ROS_DISTRO macros
  set(ROS_DISTRO $ENV{ROS_DISTRO})
  if(${ROS_DISTRO} STREQUAL "rolling")
    add_compile_definitions(ROS_DISTRO_ROLLING)
  elseif(${ROS_DISTRO} STREQUAL "humble")
    add_compile_definitions(ROS_DISTRO_HUMBLE)
  elseif(${ROS_DISTRO} STREQUAL "jazzy")
    add_compile_definitions(ROS_DISTRO_JAZZY)
  endif()

  # Find dependencies
  find_package(ament_cmake_auto REQUIRED)
  ament_auto_find_build_dependencies()

  # Set common system includes
  include_directories(SYSTEM
    ${EIGEN3_INCLUDE_DIR}
  )

  # Find test dependencies
  if(BUILD_TESTING)
    find_package(ament_lint_auto REQUIRED)
    ament_lint_auto_find_test_dependencies()
  endif()
endmacro()
