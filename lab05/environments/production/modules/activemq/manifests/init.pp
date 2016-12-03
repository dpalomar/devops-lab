# Class: activemq
# ===========================
#
# Full description of class activemq here.
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
#    class { 'activemq':
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
class activemq {

notify{'instalando/configurando activemq':}
package { 'activemq':
    ensure => latest,
    before => Service[ "activemq" ]
  }
  service { 'activemq':
    ensure => running,
    enable => true
  }
  file { '/etc/activemq/instances-available/main/activemq.xml':
    ensure => present,
    source => 'puppet:///modules/activemq/activemq.xml',
    owner  => 'activemq',
    group  => 'activemq',
    mode   => '0640',
    notify => Service['activemq']
  }
  	file{"/etc/activemq/instances-enabled/main":
	ensure => link,
	force => true,
	target => '/etc/activemq/instances-available/main',
	notify =>Service["activemq"],
	require => Package['activemq'],
	}
	file{"/var/lib/activemq/data":
		ensure => directory,
	    owner  => 'activemq',
	    group  => 'activemq',
	    mode   => '0755',
	    notify => Service['activemq']

	}
}

