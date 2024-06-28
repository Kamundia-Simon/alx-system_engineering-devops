#install flask from pip3.

package { 'flask-lint':
  ensure   => '2.1.1',
  provider => 'gem',
}
