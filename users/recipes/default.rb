default_shell = "/bin/bash"

[
 ["prod"],
 ["mongod"],
].each do |user, group, shell|
  if group == nil
    group = user
  end
  if shell == nil
    shell = default_shell
  end

  group group

  user user do
    supports :manage_home => true
    home "/home/#{user}"
    shell shell
    group group
    action :create
  end
end
