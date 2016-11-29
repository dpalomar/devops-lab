node /^puppet/{
	include puppetserver
	class { 'puppetdb': 
		listen_address => "0.0.0.0",
	}
 #  # Configure the Puppet master to use puppetdb
  class { 'puppetdb::master::config':
	puppetdb_server => 'puppet',

   }
    class { 'apache': }
    class { 'apache::mod::wsgi': }
    # Configure Puppetboard
    class { 'puppetboard':
      manage_git        => true,
      manage_virtualenv => true,
    }
    # Access Puppetboard through pboard.example.com
    class { 'puppetboard::apache::vhost':
     vhost_name => 'pboard.example.com',
     port       => 80,
    }
}
node /^web/{
	include webserver
}