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
    # searching for something like:
    # -Dleiningen.original.pwd=...
    not_if { `ps aux | grep "lein.*#{dir}"`.split('\n').length > 1 }
  end
end
