# Class: play
#
# This module manages play framework applications and modules.
# The class itself installs Play 2.1.0 in /opt/play-2.1.0. It also
# prepares a directory for play applications /var/play
#
# Actions:
#  play::service Registers a Play application as a service
#
# Parameters:
# *version* : the Play (2.x.x) version to install
# *download* : The location of the play release to download via wget
# *user* : the user that owns the Play installation
# *group* : the group that Play installation belongs to
# *apps_user* : the user that owns Play applications installed by this module
# *apps_group* : the group the Play applications installed by this module belong to
# *apps_home* : The location to install apps. Defaults to /var/play
#
# Sample Usage:
# See included tests for sample usage
#
class play ($version = "2.1.0", $download = "http://downloads.typesafe.com/play/2.1.0/play-2.1.0.zip", $user = "root", $group = "root", $apps_user = "root", $apps_group = "root", $apps_home = "/var/play") {
	
	$play_version = $version
	$play_path = "/opt/play-$play_version"
	
	notice("Play $play_version")
	
	exec { "download-play-framework":                                                                                                                     
        command => "wget $download",                                                         
        cwd     => "/tmp",
        creates => "/tmp/play-$play_version.zip",
		require => Package["wget"]
    }

	exec {"unzip-play-framework":
	    cwd     => "/opt",
        command => "unzip /tmp/play-$play_version.zip",
		creates => "$play_path",
        require => [ Package["unzip"], Exec["download-play-framework"] ],
	}

	file { "$play_path":
		ensure  => directory,
	    owner   => "$user",
	    group   => "$group",
	    mode    => "0644",
		subscribe => Exec["unzip-play-framework"]	    
	}	
	
	file { "$play_path/play":
		ensure  => file,
	    owner   => "$user",
	    mode    => "0755",
		require => File ["$play_path"]
	}
	
	file { "$apps_home":
		ensure => directory,
	    owner   => "$apps_user",
	    group   => "$apps_group",
	}
	
	package { "unzip":
		ensure => installed
	}
	
	package { "wget":
		ensure => installed
	}	
}
