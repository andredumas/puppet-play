play::service
==============

Resource representing a Play application started as a service.

Actions
-------
Registers a Play application as a system service. 
This resource generates an upstart script to _/etc/init/app.conf_. It also generates a link
in _/etc/init.d/app_ for backwards compatibility

Parameters
----------

* *path* :  mandatory, absolute path of the application.
* *javaOptions* : Java options passed to the application on startup
* *javaOptions* : Java options passed to the application on startup
* *address* : The address for the application to bind to
* *port* : The port for the aplication to gind to

Examples
--------

	play::service { "test-app-9000":
		path => "/var/play/test-app",
		require => Class["Play"],
	}
