Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class {"play":
	user => "root",
	group => "root",
	apps_user => "www-data",
	apps_group => "www-data",
}

play::stage { "test-app":
	path => "/var/play/test-app",
}