#
# Cookbook Name:: reverseproxy_deploy
# Recipe:: ReverseProxyServer
#
# Copyright 2015, Accenture
#
# All rights reserved - Do Not Redistribute
#
# Manu was here!

define :manage_conf do
  if params[:action] == 'backup'
    temp_path = '/var/tmp/'
    ruby_block 'backup files' do
      block do
        # Validate if file has different content
        #unless FileUtils.compare_file(temp_path + params[:file], params[:directory] + params[:file])
          FileUtils.cp params[:directory] + params[:file], "#{temp_path}"
        #end
      end
    end

  elsif params[:action] == 'deploy'

    if File.exist?("#{directory}" + "#{file}") # Validate if file exists in server path
      unless FileUtils.compare_file(params[:name] + "#{file}", "#{directory}" + "#{file}") # Validate if file has different content
        FileUtils.cp params[:name] + "#{file}", "#{directory}"
      end
    else
      FileUtils.cp params[:name] + "#{file}", "#{directory}"
    end

  elsif params[:action] == 'revert'

    temp_path = params[:temp]
    ruby_block 'revert files' do
      block do
        # Validate if file has different content
        unless FileUtils.compare_file(temp_path + params[:name], params[:dir] + params[:name])
          FileUtils.cp temp_path + params[:name], params[:dir]
        end
      end
    end
  end
end
