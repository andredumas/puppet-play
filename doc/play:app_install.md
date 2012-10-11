play::app_install
=================

Copies a play application from a source destination to the configured apps_home.

Actions
-------
Copies a play application from the source destination. Runs a _play clean_. Ensures the log directory is not overwritten.

Parameters
----------

* *source* :  mandatory, absolute path of the application.

Examples
--------

	play::app_install { "test-app":
		source => "/tmp/test-app"
	}
