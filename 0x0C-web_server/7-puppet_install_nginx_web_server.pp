# Install Nginx web server and configure requirements

exec { 'install_nginx':
  command     => 'apt-get -y update && apt-get -y install nginx',
  path        => '/usr/bin/apt-get update',
  refreshonly => true,
}

package { 'nginx':
	ensure => 'installed',
	require => Exec['update system']
}

file {'/var/www/html/index.html':
	content => 'Hello World!'
}

service {'nginx':
	ensure => running,
	require => Package['nginx']
}
