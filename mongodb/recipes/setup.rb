require 'fileutils'
require 'pathname'

repo_info = "[MongoDB]
name=MongoDB Repository
baseurl=http://downloads-distro.mongodb.org/repo/redhat/os/x86_64
gpgcheck=0
enabled=1
"

file "/etc/yum.repos.d/mongodb.repo" do
  content "#{repo_info}"
end

package 'mongo-10gen-server'

[
 "/var/lib/mongodb",
 "/var/log/mongodb/",
 # "/data",
 # "/log",
 # "/journal",
].each do |d|
  directory d do
    owner "mongod"
    group "mongod"
    mode "600"
  end
end

# TODO don't start the service, leave to deploy step
# service 'mongod' do
#   action [:enable, :start]
# end
