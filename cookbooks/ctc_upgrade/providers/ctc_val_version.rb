#
# Cookbook Name:: deploy_tlm_scripts
# Provider: ctc_val_version.rb
#
# Copyright (c) 2015 Accenture, All Rights Reserved.

###########
# variables
###########

###########
# actions
###########
# --- validate CTC version ---
# loop through the input_file and search the CTC version to be upgraded

action :validate do

  ctc_current_version = "#{@current_resource.version.chomp!}"

  puts "The CTC_VAL_VERSION is: #{@current_resource.version}"
  puts "The INPUT_FILE is: #{@current_resource.input_file}"
  puts "The DEPLOY_DIR is: #{@current_resource.deploy_dir}"
  puts "The CTC_INSTALL_DIR is: #{@current_resource.ctc_install_dir}"


  filelist = ::File.open("#{@current_resource.deploy_dir}/#{@current_resource.input_file}").to_enum

  # Loop over the input file, line by line
  loop do
    line = filelist.next
    # For each line: remove backslashes, and newline at EOL, skip if the line is empty, then check the file exists (break if not?)
    #line.gsub!('\\', '/')
    
    
    ctc_file_version = "#{line.chomp!}"

    #next unless line.empty?

#    puts line

    next unless ctc_file_version.start_with?('CT_')

    if @current_resource.version.eql?(ctc_file_version)
        puts "Same Version: #{ctc_file_version}"
    else
    	puts "Different versions (#{ctc_current_version} vs. #{ctc_file_version}), doing upgrade..."
    end
    

#    # Check the file exists, or is visible
#    unless ::File.file?("#{@current_resource.deploy_dir}/#{line}")
#      ::Chef::Application.fatal!("ERROR: File '#{@current_resource.deploy_dir}/#{line}' not found!")
#    end
#
#    # Split up the line into two vars - one for relative path to the file, and one for file name.
#    # chdir to the dir, or error if not found ( hitting this error would suggest bad splitting, as we've already proven the file exists before splitting)
#    subdir = ::File.dirname('#{line}')
#    filename = ::File.basename('#{line}')
#    file_type = ::File.extname('#{line}')
#
#    ::Chef::Application.fatal!("ERROR: Directory '#{@current_resource.deploy_dir}/#{subdir}' not found!") unless ::File.directory?("#{@current_resource.deploy_dir}/#{subdir}")
#
#    ::Dir.chdir "#{@current_resource.deploy_dir}/#{subdir}"
#
#    ::Chef::Log.info "Running #{@current_resource.deploy_dir}/#{subdir}/#{filename} against #{@current_resource.db_name}"
#
#    # Based on the file type, run the relevant command to import the file
#    # If it's not possible to figure out WHAT to run, error out ungracefully
#    case file_type
#    when '.sql'
#      oracle_deployment('#{filename}', '#{subdir}')
#      oracle_deployment_error_handling('#{filename}', '#{subdir}')
#    when '.cte'
#      cte_error_handling('#{filename}', '#{subdir}')
#    else
#      ::Chef::Application.fatal!('ERROR: the file type is either undefined, does not match a known deployable tlm file type,String') unless File.directory?("#{@current_resource.deploy_dir}/#{subdir}")
#    end
#
#    ::Chef::Log.info "Successfully ran #{@current_resource.deploy_dir}/#{subdir}/#{filename} against DB #{@current_resource.db_name}"
  end
  new_resource.updated_by_last_action(true)
end

###########
# functions
###########
def load_current_resource
  @current_resource = Chef::Resource::CtcUpgradeCtcValVersion.new(new_resource.name)
  @current_resource.version(new_resource.version)
  @current_resource.input_file(new_resource.input_file)
  @current_resource.deploy_dir(new_resource.deploy_dir)
  @current_resource.ctc_install_dir(new_resource.ctc_install_dir)
end
#
#def load_current_resource_two
#  @current_resource.input_file(new_resource.input_file)
#  @current_resource.deploy_dir(new_resource.deploy_dir)
#  @current_resource.db_host(new_resource.db_host)
#  @current_resource.db_port(new_resource.db_port)
#end
#
#def load_current_resource_three
#  @current_resource.db_name(new_resource.db_name)
#  @current_resource.db_user(new_resource.db_user)
#  @current_resource.db_pass(new_resource.db_pass)
#  @current_resource.ctc_db_connection_type(new_resource.db_connection_type)
#  @current_resource.ctc_db_driver(new_resource.db_driver)
#end
#
#def load_current_resource_four
#  @current_resource.ctc_user(new_resource.ctc_user)
#  @current_resource.ctc_group(new_resource.ctc_group)
#  @current_resource.ctc_install_dir(new_resource.ctc_install_dir)
#  @current_resource.ctc_config_file(new_resource.ctc_config_file)
#end
#
## --- cte_deployment ---
## Contains logic and handling for cte file imports
#template "#{@current_resource.ctc_install_dir}/#{@current_resource.ctc_config_file}" do
#  source "#{node['deploy_tlm_scripts']['ctc_config_file']}.erb"
#  owner '#{@current_resource.ctc_user}'
#  group '#{@current_resource.ctc_group}'
#  mode '0775'
#  cookbook 'deploy_tlm_scripts'
#  variables(database_user: '#{@current_resource.db_user}',
#            database_password: '#{@current_resource.db_pass}',
#            database_url: "#{@current_resource.ctc_db_connection_type}:@#{@current_resource.db_host}:#{@current_resource.db_port}:#{@current_resource.db_name}",
#            database_driver: '#{@current_resource.ctc_db_driver}',
#            execution: 'import'
#           )
#end
#
#def cte_error_handling(filename = '', subdir = '')
#  ::Chef::Log.debug "Command used: cd #{@current_resource.ctc_install_dir} && ./CTC -c#{@current_resource.ctc_config_file} -i #{@current_resource.deploy_dir}/#{subdir}/#{filename}"
#  cmd = Mixlib::ShellOut.new("cd #{@current_resource.ctc_install_dir} && ./CTC -c#{@current_resource.ctc_config_file} -i #{@current_resource.deploy_dir}/#{subdir}/#{filename}")
#  cmd.run_command
#  cmd.error!
#end
#
## --- oracle_deployment ---
## Contains logic and handling for oracle deployment
#
#CMD = 'Command used: echo '
#PROFILE = '. /etc/profile.d/sqlplus.sh; echo exit | sqlplus'
#
#def oracle_deployment(*)
#  ::Chef::Log.debug CMD "exit | sqlplus #{@current_resource.db_user}/#{@current_resource.db_pass}@#{@current_resource.db_host}:#{@current_resource.db_port}/#{@current_resource.db_name} @#{filename}"
#end
#
#def oracle_deployment_error_handling(filename = '')
#  cmd = Mixlib::ShellOut.new(" #{@current_resource.db_user}/#{@current_resource.db_pass}@#{@current_resource.db_host}:#{@current_resource.db_port}/#{@current_resource.db_name} <<EOF
#    WHENEVER SQLERROR EXIT 1
#    @#{filename}
#    EOF")
#  cmd.run_command
#  cmd.error!
#end
