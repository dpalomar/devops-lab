node /^puppet/{
	include puppetserver
	include activemq

}
node /^web/{
	include webserver

  # class { '::mcollective':
  #   middleware_hosts => [ 'puppet' ],
  # }

  # mcollective::plugin { ['puppet', 'service']:
  #   package => true,
  # }
}