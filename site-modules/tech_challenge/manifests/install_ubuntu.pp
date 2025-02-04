# @summary 
#
# This class installs jenkins on ubuntu hosts 20.04 only & changes the default port jenkins runs on.
#
# @example
#   include tech_challenge::install_ubuntu
class tech_challenge::install_ubuntu (
  Integer $port = 8011
) {
  exec { 'install':
    command => 'wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd     => '/etc/apt/sources.list.d',
    user    => 'root',
    creates => '/etc/apt/sources.list.d/jenkins.list',
    notify  => Exec['key'],
  }
  exec { 'key':
    command     => 'sudo sh -c "echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list"',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd         => '/etc/apt/sources.list.d',
    user        => 'root',
    refreshonly => true,
  }
  package { 'jenkins':
    ensure  => present,
  }
# Replace HTTP_PORT in /etc/default/jenkins
  file { '/etc/default/jenkins':
    ensure => present,
  }
  file_line { 'Append a line to /etc/default/jenkins':
    path               => '/etc/default/jenkins',
    line               => "HTTP_PORT=${port}",
    match              => '^HTTP_PORT.*$',
    append_on_no_match => false,
    notify             => Service['jenkins'],
  }
  Exec { 'jenkins':
    command     => '/usr/bin/systemctl restart jenkins',
    user        => 'root',
    subscribe   => File_line['Append a line to /etc/default/jenkins'],
    refreshonly => true,
  }
}
