Exec { path => [ "/bin/", "/sbin/" , "/usr/bin/", "/usr/sbin/" ] }

include play

play::service { "test-app":
	path => "/var/play/test-app",
	user => "www-data",
	group => "www-data",
	require => Class["Play"],
}