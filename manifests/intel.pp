class bios::intel {
	file { "/var/cache/bios/": ensure => directory, }
	if ( $operatingsystem == "RedHat" ) {
		package { [ "glibc.i686", "ncurses-libs-5.7-3.20090208.el6.i686", "libstdc++.i686" ]: ensure => latest, }
	}
}

class bios::intel::s5520ur {
	package { "intel-syscfg-s5520ur": ensure => latest, }
	exec { "/usr/local/syscfg/install-smi-drv": creates => "/usr/local/syscfg/drivers/smi.ko", }
	cron { "save-bios":
		command => "cd /usr/local/syscfg/ && /bin/rm -f /var/cache/bios/syscfg.INI && /usr/local/syscfg/syscfg /s /var/cache/bios/syscfg.INI",
		special => reboot,
	}
}

class bios::intel::s5400sf {
	package { "intel-syscfg-s5400sf": ensure => latest, }
	exec { "/usr/local/syscfg/install-smi-drv": creates => "/usr/local/syscfg/drivers/smi.ko", }
	cron { "save-bios":
		command => "cd /usr/local/syscfg/ && /bin/rm -f /var/cache/bios/syscfg.INI && /usr/local/syscfg/syscfg /s /var/cache/bios/syscfg.INI",
		special => reboot,
	}
}

class bios::intel::s2600gz {
	package { "intel-syscfg-s2600gz": ensure => latest, }
	cron { "save-bios":
		command => "cd /var/cache/bios/ && /bin/rm -f /var/cache/bios/syscfg.INI && /usr/local/sbin/syscfg /s",
		special => reboot,
	}
}

class bios::intel::doublecove {
}

class bios::intel::other {
}
