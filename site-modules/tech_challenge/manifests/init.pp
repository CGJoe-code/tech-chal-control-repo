# @summary A short summary of the purpose of this class
#
# A description of what this class does
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
