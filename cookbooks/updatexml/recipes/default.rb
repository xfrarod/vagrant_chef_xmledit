#
# Cookbook Name:: xmledit
# Recipe:: default
#
# Copyright 2014 Martin Smith
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

include_recipe 'xmledit'

#xml_edit 'set foo to true' do
#  path '/vagrant/myFile.xml'
#  target '/Employees/Employee/config/foo[text()=\'false\']'
#  fragment '<foo>true</foo>'
#  action :replace
#end

#xml_edit 'update cas-endpoint-configuration.xml' do
#  path '/vagrant/cas-endpoint-configuration.xml'
#  #target '/beans/camel:routeContext/camel:route [text()=\'<camel:from uri="file:///opt/srv/ServiceMix/routes/bloomberg-in"/>\']'
#  target '/beans/routeContext/route/foo [text()=\'false\']'
#  fragment '<foo>true</foo>'
#  #fragment '<camel:from uri="file:///vol1/srv/ServiceMix/routes/bloomberg-in"/>'
#  action :replace
#end

xml_edit 'update cas-endpoint-configuration.xml' do
  path '/vagrant/cas-endpoint-configuration.xml'
######### LA CHIDA  target '//beans//routeContext[attribute::id="Bloomberg-Input-Routes"]//route[attribute::id="bloomberg-inbound"]//from[attribute::uri="file:///opt/srv/ServiceMix/routes/bloomberg-in"]'
  target '/beans[attribute::xmlns:camel="http://camel.apache.org/schema/spring"]/routeContext[attribute::id="Bloomberg-Input-Routes"]/route[attribute::id="bloomberg-inbound"]/from[attribute::uri="file:///opt/srv/ServiceMix/routes/bloomberg-in"]'
  fragment '<from uri="file:///vol1/srv/ServiceMix/routes/bloomberg-in"/>'
  action :replace
end

#"/*[local-name() = 'beans'][1]/camel:routeContext[1]/camel:route[1]/camel:from[1]/@uri">uri="file:///opt/srv/ServiceMix/routes/accountIn"

#xml_edit '/vagrant/myFile.xml' do
#  edits [
#    {action: :replace, target: '/config/foo', fragment: '<foo>xyzzy</foo>'}
#,
#    {action: :append, parent: '/foo', target: '/foo/baz', fragment: '<baz>true</baz>'},
#    {action: :remove, target: '/foo/hideme'},
#    {action: :append_if_missing, parent: '/foo', target: '/foo/showme', fragment: '<showme/>'}
#    ]
#  action :bulk
#end
