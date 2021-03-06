# ----------------------------------------------------------------------------
#  Copyright (c) 2018 WSO2, Inc. http://www.wso2.org
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.
# ----------------------------------------------------------------------------

# Class: ei_integrator
# Init class of EI Integrator default profile
class ei_integrator (
)

  inherits ei_integrator::params {

  # Copy configuration changes to the installed directory
  $template_list.each | String $template | {
    file { "$wso2_path/$product-$product_version/${template}":
      ensure  => file,
      mode    => '0644',
      content => template("${puppet_modules_path}/${module_name}/templates/carbon-home/${template}.erb")
    }
  }

  # Copy wso2server.sh to installed directory
    file { "$wso2_path/$product-$product_version/${start_script_template}":
    ensure  => file,
    mode    => '0754',
    content => template("${puppet_modules_path}/${module_name}/templates/carbon-home/${start_script_template}.erb")
  }

  # Copy mysql-connector-java-5.1.41-bin.jar to installed directory
  file { "$wso2_path/$product-$product_version/lib/${mysql_connector}":
    mode   => '0754',
    source => "puppet:///modules/ei_integrator/mysql-connector-java-5.1.41-bin.jar",
  }
}
