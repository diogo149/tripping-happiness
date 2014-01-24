# modeled after https://github.com/runa-labs/chef-leiningen

remote_file "/usr/local/bin/lein" do
  source "https://raw.github.com/technomancy/leiningen/stable/bin/lein"
  mode "755"
  owner "root"
  group "root"
  backup false
end
