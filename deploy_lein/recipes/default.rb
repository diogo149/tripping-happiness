include_recipe 'deploy'

node[:deploy].each do |application, deploy|

  opsworks_deploy_dir do
    user deploy[:user]
    group deploy[:group]
    path deploy[:deploy_to]
  end

  opsworks_deploy do
    deploy_data deploy
    app application
  end

  jar = node[:lein_jar]
  dir = "#{deploy[:deploy_to]}/current"

  execute "pkill #{jar}" do
    not_if { `ps aux | grep #{jar}`.split('\n').length <= 1 }
  end

  execute "lein uberjar" do
    cwd dir
    # allows snapshots to be built into the jar
    environment 'LEIN_SNAPSHOTS_IN_RELEASE' => 'override'
  end

  # TODO delete code and only keep versions of uberjar
  execute "java -jar #{dir}/target/#{jar} &" do
    user "prod"
  end
end
