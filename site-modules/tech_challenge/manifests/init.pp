# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tech_challenge
class tech_challenge {
  if $facts['operatingsystem'] == 'CentOS' and $facts['operatingsystemrelease'] == 7 {
    include tech_challenge::install_centos
    include tech_challenge::service
  }

  elsif $facts['operatingsystem'] == 'Ubuntu' and $facts['operatingsystemrelease'] == 20.04 {
    include tech_challenge::install_ubuntu
    include tech_challenge::service
  }

  else {
    warning('Please only install on Centos7 / Ubuntu 20.04')
  }
}
