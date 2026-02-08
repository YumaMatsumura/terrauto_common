cmake_minimum_required(VERSION 3.14)
project(terrauto_lint_common NONE)

find_package(ament_cmake_core REQUIRED)
find_package(ament_cmake_export_dependencies REQUIRED)
find_package(ament_cmake_test REQUIRED)

add_definitions(${PCL_DEFINITIONS})

ament_package_xml()
ament_export_dependencies(${${PROJECT_NAME}_EXEC_DEPENDS})
ament_package()
