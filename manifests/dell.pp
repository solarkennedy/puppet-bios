class bios::dell {
	file { "/var/cache/bios/": ensure => directory, }
}
class bios::dell::0nvh5d {
	package { dell-setupbios: ensure => latest, }
	
	cron { "bios-save": 
		command => "cd /usr/local/setupbios && /usr/local/setupbios/setupbios setting save > /var/cache/bios/settings.ini",
		special => "reboot",
	}
}
