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

include_recipe 'xml::ruby'

xml_edit 'set foo to true' do
  path '/vagrant/myFile.xml'
  target '/Employees/Employee/config/foo[text()=\'false\']'
  fragment '<foo>true</foo>'
  action :replace
end

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
