# Cookbook Name:: reverseproxy_deploy
# Recipe:: RPconf_backup
# Copyright 2015, Accenture
# All rights reserved - Do Not Redistribute
# Manu was here!
node['reverseproxy_deploy']['directories'].each do |directory,d|
  d.each do |file|
    if File.exist?(directory.to_s + file.to_s)
      manage_conf 'Backup all' do
        action 'backup'
        directory directory.to_s
        file file.to_s
      end
    else
      puts "No file to revert found #{d}/#{file}"
    end
  end
end
