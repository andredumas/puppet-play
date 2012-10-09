name    'andredumas-play'
version '1.0.0'
source 'akquinet'
author 'Andre Dumas'
license 'Apache Software License 2.0'
summary 'Puppet resources to provision Play! applications and modules'
description "Provision play framework and define applications.

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
"

## Add dependencies, if any:
# dependency 'username/name', '>= 1.2.0'
