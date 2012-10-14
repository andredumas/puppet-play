# Resource: play::git_app_install
# Installs a Play application from a git repository to the configured play apps_home.
#
# *repository* :  URL used to clone the repository
#
# Sample Usage:
# See included tests for sample usage
#
define play::git_app_install($repository) {
  	include play
  	
  	$path = "$play::apps_home/$title"
  	
  	package { "git":
  		ensure => latest
  	}
  	
  	# If location does not exist
  	exec { "git-clone":
  		command => "git clone $repository $path",
  		creates => "$path",
  		require => Package["git"]
  	}

  	exec { "git-reset":
  		command => "git reset --hard HEAD",
  		require => Exec["git-clone"],
  		require => Package["git"]
  	}
  	
  	exec { "git-pull":
  		command => "git pull",
  		require => Exec["git-reset"],
  		require => Package["git"]
  	}

	file { "$path":
		ensure => directory,
	  	owner => "$play::apps_user",
	  	group => "$play::apps_group",
	  	require => [
	  			Exec["git-clone"],
	  			Exec["git-reset"],
	  			Exec["git-pull"],
	  		]
	}
	
	# Don't remove the log directory
	file { "$path/logs":
		ensure => link,
		target => /var/log/$title,
	  	require => File["/var/log/$title"],
	}
	
	# Don't remove the log directory
	file { "/var/log/$title":
		ensure => directory,
	  	owner => "$play::apps_user",
	  	group => "$play::apps_group",
	  	recurse => true,
	}
}	