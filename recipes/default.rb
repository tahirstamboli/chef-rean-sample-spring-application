#
# Cookbook:: chef-rean-sample-spring-application
# Recipe:: default
#
# Copyright:: 2019, The Authors, All Rights Reserved.

download_path = node['chef-rean-sample-spring-application']['download_path']
db_user = node['chef-rean-sample-spring-application']['db_user']
db_password = node['chef-rean-sample-spring-application']['db_password']
db_name = node['chef-rean-sample-spring-application']['db_name']
port = node['chef-rean-sample-spring-application']['port']
application_context = node['chef-rean-sample-spring-application']['application_context']
host = node['chef-rean-sample-spring-application']['host']
enable_firewall_port = node['chef-rean-sample-spring-application']['enable_firewall_port']

bash 'Install Sample Java Based Spring Application' do
    user 'root'
    cwd '/tmp'
    code <<-EOH
    wget #{download_path}
    nohup java -jar -DPORT=#{port} -DDB_NAME=#{db_name} -DDB_USER=#{db_user} -DDB_PWD=#{db_password} sampleapplication-2.0.0.jar &
    EOH
end

unless enable_firewall_port.empty?
    bash 'Open Firewall Port for Application' do
        user 'root'
        cwd '/tmp'
        code <<-EOH
        firewall-cmd --add-port=#{port}/tcp --permanent
        firewall-cmd --reload
        EOH
    end
end

puts "============================================="
puts "Sample Application URL :"
puts "http://#{host}:#{port}/#{application_context}"
puts "============================================="