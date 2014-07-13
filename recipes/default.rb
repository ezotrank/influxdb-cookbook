#
# Cookbook Name:: influxdb
# Recipe:: default
#
# Copyright 2014, Maxim Kremenev
#
# All rights reserved - Do Not Redistribute
#


remote_file "#{Chef::Config[:file_cache_path]}/influxdb.rpm" do
  source node['influxdb']['version']
  action :create
end

rpm_package "influxdb" do
  source "#{Chef::Config[:file_cache_path]}/influxdb.rpm"
  action :install, :upgdate
  not_if "influxdb -v|grep 'InfluxDB v#{node['influxdb']['version']}'"
end

service "influxdb" do
  action :start, :enable
end