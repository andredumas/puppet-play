# Resource: play::service
# Represents a Play application started as a service using an upstart script compatible with 
# Puppet service type.
#
# *path* :  mandatory, absolute path of the application.
# *javaOptions* : Java options passed to the application on startup
# *javaOptions* : Java options passed to the application on startup
# *address* : The address for the application to bind to
# *port* : The port for the aplication to gind to
#
# Sample Usage:
# See included tests for sample usage
#
define play::service($javaOptions = "", $address = "127.0.0.1", $port = "9000") {
	include play
	
	# Make play_home accessible from the template
	$play_home = $play::play_path
	$user = $play::apps_user
	$group = $play::apps_group
	$path = $play::apps_home/${title}
	
	notice("Service: ${title}")
	
	file { "/etc/init/$title.conf":
		content => template("play/play-upstart.erb"),
		mode    => "0644",
	}

	file { "/etc/init.d/$title":
		ensure => link,
		target => "/lib/init/upstart-job",
	}
}