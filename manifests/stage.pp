# Resource: play::stage
# Compiles and prepares a Play application to run in a production environment as a system service.
#
# Sample Usage:
# See included tests for sample usage
#
define play::stage {
	include play
  
	$path = "$play::apps_home/$title"
  
	exec {"stage":
		command => "$play::play_path/play clean compile stage",
		cwd => "$path",
		user => "$play::user",
		creates => "$path/target",
		# Takes a really long to to compile on a micro EC2 instance, not sure why just yet
		timeout => 1200	
	}
  
	# Want the target, project/project and project/target directories managed to not emit a 
	# refresh event if nothing else is different and to ensure user is correct after build
	file { "$path/target":
		recurse => true,
		owner => "$play::apps_user",
		group => "$play::apps_group",
		require => Exec["stage"]
	}
	file { "$path/project/project":
		recurse => true,
	  	owner => "$play::apps_user",
	  	group => "$play::apps_group",
	  	require => Exec["stage"]
	}	
	file { "$path/project/target":
		recurse => true,
	  	owner => "$play::apps_user",
	  	group => "$play::apps_group",
	  	require => Exec["stage"]
	}
	
	# Don't remove the log directory
	file { "$path/logs":
		ensure => link,
	  	owner => "$play::apps_user",
	  	group => "$play::apps_group",
		target => "/var/log/$title",
	  	require => File["/var/log/$title"],
	}
	
	file { "/var/log/$title":
		ensure => directory,
	  	owner => "$play::apps_user",
	  	group => "$play::apps_group",
	  	recurse => true,
	}
}