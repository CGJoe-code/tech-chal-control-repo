# @summary 
#
# This class installs jenkins on centos 7 machines & changes the default port
# parameter $port is a integer
# @example
#   include tech_challenge::install_centos
class tech_challenge::install_centos (
  Integer $port = 8000,
) {
  exec { 'install jdk':
    command => 'yum install -y java-11-openjdk-devel',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd     => '/etc/yum.repos.d',
    user    => 'root',
    #creates => '/etc/yum.repos.d/jenkins.repo',
    notify  => Exec['stable jenkins repo'],
  }

  exec { 'stable jenkins repo':
    command => 'curl --silent --location http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo | sudo tee /etc/yum.repos.d/jenkins.repo',
    path    => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd     => '/etc/yum.repos.d',
    user    => 'root',
    creates => '/etc/yum.repos.d/jenkins.repo',
    notify  => Exec['key'],
  }
  exec { 'key':
    command     => 'rpm --import http://pkg.jenkins-ci.org/redhat-stable/jenkins-ci.org.key',
    path        => '/usr/bin:/usr/sbin:/bin:/usr/local/bin',
    cwd         => '/etc/yum.repos.d',
    user        => 'root',
    refreshonly => true,
  }
  package { 'jenkins':
    ensure => present,
  }
# Replace HTTP_PORT in /etc/sysconfig/jenkins
  file { '/etc/sysconfig/jenkins':
    ensure => present,
  }
  file_line { 'Append a line to /etc/sysconfig/jenkins':
    path               => '/etc/sysconfig/jenkins',
    line               => "JENKINS_PORT=${port}",
    match              => '^JENKINS_PORT.*$',
    append_on_no_match => false,
    notify             => Service['jenkins'],
  }
  file_line { 'Append a line to /usr/lib/systemd/system/jenkins.service':
    path               => '/usr/lib/systemd/system/jenkins.service',
    line               => "Environment=\"JENKINS_PORT=${port}\"",
    match              => '^Environment="JENKINS_PORT.*$',
    append_on_no_match => false,
  }
  Exec { 'jenkins':
    command     => '/usr/bin/systemctl daemon-reload && /usr/bin/systemctl restart jenkins' ,
    user        => 'root',
    subscribe   => File_line['Append a line to /etc/sysconfig/jenkins'],
    refreshonly => true,
  }
}
