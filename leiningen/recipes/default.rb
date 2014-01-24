# modeled after https://github.com/runa-labs/chef-leiningen

package 'java-1.7.0-openjdk-devel'

remote_file "/usr/local/bin/lein" do
  source "https://raw.github.com/technomancy/leiningen/stable/bin/lein"
  mode "755"
  owner "root"
  group "root"
  backup false
end
