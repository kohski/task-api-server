server '3.113.101.19', user: 'app', roles: %w{app db web}
set :ssh_options, keys: '/Users/kosukekimura/.ssh/id_rsa'