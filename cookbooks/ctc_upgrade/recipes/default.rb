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

#require 'ctc_val_version'
#include Chef::DeployTlmScripts::CtcValVersion


backup_dir='/vagrant/backup'
deploy_dir='/vagrant'

#cmd = Mixlib::ShellOut.new('cat #{deploy_dir}/ctc_version.txt | grep Version | sed \"s/^.*:\s/CT_/g\" | sed \"s/\s(.*-/_/g\" | sed \"s/)\s#/_/g\"')
#cmd.run_command
#cmd.error!

#current_ctc_version = `cat #{deploy_dir}/ctc_version.txt | grep Version | sed \"s/^.*:\s/CT_/g\" | sed \"s/\s(.*-/_/g\" | sed \"s/)\s#/_/g\"`

get_ctc_version = Mixlib::ShellOut.new("cat #{deploy_dir}/ctc_version.txt | grep Version \\
	| sed \"s/^.*:\s/CT_/g\" | sed \"s/\s(.*-/_/g\" | sed \"s/)\s#/_/g\"")
get_ctc_version.run_command

current_ctc_version = get_ctc_version.stdout

puts "Current CTC_Version: #{current_ctc_version}"

ctc_upgrade_ctc_val_version current_ctc_version do
	action :validate
	input_file 'sw_versions.txt'
	deploy_dir '/vagrant'
	ctc_install_dir '/opt/CT_temp/CT'
end