define play::stage($path, $playUser = "root", $user = "root", $group = "root") {
  include play
  
  $play_home = $play::play_path
  
  exec {"stage":
  	command => "$play_home/play clean compile stage",
  	cwd => "${path}",
  	user => "$playUser"
  }
  
  file { "$path/target":
  	mode => 644,
  	recurse => true,
  	owner => $user,
  	group => $group,
  	require => Exec["stage"]
  }
  
  file { "$path/target/start":
  	mode => 744,
  	owner => $user,
  	group => $group,
  	require => [Exec["stage"], File["$path"]]
  }
}