// Copyright 2026 Yuma Matsumura All rights reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//     http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

#include "{{PACKAGE_NAME}}/{{NODE_NAME}}_component.hpp"

#include <memory>

namespace {{PACKAGE_NAME}}
{

{{CLASS_NAME}}::{{CLASS_NAME}}(const rclcpp::NodeOptions & options) : Node("{{NODE_NAME}}_node", options)
{
}

{{CLASS_NAME}}::~{{CLASS_NAME}}()
{
}

}  // namespace {{PACKAGE_NAME}}

#include <rclcpp_components/register_node_macro.hpp>
RCLCPP_COMPONENTS_REGISTER_NODE({{PACKAGE_NAME}}::{{CLASS_NAME}})
