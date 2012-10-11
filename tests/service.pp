Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

class {"play":
	user => "root",
	group => "root",
	apps_user => "www-data",
	apps_group => "www-data",
}

play::service { "test-app-9000":
	app_name => "test-app",
	require => Class["Play"],
	port => "9000",
	address => "0.0.0.0",
}

play::service { "test-app-9001":
	app_name => "test-app",
	require => Class["Play"],
	port => "9001",
	address => "0.0.0.0",
}