node /^puppet/{
	include puppetserver
	# include puppetexplorer
	include myactivemq

}
node /^web/{
	include webserver


}