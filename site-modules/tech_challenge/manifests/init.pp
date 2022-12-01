# @summary 
#
# The module supports installing jenkins into centos 7 and ubuntu 20.04
# it will be configured to run on port 8000 for centos and 8011 for ubuntu
# changes required to make this happen within the code run and it will restart the service after
#
# @example
#   include tech_challenge
class tech_challenge {
  if ( $facts['operatingsystem'] == 'CentOS' and $facts['operatingsystemmajrelease'] == '7' ) {
    include tech_challenge::install_centos
    include tech_challenge::service
  }

  elsif ( $facts['operatingsystem'] == 'Ubuntu' and $facts['operatingsystemmajrelease'] == '20.04' ) {
    include tech_challenge::install_ubuntu
    include tech_challenge::service
  }

  else {
    notify { "${facts['operatingsystem']} ${facts['operatingsystemrelease']} ,Please only install on RHEL 7 / Centos7 / Ubuntu 20.04": }
  }
}
