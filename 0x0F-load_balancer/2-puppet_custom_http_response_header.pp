# Automate adding a custom header with puppet

exec { 'update system':
  command => '/usr/bin/apt-get update',
}

package { 'nginx':
  ensure => 'installed',
  require => Exec['update system'],
}

file_line { 'install':
  ensure => 'present',
  path   => '/etc/nginx/sites-enabled/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me https://github.com permanent;',
  require => Package['nginx'],
}

file {'/var/www/html/index.html':
  content=> 'Hello World!'
}

# Add custom HTTP header 
file_line { 'add_custom_header':
  ensure => 'present',
  path   => '/etc/nginx/sites-enabled/default',
  line   => 'add_header X-Served-By $hostname;',
  match  => '^\\s*add_header X-Served-By.*$',
  after  => 'location / {',
  require => Package['nginx'],
}
service {'nginx':
  ensure  => running,
  enable  => true,
  require => Package['nginx'],
}
