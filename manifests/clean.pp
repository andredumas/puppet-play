# Resource: play::clean
# Cleans the application name $title
#
# Sample Usage:
# See included tests for sample usage
#
define play::clean {
  	include play
  	
  	$path = "$play::apps_home/$title"

	# Clean any artefacts in the case of a refresh/reinstall
	exec {"clean":
		command => "$play::play_path/play clean",
	  	cwd => "$path",
	  	user => "$play::user",
	  	refreshonly => true,
	}	
}	