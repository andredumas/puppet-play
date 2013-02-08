Play Class
==========

Actions:
--------
If not already installed, play 2.1.0 is downloaded and installed into _/opt/play-2.1.0_. 

Parameters
----------

* *version* : the Play (2.x.x) version to install
* *download* : The location of the play release to download via wget
* *user* : the user that owns the Play installation
* *group* : the group that Play installation belongs to
* *apps_user* : the user that owns Play applications installed by this module
* *apps_group* : the group the Play applications installed by this module belong to
* *apps_home* : The location to install apps. Defaults to /var/play

Sample Usage:
-------------

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
