# Cookbook Name:: reverseproxy_deploy
# Recipe:: RPconf_deploy
# Copyright 2015, Accenture
# All rights reserved - Do Not Redistribute
# Manu was here!

temp_path = "#{['reverseproxy_deploy']['http']['tmp']}/config"

# Extract files from tar
execute 'extract files' do
  command 'tar -xvf proxy.tar'
  cwd "#{temp_path}/config"
end

# Do the deploy
Dir.foreach("#{temp_path}") do |directory|
  Dir.glob("#{temp_path}/#{directory}/*.conf") do |file|
    next if item == '.' || item == '..'
    manage_conf file do
      action 'deploy'
      dir "#{directory}"
      temp "#{temp_path}"
    end
  end
end

# restart service httpd
service 'httpd' do
  action :restart
end
