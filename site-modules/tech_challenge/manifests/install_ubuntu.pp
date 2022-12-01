# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tech_challenge::install_ubuntu
class tech_challenge::install_ubuntu (
  String $port = 8011
) {
  exec { 'download':
    command => 'wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd     => '/etc/apt/sources.list.d',
    user    => 'root',
    creates => '/etc/apt/sources.list.d/jenkins.repo',
    notify  => Exec['extract'],
  }
  exec { 'extract':
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
  service { 'jenkins':
    ensure    => running,
    subscribe => File_line['Append a line to /etc/default/jenkins'],
  }
}
