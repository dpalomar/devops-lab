stage { 'last': }
Stage['main'] -> Stage['last']

node /^puppet/{
	class{'puppetserver':
		stage => 'main',
	}
	class{'webserver':
		stage => 'last',
	}
}