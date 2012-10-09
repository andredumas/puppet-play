# Resource: play::stage
# Compiles and prepares a Play application to run in a production environment as a system service 
#
# Parameters:
# *path* :  mandatory, absolute path of the application.
#
# Sample Usage:
# See included tests for sample usage
#
define play::stage($path) {
  include play
  
  exec {"stage":
  	command => "$play::play_path/play clean compile stage",
  	cwd => "${path}",
  	user => "$play::user",
  	creates => "$path/target/start",
  	# Takes a really long to to compile on a micro EC2 instance, not sure why just yet
  	timeout => 1200	
  }
  
  file { "$path/target":
  	mode => 644,
  	recurse => true,
  	owner => "$play::apps_user",
  	group => "$play::apps_group",
  	require => Exec["stage"]
  }
  
  file { "$path/target/start":
  	mode => 744,
  	owner => "$play::apps_user",
  	group => "$play::apps_group",
  	require => [Exec["stage"], File["$path/target"]]
  }
}