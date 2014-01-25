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

  execute "pkill #{lein_jar}"

  execute "lein uberjar" do
    cwd dir
  end

  # TODO delete code and only keep versions of uberjar
  execute "java -jar #{dir}/target/#{jar} &" do
    user prod
  end
end
