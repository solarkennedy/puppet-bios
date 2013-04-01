class bios {
  case $boardmanufacturer {
    'Intel Corporation','Intel','Intel Corp.': {
      case $boardproductname {
      	'S5520UR',
      	'S5400SF',
      	'S2600GZ',
	: { include bios::intel $syscfg_command='/usr/local/sbin/syscfg' }
      	default:   { notify{ "I don't know how to handle $boardproductname on an $boardmanufacturer platform yet":} }
      } # End case boardproductname
    }
    'Dell Inc.': {
      case $productname {
        'PowerEdge C1100',
        'PowerEdge C2100',
        'PowerEdge C5125',
        'PowerEdge C5220',
        'PowerEdge C6100',
        'PowerEdge C6105',
        'PowerEdge C6145',
        'PowerEdge C6220',
        'PowerEdge C8220', }
         : { include bios::dell $setupbios_command='cd /usr/local/setupbios && /usr/local/setupbios/setupbios' }
      	default:   { notify{ "I don't know how to handle $boardproductname on an $boardmanufacturer platform yet":} }
      } # End case boardproductname
    }
    default: { notify { "I don't know how to handle $boardmanufacturer bios yet.": } }
  
  } #end case boardmanufacturer
}
