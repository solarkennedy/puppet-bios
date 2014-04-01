# == Class: bios
#
# Full description of class bios here.
#
# === Parameters
#
# Document parameters here.
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
# === Variables
#
# Here you should define a list of variables that this module would require.
#
# [*sample_variable*]
#   Explanation of how this variable affects the funtion of this class and if it
#   has a default. e.g. "The parameter enc_ntp_servers must be set by the
#   External Node Classifier as a comma separated list of hostnames." (Note,
#   global variables should not be used in preference to class parameters  as of
#   Puppet 2.6.)
#
# === Examples
#
#  class { bios:
#    servers => [ 'pool.ntp.org', 'ntp.local.company.com' ]
#  }
#
# === Authors
#
# Author Name <author@domain.com>
#
# === Copyright
#
# Copyright 2013 Your name here, unless otherwise noted.
#


# Determine the hardware we are on is on the list of supported platforms
# If it isn't, that doesn't mean it won't work....
class bios {
  case $boardmanufacturer {
    'Intel Corporation','Intel','Intel Corp.': {
      case $boardproductname {
        'S5520UR',
        'S5400SF',
        'S2600GZ': { $make='Intel' }
        default:   { fail("I don't know if ${boardproductname} on an ${boardmanufacturer} works.") }
        # End case boardproductname
      }
    }
    'Dell Inc.','Dell': {
      case $productname {
        'PowerEdge C1100',
        'PowerEdge C2100',
        'PowerEdge C5125',
        'PowerEdge C5220',
        'PowerEdge C6100',
        'PowerEdge C6105',
        'PowerEdge C6145',
        'PowerEdge C6220',
        'PowerEdge C8220': { $make='Dell' }
        default:   { fail("I don't know if ${boardproductname} on an ${boardmanufacturer} works.") }
      } # End case boardproductname
    }
    default: { notify { "I don't know how to handle ${boardmanufacturer} bios yet.": } }

  } #end case boardmanufacturer
}
