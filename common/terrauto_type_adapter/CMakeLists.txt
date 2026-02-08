cmake_minimum_required(VERSION 3.14)
project(terrauto_type_adapter)

set(type_adapter_library type_adapter)

# find dependencies
find_package(terrauto_cmake REQUIRED)
terrauto_package()

# create the library target
ament_auto_add_library(${type_adapter_library} SHARED
  src/pcl_type_adapter.cpp
)

ament_auto_package(
  USE_SCOPED_HEADER_INSTALL_DIR
)
