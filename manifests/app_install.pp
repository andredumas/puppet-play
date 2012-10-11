# Resource: play::app_install
# Installs a Play application from $source location to the configured play apps_home.
#
# *source* :  mandatory, absolute path of the application.
#
# Sample Usage:
# See included tests for sample usage
#
define play::app_install($source) {
  	include play
  	
  	$path = "$play::apps_home/$title"

	file { "$path":
		ensure => directory,
		source => "$source",
	  	owner => "$play::apps_user",
	  	group => "$play::apps_group",
		links => follow,
		recurse => true,
		purge => true,
		force => true,
	}
	
	# Clean any artefacts in the case of a refres/reinstall
	exec {"clean":
		command => "$play::play_path/play clean",
	  	cwd => "$path",
	  	user => "$play::user",
	  	refreshonly => true,
	  	subscribe => File["$path"],
	}	
	
	# Don't remove the log directory
	file { "$path/logs":
		ensure => directory,
	  	owner => "$play::apps_user",
	  	group => "$play::apps_group",
	}	
}	