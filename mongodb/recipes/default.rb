require 'fileutils'
require 'pathname'

yum_file = "/etc/yum.repos.d/mongodb.repo"

repo_info = "[MongoDB]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64
gpgcheck=0
enabled=1"

ruby_block "append to a file" do
  Pathname.new(yum_file).parent.mkpath
  FileUtils.touch(yum_file)
  fe = Chef::Util::FileEdit.new(filename)
  fe.insert_line_if_no_match(repo_info, repo_info)
  fe.write_file
end

require('mongo-10gen-server')

["/var/lib/mongodb", "/var/log/mongodb/mongod.log"].each do |f|
  file f do
    owner "mongod"
    group "mongod"
    mode "600"
  end
end

service 'mongod' do
  action [:enable, :start]
end
