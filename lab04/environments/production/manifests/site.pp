node /^puppet/{
	include puppetserver
  class { 'puppetdb': }
  # Configure the Puppet master to use puppetdb
   class { 'puppetdb::master::config':
   		  puppetdb_server => 'puppet',
		  puppetdb_port   => 8081,
    }
    class { 'apache': }
	class { 'apache::mod::wsgi': }
	# Configure Puppetboard
	# Access Puppetboard through pboard.example.com
	class { 'puppetboard':
	  # manage_git        => true,
	  # manage_virtualenv => true,
	}
	class { 'puppetboard::apache::vhost':
	 vhost_name => 'pboard.example.com',
	 port       => 80,
	}
}
node /^web/{
	include webserver
}