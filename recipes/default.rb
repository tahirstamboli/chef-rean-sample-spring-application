#
# Cookbook:: chef-rean-sample-spring-application
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

download-path = default['chef-rean-sample-spring-application']['download-path']
db-user = default['chef-rean-sample-spring-application']['db-user']
db-password = default['chef-rean-sample-spring-application']['db-password']
db-name = default['chef-rean-sample-spring-application']['db-name']
port = default['chef-rean-sample-spring-application']['port']
application-context = default['chef-rean-sample-spring-application']['application-context']
host = default['chef-rean-sample-spring-application']['host']

bash 'Install Sample Java Based Spring Application' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    wget #{download-path}
    nohup java -jar -DPORT=#{port} -DDB_NAME=#{db-name} -DDB_USER=#{db-user} -DDB_PWD=#{db-password} sampleapplication-2.0.0.jar &
    firewall-cmd --add-port=#{port}/tcp --permanent
    firewall-cmd --reload
    echo "http://#{host}:#{port}/#{application-context}"
    EOH
end