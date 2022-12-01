# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# parameter $port is a number
# @example
#   include tech_challenge::install_centos
class tech_challenge::install_centos (
  String $port = 8000,
) {
  exec { 'download':
    command => 'wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd     => '/etc/yum.repos.d',
    user    => 'root',
    creates => '/etc/yum.repos.d/jenkins.repo',
    notify  => Exec['extract'],
  }
  exec { 'extract':
    command     => 'rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd         => '/etc/yum.repos.d',
    user        => 'root',
    refreshonly => true,
  }
  package { 'jenkins':
    ensure => present,
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
