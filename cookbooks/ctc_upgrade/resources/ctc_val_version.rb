#
# Cookbook Name:: deploy_tlm_scripts
# Resource: ctc_val_version.rb
#
# Copyright (c) 2015 Accenture, All Rights Reserved.

actions :validate
default_action :validate

attribute :version, kind_of: String, name_attribute: true
attribute :input_file, kind_of: String, name_attribute: true
attribute :deploy_dir, kind_of: String, required: true
attribute :ctc_user, kind_of: String, required: false
attribute :ctc_group, kind_of: String, required: false
attribute :ctc_install_dir, kind_of: String, required: false
attribute :ctc_config_file, kind_of: String, required: false
