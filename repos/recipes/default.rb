# TODO test using private key...

node[:repos].each do |repo|
  user = repo[:user]
  url = repo[:url]
  name = repo[:name] != nil ? repo[:name] : url.match(/.*\/(.*?)\.git/)[1]
  dir = repo[:dir] != nil ? repo[:dir] : name
  ssh_key = repo[:ssh_key]
  home = "/home/#{user}"
  wrapper = "#{home}/.ssh/#{name}_ssh_wrapper.sh"

  directory "#{home}/.ssh"

  if ssh_key != nil
    ssh_key_file = "#{home}/.ssh/#{name}_key_file"

    file ssh_key_file do
      content "#{ssh_key}"
    end

    # TODO use template
    file wrapper do
      content <<-EOF
      #!/bin/bash
      /usr/bin/env ssh -q -2 -o "StrictHostKeyChecking=no" -i "#{ssh_key_file}" $1 $2
      EOF
      owner user
      mode "700"
    end
  end

  git "update #{name}" do
    repository url
    revision repo[:branch] != nil ? repo[:branch] : "master"
    user user
    # group repo[:group] != nil ? repo[:group] : user
    destination "#{home}/#{dir}"
    if ssh_key != nil
      ssh_wrapper wrapper
    end
    # TODO use git clone w/ depth parameter (more efficient)
    action :sync
  end

  if ssh_key != nil
    file wrapper do
      action :delete
    end

    file ssh_key_file do
      action :delete
    end
  end
end
