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
#
# References for this cookbook:
# https://supermarket.chef.io/cookbooks/xmledit
# http://www.nokogiri.org/tutorials/searching_a_xml_html_document.html
# http://www.rubydoc.info/github/sparklemotion/nokogiri/Nokogiri/XML/Node
# 

include_recipe 'xmledit'
require 'nokogiri'

######################################
###################################### TEST


fileName = "/vagrant/testfile.xml"
f = File.open(fileName)
myXmlDoc = Nokogiri::XML(f)
nodes = myXmlDoc.xpath("//camel:from | //camel:to | //camel:constant")

f.close

nodes.each do | node |
	
	nodeTxt = node.to_s
	nodeTxtTo = nodeTxt.gsub("file:///opt", "file:///vol1")
	
	if nodeTxt.include? "file:///"
		puts "######################{node.path}"
		
		puts "#### FROM:           #{nodeTxt}"
		puts "#### TO:             #{nodeTxtTo}"
		puts "#### CONTENT:        #{node.content}"
		puts "#### ATTR[URI]:      #{node["uri"]}"
		puts "#### TO_S:           #{node.to_s}"

		xml_edit "** Updating xmlDoc:#{fileName} | value:#{nodeTxt} | xpath:#{node.path}" do
			path fileName
			target node.path
			fragment nodeTxtTo
			action :replace
		end
		
	end	
end


## ************** cas-endpoint-configuration.xml **************
#
#fileName = "/vagrant/cas-endpoint-configuration.xml"
#f = File.open(fileName)
#myXmlDoc = Nokogiri::XML(f)
#nodes = myXmlDoc.xpath("//camel:from | //camel:to | //camel:constant")
#
#f.close
#
#nodes.each do | node |
#	
#	nodeTxt = "#{node}"
#	nodeTxtTo = nodeTxt.gsub("file:///opt", "file:///vol1")
#	
#	if nodeTxt.include? "file:///"
#		puts "######################{node.path}"
#		
#		puts "#### FROM:           #{nodeTxt}"
#		puts "#### TO:             #{nodeTxtTo}"
#		puts "#### CONTENT:        #{node.content}"
#		puts "#### ATTR[URI]:      #{node["uri"]}"
#		puts "#### FRAGMENT:       #{node.fragment('')}"
#
#		xml_edit "** Updating xmlDoc:#{fileName} | value:#{nodeTxt} | xpath:#{node.path}" do
#			path fileName
#			target "#{node.path}"
#			fragment "#{nodeTxtTo}"
#			action :replace
#		end
#		
#	end	
#end
#
#xml_edit 'update cas-endpoint-configuration.xml' do
#	path '/vagrant/cas-endpoint-configuration.xml'
#	target '//camel:routeContext[@id="Bloomberg-Input-Routes"]/camel:route[@id="bloomberg-inbound"]/camel:from[@uri="file:///opt/srv/ServiceMix/routes/bloomberg-in"]'
#	fragment '<camel:from uri="file:///vol1/srv/ServiceMix/routes/bloomberg-in"/>'
#	action :replace
#end
#
#
## ********************* cas-features.xml *********************
#
## Getting nodes from the file
#
#fileName = "/vagrant/cas-features.xml"
#f1 = File.open(fileName)
#myXmlDoc = Nokogiri::XML(f1)
#nodes = myXmlDoc.xpath("//feature/bundle")
#f1.close
#
## Updating each node
#
#nodes.each do | node |
#
#	nodeTxt = "#{node}"
#	nodeTxtTo = nodeTxt.gsub("file:///opt", "file:///vol1")
#
#	if nodeTxt.include? "file:///"
#		puts "######################{node.path}"
#		
#		puts "#### FROM:           #{nodeTxt}"
#		puts "#### TO:             #{nodeTxtTo}"
#		puts "#### CONTENT:        #{node.content}"
#		puts "#### ATTR[URI]:      #{node["uri"]}"
##		puts "#### FRAGMENT:       #{node.fragment('')}"
#
#		
#		xml_edit "** Updating xmlDoc:#{fileName} | value:#{nodeTxt} | xpath:#{node.path}" do
#			path fileName
#			target "#{node.path}"
#			fragment "#{nodeTxtTo}"
#			action :replace
#		end
#		
#	end
#end
#                                                               
## ********************* jboss-web.xml *********************
#                                                       
#xml_edit 'update jboss-web.xml' do
#  path '/vagrant/jboss-web.xml'
#  target '/jboss-web/context-root'
#  fragment '<context-root>MyNewContextRoot</context-root>'
#  action :replace
#end


#xml_edit '/vagrant/cas-features.xml' do
#  edits [
#    {action: :replace, target: '//feature/bundle', fragment: '<bundle>file:///vol1/srv/apache-servicemix/JBOSS/JBOSS_JMS.jar</bundle>'},
#    ]                                                              
#  action :bulk                                                     
#end  

#xml_edit 'update cas-endpoint-configuration.xml' do
#  path '/vagrant/cas-endpoint-configuration.xml'
#  target '//camel:routeContext[@id="Bloomberg-Input-Routes"]/camel:route[@id="bloomberg-inbound"]/camel:from[@uri="file:///opt/srv/ServiceMix/routes/bloomberg-in"]'
#  fragment '<camel:from uri="file:///vol1/srv/ServiceMix/routes/bloomberg-in"/>'
#  action :replace
#end
