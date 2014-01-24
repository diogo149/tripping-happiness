root = File.absolute_path(File.dirname(__FILE__))

cookbook_path root
file_cache_path "/tmp/chef-solo"
log_level ENV['CHEF_LOG_LEVEL'] && ENV['CHEF_LOG_LEVEL'].downcase.to_sym || :info
log_location ENV['CHEF_LOG_LOCATION'] || STDOUT
# ssl_verify_mode :verify_none
