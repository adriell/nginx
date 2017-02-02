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
	file {"$app_name.conf":
		ensure 	=> file,
		path 	=> "/etc/nginx/conf.d/$app_name.conf",
		mode	=> '0644',
		owner 	=> root,
		group 	=> root,
		content => template("nginx/app.conf.erb"),
		notify 	=> Service["nginx"],
	}
	file {"$app_name-ssl.conf":
                ensure  => file,
                path    => "/etc/nginx/conf.d/$app_name-ssl.conf",
                mode    => '0644',
                owner   => root,
                group   => root,
                content => template("nginx/appssl.conf.erb"),
                notify  => Service["nginx"],
        }
	file {"ssl":
                ensure  => directory,
                path    => "/etc/nginx/ssl",

        }

	file {"nginx.key":
                ensure  => file,
                path    => "/etc/nginx/ssl/nginx.key",
                mode    => '0644',
                owner   => root,
                group   => root,
		source 	=> "puppet:///modules/nginx/nginx.key"
         
        }
	   file {"nginx.crt":
                ensure  => file,
                path    => "/etc/nginx/ssl/nginx.crt",
                mode    => '0644',
                owner   => root,
                group   => root,
                source  => "puppet:///modules/nginx/nginx.crt"

        }

}
