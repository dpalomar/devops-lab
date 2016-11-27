stage { 'last': }
Stage['main'] -> Stage['last']

node /^puppet/{
	class{'puppetserver':
		stage => 'main',
	}
	class{'webserver':
		stage          => 'last',
		web_directory  => '/var/www/git',
		git_repository => 'https://github.com/dpalomar/simple-example.git',
		# virtual_host   => 'git.example.com',
	}
}