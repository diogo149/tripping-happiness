node[:lein_run].each do |instruction|
  username = instruction[:user]
  dir = instruction[:dir]
  if !dir.start_with?('/')
    dir = "/home/#{username}/#{dir}"
  end
  execute "lein_run: #{dir}" do
    cwd dir
    command "lein run &"
    user username
    # doesn't run if java is already running
    not_if { `ps aux | grep java`.split('\n').length > 1 }
  end
end
