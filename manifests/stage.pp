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
  
  file { "$path/target":
  	recurse => true,
  	owner => "$play::apps_user",
  	group => "$play::apps_group",
  	require => Exec["stage"]
  }
}