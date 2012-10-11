Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class {"play":
	apps_user => "www-data",
	apps_group => "www-data",
}

play::app_install { "test-app":
	source => "/tmp/test-app"
}