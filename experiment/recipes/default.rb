
filename = ENV['HOME'] + "/Test"

require 'fileutils'
FileUtils.touch(filename)

bash 'test' do
  code <<-EOM
  # touch #{filename}
  EOM
end

file filename do
  content "#{filename}\n"
end

ruby_block "append to a file" do
  block do
    fe = Chef::Util::FileEdit.new(filename)
    fe.insert_line_if_no_match(/test/, "doo") # gets written
    fe.insert_line_if_no_match("Test", "doo") # doesn't
    fe.write_file
  end
end

bash '...' do
  code <<-EOM
  cat #{filename}
  rm #{filename} #{filename}.old
  EOM
end

package 'python'

# # --- Install packages we need ---
# package 'ntp'
# package 'sysstat'
# package 'apache2'

# # --- Add the data partition ---
# directory '/mnt/data_joliss'

# mount '/mnt/data_joliss' do
#   action [:mount, :enable]  # mount and add to fstab
#   device 'data_joliss'
#   device_type :label
#   options 'noatime,errors=remount-ro'
# end

# # --- Set host name ---
# # Note how this is plain Ruby code, so we can define variables to
# # DRY up our code:
# hostname = 'opinionatedprogrammer.com'

# file '/etc/hostname' do
#   content "#{hostname}\n"
# end

# service 'hostname' do
#   action :restart
# end

# file '/etc/hosts' do
#   content "127.0.0.1 localhost #{hostname}\n"
# end

# # --- Deploy a configuration file ---
# # For longer files, when using 'content "..."' becomes too
# # cumbersome, we can resort to deploying separate files:
# cookbook_file '/etc/apache2/apache2.conf'
# # This will copy cookbooks/op/files/default/apache2.conf (which
# # you'll have to create yourself) into place. Whenever you edit
# # that file, simply run "./deploy.sh" to copy it to the server.

# service 'apache2' do
#   action :restart
# end


# remote_file "/usr/local/bin/lein" do
#   source "https://raw.github.com/technomancy/leiningen/5eaad5c48db0668d773e6e964bdb64c30116c370/bin/lein"
#   mode "755"
#   owner "root"
#   group "root"
#   backup false
# end

# execute "install_leiningen" do
#   command "export HTTP_CLIENT='curl --insecure -f -L -o'; lein version"
#   user node[:lein][:user]
#   group node[:lein][:group]
#   environment ({"HOME" => node[:lein][:home]})
# end

package 'vim'

ruby_block "test" do
  block do
    print("hello world")
    print(node[:foo][:bar])
  end
end

# git ENV['HOME'] + "/test" do
#   repository "git://github.com/diogo149/tripping-happiness.git"
#   revision "master"
#   action :sync
#   user ENV['USER']
#   group "wheel"
# end

# user "testu" do
#   supports :manage_home => true
#   home "/home/testu"
#   shell "/bin/bash"
#   group "wheel"
#   action :create
# end
