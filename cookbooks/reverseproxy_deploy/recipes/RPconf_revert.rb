# Cookbook Name:: reverseproxy_deploy
# Recipe:: RPconf_revert
# Copyright 2015, Accenture
# All rights reserved - Do Not Redistribute
# Manu was here!

temp_path = "#{['reverseproxy_deploy']['http']['tmp']}"
node['reverseproxy_deploy']['directories'].each do |directory,d|
  d['files'].each do |file|
    if File.exist?(temp_path + '#{file}') # Validate if file exists in extracted folder
      manage_conf '#{file}' do
        action 'revert'
        dir "#{directory}"
        temp "#{temp_path}"
      end
    else
      puts "No file to revert found #{temp_path}/#{file}"
    end
  end
end
