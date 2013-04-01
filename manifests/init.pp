class bios {
	case $boardmanufacturer {

		'Intel Corporation','Intel','Intel Corp.': {
			include bios::intel
			case $boardproductname {
				'S5520UR': { include bios::intel::s5520ur $syscfg_command='cd /usr/local/syscfg/syscfg; /usr/local/syscfg/syscfg' }
				'S5400SF': { include bios::intel::s5400sf $syscfg_command='cd /usr/local/syscfg/syscfg; /usr/local/syscfg/syscfg' }
				'S2600GZ': { include bios::intel::s2600gz $syscfg_command='/usr/local/sbin/syscfg' }
				'Double Cove': { include bios::intel::doublecove }
				'Base Board Product Name' : { include bios::intel::other }
				default:   { notify{ "I don't know how to handle $boardproductname on an $boardmanufacturer platform yet":} }
			} # End case boardproductname

		}
		'Dell Inc.': {
			include bios::dell
			case $boardproductname {
				'0NVH5D' : { include bios::dell::0nvh5d $setupbios_command='cd /usr/local/setupbios && /usr/local/setupbios/setupbios' }
				default:   { notify{ "I don't know how to handle $boardproductname on an $boardmanufacturer platform yet":} }
			} # End case boardproductname
		}
		'Quanta': {
			include bios::quanta
			case $boardproductname {
				'Windmill-EP': { include bios::quanta::windmill_ep }
				default:   { notify{ "I don't know how to handle $boardproductname on an $boardmanufacturer platform yet":} }
			} # End case boardproductname
		}
		'Supermicro': {
			include bios::supermicro
			case $boardproductname {
				'H8DGU'   : { include bios::supermicro::h8dgu }
				'X7SPT-DF': { include bios::supermicro::x7spt_df }
				'X8DTN': { include bios::supermicro::x8dtn }
				default: { notify{ "I don't know how to handle $boardproductname on an $boardmanufacturer platform yet":} }
			} # End case boardproductname
		}
		default: { notify { "I don't know how to handle $boardmanufacturer bios yet.": } }

	} #end case boardmanufacturer

}

