play::stage
==============

Compiles and prepares a Play application to run in a production environment as a system service.

Actions
-------
Registers a Play application as a system service. 
This resource generates an upstart script to _/etc/init/app.conf_. It also generates a link
in _/etc/init.d/app_ for backwards compatibility

Parameters
----------

* *app_name* :  Defaults to the title. Specify a name if your title will be different to the apps directory
* *javaOptions* : Java options passed to the application on startup
* *javaOptions* : Java options passed to the application on startup
* *address* : The address for the application to bind to
* *port* : The port for the aplication to gind to

Examples
--------

	# Same service name as the app_name
	play::service { "test-app":
		app_name => "test-app",
		require => Class["Play"],
	}

	# Different service name to the app_name
	play::service { "test-app-9000":
		app_name => "test-app",
		require => Class["Play"],
	}
