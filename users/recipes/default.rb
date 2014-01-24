prod = node[:prod] != nil ? node[:prod] : {}
prod_user = prod[:user] != nil ? prod[:user] : "prod"
prod_group = prod[:group] != nil ? prod[:group] :  prod_user

group prod_group

user prod_user do
  supports :manage_home => true
  home "/home/#{prod_user}"
  shell prod[:shell] != nil ? prod[:shell] : "/bin/bash"
  group prod_group
  action :create
end
