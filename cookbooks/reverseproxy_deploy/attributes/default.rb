#
# Cookbook Name:: reverseproxy_deploy
#
# Copyright 2015, Accenture
#
# All rights reserved - Do Not Redistribute
#
##############################################################---RPconf_deploy
default['reverseproxy_deploy']['deploy_user'] = 'root'
default['reverseproxy_deploy']['deploy_group'] = 'root'
default['reverseproxy_deploy']['http']['conf'] = '/etc/httpd/conf'
default['reverseproxy_deploy']['http']['conf.d'] = '/etc/httpd/conf.d'
default['reverseproxy_deploy']['http']['tmp'] = '/var/tmp'
default['reverseproxy_deploy']['http']['files'] = ['http.conf', 'ssl.conf', 'aptp.conf']
#######################################################################
default['reverseproxy_deploy']['artefact_url'] = nil
default['reverseproxy_deploy']['nexus']['protocol'] = 'http'
default['reverseproxy_deploy']['nexus']['IP'] = '10.105.79.1'
default['reverseproxy_deploy']['nexus']['port'] = '8686'
default['reverseproxy_deploy']['directories'] = {
  '/etc/httpd/conf.d/' => ['ssl.conf', 'aptp.conf'],
  '/etc/httpd/conf/' => ['httpd.conf']
}

