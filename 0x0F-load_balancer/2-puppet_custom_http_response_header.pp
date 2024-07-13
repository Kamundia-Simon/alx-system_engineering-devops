# Automate adding a custom header with puppet

package { 'nginx':
  ensure => 'installed',
}

file_line { 'install':
  ensure => 'present',
  path   => '/etc/nginx/sites-enabled/default',
  after  => 'listen 80 default_server;',
  line   => 'rewrite ^/redirect_me https://github.com permanent;',
}

file {'/var/www/html/index.html':
  content=> 'Hello World!'
}

# Add custom HTTP header to the Nginx configuration
exec { 'HTTP header':
  command  => 'sed -i "25i\\       add_header X-Served-By \\$HOSTNAME;" /etc/nginx/sites-available/default',
  provider => 'shell',
  require  => Package['nginx'],
}
service {'nginx':
  ensure  => running,
  require => Package['nginx'],
}
