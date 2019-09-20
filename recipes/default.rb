#
# Cookbook:: chef-rean-sample-spring-application
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

download_path = default['chef-rean-sample-spring-application']['download_path']
db_user = default['chef-rean-sample-spring-application']['db_user']
db_password = default['chef-rean-sample-spring-application']['db_password']
db_name = default['chef-rean-sample-spring-application']['db_name']
port = default['chef-rean-sample-spring-application']['port']
application_context = default['chef-rean-sample-spring-application']['application_context']
host = default['chef-rean-sample-spring-application']['host']

bash 'Install Sample Java Based Spring Application' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    wget #{download_path}
    nohup java -jar -DPORT=#{port} -DDB_NAME=#{db_name} -DDB_USER=#{db_user} -DDB_PWD=#{db_password} sampleapplication-2.0.0.jar &
    firewall-cmd --add-port=#{port}/tcp --permanent
    firewall-cmd --reload
    echo "http://#{host}:#{port}/#{application_context}"
    EOH
end