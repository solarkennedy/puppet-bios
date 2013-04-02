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
