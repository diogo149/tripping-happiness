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


  print("\n\n", node, "\n\n")
  # "#{deploy[:deploy_to]}/shared"
  # ruby_block
end
