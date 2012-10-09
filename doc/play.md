Play Class
==========

Actions:
--------
If not already installed, play 2.0.3 is downloaded and installed into _/opt/play-2.0.3_. 

Sample Usage:
-------------

	# Provision the default version of the Play Framework and application directory 
	class {"play":
		user => "root",
		group => "root",
		apps_user => "www-data",
		apps_group => "www-data",
	}
	
	# Prebuild and stage the application
	play::stage { "test-app":
		path => "/var/play/test-app",
	}
	
	# Provision two instances of the same application on two different ports for failover,
	# binding to all network interfaces.
	play::service { "test-app-9000":
		path => "/var/play/test-app",
		require => Class["Play"],
		port => "9000",
		address => "0.0.0.0",
	}
	
	play::service { "test-app-9001":
		path => "/var/play/test-app",
		require => Class["Play"],
		port => "9001",
		address => "0.0.0.0",
	}
