# Cookbook Name:: reverseproxy_deploy
# Recipe:: ReverseProxyServer
# Copyright 2015, Accenture
# All rights reserved - Do Not Redistribute
# Manu was here!

File.open("#{node['reverseproxy_deploy']['http']['tmp']}/conf.d/validate.txt", 'r') do |file_handle|
  file_handle.each_line do |validate_url|
    http_request 'what up' do
      message ''
      url validate_url
      action :head
    end
  end
end
