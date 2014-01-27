# TODO use template
mongo_conf = "
logpath=/log/mongod.log
logappend=true
fork = true
port = 27001
dbpath = /data
pidfilepath = /var/run/mongodb/mongod.pid
"

mongo_conf_path = "/home/prod/mongod.prod.conf"

file mongo_conf_path do
  content "#{mongo_conf}"
  owner "mongod"
  group "mongod"
  mode 444
end

execute "pkill #{mongo_conf_path}" do
  not_if { `ps aux | grep "#{mongo_conf_path}"`.split('\n').length <= 1 }
end

execute "mongod -f #{mongo_conf_path}" do
  user "mongod"
end
