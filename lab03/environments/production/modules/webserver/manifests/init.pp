# Class: webserver
# ===========================
#
# Full description of class webserver here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'webserver':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2016 Your name here, unless otherwise noted.
#
class webserver(
    $web_directory,
    $virtual_host = '',
    $git_repository = ''
    ){

	notify{'aprovisionando un servidor web':}

	include apache
	package{['git','links']: ensure => installed,}
	
	file{$web_directory:
	ensure => directory,
		owner => 'www-data',
		group => 'www-data',
	}

	apache::vhost{$virtual_host:
		port    => '80',
		docroot => $web_directory,
		require => File[$web_directory],

	}

	vcsrepo{$web_directory:
	ensure => present,
		provider => git,
		source   => $git_repository,
		require  => File[$web_directory],

	}

	host{$virtual_host:
		ip => '127.0.0.1',
	}
}
