# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include tech_challenge::service
class tech_challenge::service {
  service { 'jenkins':
    ensure  => running,
  }
}
