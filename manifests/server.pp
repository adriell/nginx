define nginx::server(
	$server_name = hiera('nginx::server::server_name'),
	$app_name = hiera('nginx::server::app_name'),
){
	package {"nginx":
		ensure => present,
	}

	service {"nginx":
		ensure => running,
		enable => true,
		require => Package["nginx"]
	}
	file {"$server_name.conf":
		ensure 	=> file,
		path 	=> "/etc/nginx/conf.d/$server_name.conf",
		mode	=> '0644',
		owner 	=> root,
		group 	=> root,
		content => template("nginx/app.conf.erb"),
		require => Service["nginx"],
		notify 	=> Service["nginx"],
	}
}
