define play::stage($path, $user = "root") {
  include play
  
  $play_home = $play::play_path
  
  exec {"stage":
  	command => "$play_home/play clean compile stage",
  	cwd => "${path}",
  	user => "$user"
  }
}