prod = node[:prod]
prod_user = prod[:user] != nil ? prod[:user] : "prod"

user prod_user do
  supports :manage_home => true
  home "/home/#{prod_user}"
  shell prod[:shell] != nil ? prod[:shell] : "/bin/bash"
  group prod[:group] != nil ? prod[:group] :  prod_user
  action :create
end
