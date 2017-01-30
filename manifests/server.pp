define nginx::server(
	$server_name = hiera('nginx::server::server_name'),
	$app_name = hiera('nginx::server::app_name'),
){
	
	package {"nginx":
		ensure => present,
	}
	package {"nginx-extras":
		ensure => present,
	}
	package {"passenger":
		ensure => present,
	}

	service {"nginx":
		ensure => running,
		enable => true,
		require => Package["nginx"]
	}
	file {"$app_name.conf":
		ensure 	=> file,
		path 	=> "/etc/nginx/conf.d/$app_name.conf",
		mode	=> '0644',
		owner 	=> root,
		group 	=> root,
		content => template("nginx/app.conf.erb"),
		notify 	=> Service["nginx"],
	}
}
