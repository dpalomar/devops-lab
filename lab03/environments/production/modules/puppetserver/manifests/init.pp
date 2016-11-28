# Class: puppetserver
# ===========================
#
# Full description of class puppetserver here.
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
#    class { 'puppetserver':
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
class puppetserver {

	package{['puppetserver','ruby-build','ruby-dev','git','links']:
	ensure => installed,
	before =>[ Exec['memory-change']],
	}

	exec{'memory-change':
		command => "sed -i 's/JAVA_ARGS=\"-Xms2g -Xmx2g -XX:MaxPermSize=256m\"/JAVA_ARGS=\"-Xms1g -Xmx1g -XX:MaxPermSize=256m\"/g' /etc/default/puppetserver",
		path => '/bin:/usr/bin:/usr/local/bin',
		require => Package['puppetserver'],
	}

	file{"/etc/puppetlabs/code/environments/production":
	ensure => link,
	force => true,
	target => '/vagrant/environments/production',
	notify =>[ Service["puppetserver"], Exec['install-modules']],
	require => Package['puppetserver'],
	}

	service{'puppetserver':
	ensure => 'running',
	}

	exec{'install-modules':
		command => 'puppet module install puppetlabs/apache && puppet module install puppetlabs/vcsrepo',
		path => '/opt/puppetlabs/bin',
	}
}
