Puppet Module For Play 2.0.x
============================

This module provisions the Play Framework, Play applications. It supports:

* The provisioning of Play Framework in _/opt/play-version_
* The configuration of system services to run play applications
* Stage build of a play application

Using the module
----------------
To use the module, clone this repository to _/etc/puppet/modules_ (or configure your _modulepath_)

Example
-------

	# Provision the default version of the Play Framework and application directory 
	class {"play":
		user => "root",
		group => "root",
		apps_user => "www-data",
		apps_group => "www-data",
	}
	
	# Install the application
	play::app_install { "test-app":
		source => "/tmp/test-app"
	}
	
	# Prebuild and stage the application
	play::stage { "test-app": }
	
	# Provision two instances of the same application on two different ports for failover,
	# binding to all network interfaces.
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


License
-------

This module is licensed under the Apache Software License 2.0.