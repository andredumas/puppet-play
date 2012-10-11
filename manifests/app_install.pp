define play::app_install($source) {
  	include play
  	
  	$app_home = $play::apps_home/${title} 

	file { "${app_home}":
		ensure => directory,
		source => "$source",
	  	owner => "$play::apps_user",
	  	group => "$play::apps_group",
		links => follow,
		recurse => true,
		purge => true,
		force => true,
	}
	
	# Don't remove the log directory
	file { "${app_home}/log":
		ensure => directory,
	  	owner => "$play::apps_user",
	  	group => "$play::apps_group",
	}	
}	